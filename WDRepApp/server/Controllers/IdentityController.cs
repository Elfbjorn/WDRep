
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using WDRepApp.Server.Entities;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System;

public class SsnTokenRequest
{
    public Guid Token { get; set; }
}

namespace WDRepApp.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IdentityController : ControllerBase
    {
        private readonly WDRepDbContext _db;
        public IdentityController(WDRepDbContext db)
        {
            _db = db;
        }

    [HttpPost("check-ssn")]
        public async Task<IActionResult> CheckSSN([FromBody] string ssn)
        {
            // Normalize and validate SSN
            var normalized = Regex.Replace(ssn ?? "", "[^0-9]", "");
            if (!Regex.IsMatch(normalized, "^\\d{9}$"))
                return BadRequest("Invalid SSN format");

            var sek = Environment.GetEnvironmentVariable("EAGLE_SEK") ?? "test_secret";

            // Query using decryption in SQL
            var match = await _db.CoreIdentity
                .FromSqlRaw(@"
                    SELECT * FROM coreidentity
                    WHERE pgp_sym_decrypt(ssn, {0}) = {1}
                    LIMIT 1
                ", sek, normalized)
                .AsNoTracking()
                .FirstOrDefaultAsync();

            if (match == null)
            {
                // Generate a token and store encrypted SSN in ssn_tokens
                var token = Guid.NewGuid();
                await _db.Database.ExecuteSqlRawAsync(@"
                    INSERT INTO ssn_tokens (token, encrypted_ssn, expires_at)
                    VALUES ({0}, pgp_sym_encrypt({1}, {2}), now() + interval '10 minutes')
                ", token, normalized, sek);
                return Ok(new { found = false, token });
            }
            return Ok(new {
                coreidentityid = match.CoreIdentityId,
                found = true,
                firstname = match.FirstName,
                middlename = match.MiddleName,
                lastname = match.LastName,
                ssn = match.Ssn,
                dob = match.Dob,
                prefixid = match.PrefixId,
                suffixid = match.SuffixId,
                sexid = match.SexId,
                placeofbirthid = match.PlaceOfBirthId
            });
        }

        [HttpPost("ssn-from-token")]
        public async Task<IActionResult> GetSSNFromToken([FromBody] SsnTokenRequest request)
        {
            var token = request.Token;
            var sek = Environment.GetEnvironmentVariable("EAGLE_SEK") ?? "test_secret";
            // 1. Look up the encrypted SSN by token
            var ssnToken = await _db.SsnTokens.FirstOrDefaultAsync(t => t.Token == token);
            if (ssnToken == null)
            {
                Console.WriteLine($"[GetSSNFromToken] Token not found: {token}");
                return NotFound(new { error = "Token not found" });
            }
            if (ssnToken.ExpiresAt <= DateTime.UtcNow)
            {
                Console.WriteLine($"[GetSSNFromToken] Token expired: {token}, expires_at={ssnToken.ExpiresAt}, now={DateTime.UtcNow}");
                // Optionally, delete expired token
                _db.SsnTokens.Remove(ssnToken);
                await _db.SaveChangesAsync();
                return NotFound(new { error = "Token expired" });
            }

            // 2. Delete the token for one-time use
            _db.SsnTokens.Remove(ssnToken);
            await _db.SaveChangesAsync();

            // 3. Decrypt the SSN using raw SQL (since EF can't call pgp_sym_decrypt directly)
            string? decryptedSsn = null;
            try
            {
                using (var cmd = _db.Database.GetDbConnection().CreateCommand())
                {
                    cmd.CommandText = "SELECT pgp_sym_decrypt(@ssn, @sek)";
                    var paramSsn = cmd.CreateParameter();
                    paramSsn.ParameterName = "@ssn";
                    paramSsn.Value = ssnToken.EncryptedSsn;
                    cmd.Parameters.Add(paramSsn);
                    var paramSek = cmd.CreateParameter();
                    paramSek.ParameterName = "@sek";
                    paramSek.Value = sek;
                    cmd.Parameters.Add(paramSek);
                    await _db.Database.OpenConnectionAsync();
                    var result = await cmd.ExecuteScalarAsync();
                    decryptedSsn = result?.ToString();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[GetSSNFromToken] Exception during decryption: {ex.Message}");
                return StatusCode(500, new { error = "Decryption failed", details = ex.Message });
            }
            Console.WriteLine($"[GetSSNFromToken] Success for token: {token}");
            return Ok(new { ssn = decryptedSsn });
        }

        [HttpGet("dropdowns")]
        public async Task<IActionResult> GetDropdowns()
        {
            var prefixes = await _db.PrefixSuffix
                .FromSqlRaw(@"select prefixsuffixid, description, category, recordstatusid from prefixsuffix where recordstatusid = 1 and category = 'Prefix';")
                .ToListAsync();
            var suffixes = await _db.PrefixSuffix
                .FromSqlRaw(@"select prefixsuffixid, description, category, recordstatusid from prefixsuffix where recordstatusid = 1 and category = 'Suffix';")
                .ToListAsync();
            var sexes = await _db.Sexes
                .FromSqlRaw(@"select sexid, description, recordstatusid from sexes where recordstatusid = 1 order by description;")
                .ToListAsync();
            var emailTypes = await _db.ContactTypes
                .FromSqlRaw(@"select contacttypeid, contacttypename, recordstatusid from contacttypes where recordstatusid = 1 and appliestoemail = TRUE;")
                .ToListAsync();
            var phoneTypes = await _db.ContactTypes
                .FromSqlRaw(@"select contacttypeid, contacttypename, recordstatusid from contacttypes where recordstatusid = 1 and appliestophone = TRUE;")
                .ToListAsync();
            var addressTypes = await _db.ContactTypes
                .FromSqlRaw(@"select contacttypeid, contacttypename, recordstatusid from contacttypes where recordstatusid = 1 and appliestopostaladdress = TRUE;")
                .ToListAsync();

            var countryType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "country");
            var countries = new List<Geography>();
            if (countryType != null) {
                countries = await _db.Geography
                    .Where(x => x.RecordStatusId == 1 && x.GeographyTypeId == countryType.GeographyTypeId)
                    .OrderBy(x => x.GeographyName)
                    .ToListAsync();
            }

            return Ok(new {
                prefixes,
                suffixes,
                sexes,
                countries,
                emailTypes,
                phoneTypes,
                addressTypes
            });
        }

        [HttpGet("states/{countryId}")]
        public async Task<IActionResult> GetStates(int countryId)
        {
            var stateType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "state");
            if (stateType == null)
            {
                return Ok(new List<Geography>());
            }

            var states = await _db.Geography
                .Where(g => g.RecordStatusId == 1 && g.ParentId == countryId && g.GeographyTypeId == stateType.GeographyTypeId)
                .OrderBy(g => g.GeographyName)
                .ToListAsync();

            return Ok(states);
        }

        [HttpGet("{coreIdentityId}/primary-email")]
        public async Task<IActionResult> GetPrimaryEmail(int coreIdentityId)
        {
            var email = await (from e in _db.Emails
                               join ce in _db.CoreIdentityEmails on e.EmailId equals ce.EmailId
                               where ce.RecordStatusId == 1 &&
                                     ce.CoreIdentityId == coreIdentityId &&
                                     ce.ContactSequence == 1
                               select e).FirstOrDefaultAsync();
            return email == null ? NotFound() : Ok(email);
        }

        [HttpGet("{coreIdentityId}/primary-phone")]
        public async Task<IActionResult> GetPrimaryPhone(int coreIdentityId)
        {
            var phone = await (from p in _db.Phones
                               join cp in _db.CoreIdentityPhones on p.PhoneId equals cp.PhoneId
                               where cp.RecordStatusId == 1 &&
                                     cp.CoreIdentityId == coreIdentityId &&
                                     cp.ContactSequence == 1
                               select p).FirstOrDefaultAsync();
            return phone == null ? NotFound() : Ok(phone);
        }

        [HttpGet("{coreIdentityId}/primary-address")]
        public async Task<IActionResult> GetPrimaryAddress(int coreIdentityId)
        {
            var address = await (from a in _db.PostalAddresses
                                 join cpa in _db.CoreIdentityPostalAddresses on a.PostalAddressId equals cpa.PostalAddressId
                                 where cpa.RecordStatusId == 1 &&
                                       cpa.CoreIdentityId == coreIdentityId &&
                                       cpa.ContactSequence == 1
                                 select a).FirstOrDefaultAsync();
            return address == null ? NotFound() : Ok(address);
        }
    }
}
