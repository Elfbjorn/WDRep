using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using WDRepApp.Server.Entities;
using WDRepApp.Server.DTOs;
using WDRepApp.Server.Services;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System;

namespace WDRepApp.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IdentityController : ControllerBase
    {
        private readonly WDRepDbContext _db;
        private readonly string _sek;
        private readonly ILogger<IdentityController> _logger;
        private readonly IIdentityService _identityService;

        public IdentityController(WDRepDbContext db, ILogger<IdentityController> logger, IIdentityService identityService)
        {
            _db = db;
            _logger = logger;
            _identityService = identityService;
            var sek = Environment.GetEnvironmentVariable("EAGLE_SEK");
            if (string.IsNullOrWhiteSpace(sek))
                throw new InvalidOperationException("EAGLE_SEK environment variable must be set for encryption.");
            _sek = sek;
        }

        [HttpGet("states/{countryId}")]
        public async Task<IActionResult> GetStates(int countryId)
        {
            // Find all states with parentId = countryId and GeographyType = 'state'
            var stateType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description.ToLower() == "state");
            if (stateType == null)
                return Ok(new List<object>());
            var states = await _db.Geography
                .Where(g => g.ParentId == countryId && g.GeographyTypeId == stateType.GeographyTypeId && g.RecordStatusId == 1)
                .OrderBy(g => g.GeographyName)
                .Select(g => new { geographyId = g.GeographyId, geographyName = g.GeographyName })
                .ToListAsync();
            return Ok(states);
        }

        [HttpGet("dropdowns")]
        public async Task<IActionResult> GetDropdowns()
        {
            // Countries
            var countries = await _db.Geography
                .Where(g => g.RecordStatusId == 1 && (g.GeographyTypeId == 3 || g.GeographyTypeId == 1))
                .OrderBy(g => g.GeographyName)
                .Select(g => new { geographyId = g.GeographyId, geographyName = g.GeographyName })
                .ToListAsync();

            // Prefixes
            var prefixes = await _db.PrefixSuffix
                .Where(p => p.RecordStatusId == 1 && p.Category.ToLower() == "prefix")
                .OrderBy(p => p.Description)
                .Select(p => new { prefixsuffixid = p.PrefixSuffixId, description = p.Description })
                .ToListAsync();

            // Suffixes
            var suffixes = await _db.PrefixSuffix
                .Where(s => s.RecordStatusId == 1 && s.Category.ToLower() == "suffix")
                .OrderBy(s => s.Description)
                .Select(s => new { prefixsuffixid = s.PrefixSuffixId, description = s.Description })
                .ToListAsync();

            // Sexes
            var sexes = await _db.Sexes
                .Where(s => s.RecordStatusId == 1)
                .OrderBy(s => s.Description)
                .Select(s => new { sexid = s.SexId, description = s.Description })
                .ToListAsync();



            // Email types (AppliesToEmail)
            var emailTypes = await _db.ContactTypes
                .Where(ct => ct.RecordStatusId == 1 && ct.AppliesToEmail)
                .OrderBy(ct => ct.ContactTypeName)
                .Select(ct => new { contactTypeId = ct.ContactTypeId, contactTypeName = ct.ContactTypeName })
                .ToListAsync();

            // Phone types (AppliesToPhone)
            var phoneTypes = await _db.ContactTypes
                .Where(ct => ct.RecordStatusId == 1 && ct.AppliesToPhone)
                .OrderBy(ct => ct.ContactTypeName)
                .Select(ct => new { contactTypeId = ct.ContactTypeId, contactTypeName = ct.ContactTypeName })
                .ToListAsync();

            // Address types (AppliesToPostalAddress)
            var addressTypes = await _db.ContactTypes
                .Where(ct => ct.RecordStatusId == 1 && ct.AppliesToPostalAddress)
                .OrderBy(ct => ct.ContactTypeName)
                .Select(ct => new { contactTypeId = ct.ContactTypeId, contactTypeName = ct.ContactTypeName })
                .ToListAsync();

            return Ok(new
            {
                countries,
                prefixes,
                suffixes,
                sexes,
                emailTypes,
                phoneTypes,
                addressTypes
            });
        }

        [HttpPost("ssn-from-token")]
        public async Task<IActionResult> GetSSNFromToken([FromBody] SsnTokenRequest request)
        {
            var token = request.Token;
            var sek = _sek;
            // 1. Look up the encrypted SSN by token
            var ssnToken = await _db.SsnTokens.FirstOrDefaultAsync(t => t.Token == token);
            if (ssnToken == null)
            {
                return NotFound(new { error = "Token not found" });
            }
            if (ssnToken.ExpiresAt <= DateTime.UtcNow)
            {
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
                return StatusCode(500, new { error = "Decryption failed", details = ex.Message });
            }
            return Ok(new { ssn = decryptedSsn });
        }

        [HttpGet("geography-parents/{geographyId}")]
        public async Task<IActionResult> GetGeographyParents(int geographyId)
        {
            _logger.LogInformation($"[GetGeographyParents] Fetching parents for GeographyId={geographyId}");
            var city = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == geographyId);
            if (city == null)
            {
                _logger.LogWarning($"[GetGeographyParents] City not found for GeographyId={geographyId}");
                return NotFound();
            }
            var state = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == city.ParentId);
            if (state == null)
            {
                _logger.LogWarning($"[GetGeographyParents] State not found for CityId={city.GeographyId}, ParentId={city.ParentId}");
            }
            var country = state != null ? await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == state.ParentId) : null;
            if (country == null)
            {
                _logger.LogWarning($"[GetGeographyParents] Country not found for StateId={state?.GeographyId}, ParentId={state?.ParentId}");
            }
            return Ok(new {
                city = new { id = city.GeographyId, name = city.GeographyName },
                state = state != null ? new { id = state.GeographyId, name = state.GeographyName } : null,
                country = country != null ? new { id = country.GeographyId, name = country.GeographyName } : null
            });
        }


        // adamDebug: Given a geographyId, returns city, state, country info for debugging
        private async Task<(string? cityName, int? cityId, string? stateName, int? stateId, string? countryName, int? countryId)> adamDebug(int geographyId)
        {
            _logger.LogInformation($"adamDebug: Starting with geographyId={geographyId}");
            var city = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == geographyId && g.RecordStatusId == 1);
            if (city == null)
            {
                _logger.LogWarning($"adamDebug: No city Geography found for id={geographyId}");
                return (null, null, null, null, null, null);
            }
            var cityType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.GeographyTypeId == city.GeographyTypeId && gt.RecordStatusId == 1);
            if (cityType == null || cityType.Description?.ToLower() != "city")
                return (null, null, null, null, null, null);
            if (!city.ParentId.HasValue)
                return (city.GeographyName, city.GeographyId, null, null, null, null);
            var state = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == city.ParentId.Value && g.RecordStatusId == 1);
            if (state == null)
                return (city.GeographyName, city.GeographyId, null, null, null, null);
            var stateType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.GeographyTypeId == state.GeographyTypeId && gt.RecordStatusId == 1);
            if (stateType == null || stateType.Description?.ToLower() != "state")
                return (city.GeographyName, city.GeographyId, null, null, null, null);
            if (!state.ParentId.HasValue)
                return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, null, null);
            var country = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == state.ParentId.Value && g.RecordStatusId == 1);
            if (country == null)
                return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, null, null);
            var countryType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.GeographyTypeId == country.GeographyTypeId && gt.RecordStatusId == 1);
            if (countryType == null || countryType.Description?.ToLower() != "country")
                return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, null, null);
            return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, country.GeographyName, country.GeographyId);
        }


        [HttpPost("check-ssn")]
        public async Task<IActionResult> CheckSSN([FromBody] string ssn)
        {
            // Normalize and validate SSN
            var normalized = Regex.Replace(ssn ?? "", "[^0-9]", "");
            if (!Regex.IsMatch(normalized, "^\\d{9}$"))
                return BadRequest("Invalid SSN format");

            // Query using decryption in SQL, handle wrong key/corrupt data
            dynamic? match = null;
            try
            {
                match = await _db.CoreIdentity
                    .FromSqlRaw(@"
                        SELECT * FROM coreidentity
                        WHERE pgp_sym_decrypt(ssn::bytea, {0}::text) = {1}::text
                        LIMIT 1
                    ", _sek, normalized)
                    .AsNoTracking()
                    .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Decryption failed: wrong key or corrupt data");
                return StatusCode(500, "Decryption failed: wrong key or corrupt data");
            }

            Guid token = Guid.NewGuid();
            var nowUtc = DateTime.UtcNow;
            var expiresAtUtc = nowUtc.AddMinutes(10);
            await _db.Database.ExecuteSqlRawAsync(@"
                INSERT INTO ssn_tokens (token, encrypted_ssn, created_at, expires_at)
                VALUES ({0}, pgp_sym_encrypt({1}::text, {2}::text), {3}, {4})
            ", token, normalized, _sek, nowUtc, expiresAtUtc);

            if (match == null)
            {
                return Ok(new { found = false, token });
            }
            return Ok(new { found = true, token });
        }

        [HttpPost("create-or-update")]
        public async Task<IActionResult> CreateOrUpdateIdentity([FromBody] CreateIdentityRequest request)
        {
            if (request == null)
            {
                return BadRequest("Request cannot be null");
            }

            var response = await _identityService.CreateOrUpdateIdentityAsync(request, request.SsnToken);
            
            if (!response.Success)
            {
                return BadRequest(response);
            }

            return Ok(response);
        }

        public class SsnTokenRequest
        {
            public Guid Token { get; set; }
        }
    }
}

