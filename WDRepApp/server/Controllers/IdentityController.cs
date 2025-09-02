using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using WDRepApp.Server.Entities;
using System.Text.RegularExpressions;

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

            // The original implementation fetched all records and filtered in memory, which is a major performance anti-pattern.
            // This is corrected by running a filter on the database side.
            // This assumes SSNs in the DB are either stored as raw digits (XXXXXXXXX) or formatted (XXX-XX-XXXX),
            // which is a reasonable assumption given the frontend's formatting logic.
            var formattedSsn = $"{normalized.Substring(0, 3)}-{normalized.Substring(3, 2)}-{normalized.Substring(5, 4)}"; // PascalCase properties
            var match = await _db.CoreIdentity.FirstOrDefaultAsync(x => x.Ssn == normalized || x.Ssn == formattedSsn);

            if (match == null)
                return Ok(new { found = false });
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
