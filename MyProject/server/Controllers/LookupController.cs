using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Npgsql;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using WDRep.Server.Data;
using WDRep.Server.Entities;

namespace WDRep.Server.Controllers
{
    [ApiController]
    [Route("api/lookup")]
    public class LookupController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly WDRepDbContext _context;

        public LookupController(IConfiguration config, WDRepDbContext context)
        {
            _config = config;
            _context = context;
        }

        [HttpGet("prefixsuffix")]
        public async Task<IActionResult> GetPrefixSuffix([FromQuery] string type)
        {
            var items = await _context.PrefixSuffix
                .Where(p => p.Category == type && p.RecordStatusId == 1)
                .Select(p => new { id = p.PrefixSuffixId, description = p.Description })
                .ToListAsync();
            return Ok(items);
        }

        [HttpGet("countries")]
        public async Task<IActionResult> GetCountries()
        {
            var countries = await _context.Geography
                .Where(g => g.GeographyTypeId == 1 && g.RecordStatusId == 1)
                .Select(g => new { id = g.GeographyId, name = g.GeographyName })
                .ToListAsync();
            return Ok(countries);
        }

        [HttpGet("states")]
        public async Task<IActionResult> GetStates([FromQuery] int countryId)
        {
            var states = await _context.Geography
                .Where(g => g.GeographyTypeId == 2 && g.ParentId == countryId && g.RecordStatusId == 1)
                .Select(g => new { id = g.GeographyId, name = g.GeographyName })
                .ToListAsync();
            return Ok(states);
        }

        [HttpGet("cities")]
        public async Task<IActionResult> GetCities([FromQuery] int stateId)
        {
            var cities = await _context.Geography
                .Where(g => g.GeographyTypeId == 3 && g.ParentId == stateId && g.RecordStatusId == 1)
                .Select(g => new { id = g.GeographyId, name = g.GeographyName })
                .ToListAsync();
            return Ok(cities);
        }

        [HttpGet("contacttypes")]
        public async Task<IActionResult> GetContactTypes([FromQuery] string appliesTo)
        {
            if (string.IsNullOrWhiteSpace(appliesTo))
                return BadRequest("appliesTo parameter is required.");

            IQueryable<ContactType> query = _context.ContactTypes.Where(ct => ct.RecordStatusID == 1);

            switch (appliesTo.ToLowerInvariant())
            {
                case "email":
                    query = query.Where(ct => ct.AppliesToEmail);
                    break;
                case "phone":
                    query = query.Where(ct => ct.AppliesToPhone);
                    break;
                case "postaladdress":
                    query = query.Where(ct => ct.AppliesToPostalAddress);
                    break;
                case "socialmedia":
                    query = query.Where(ct => ct.AppliesToSocialMedia);
                    break;
                case "website":
                    query = query.Where(ct => ct.AppliesToWebsite);
                    break;
                default:
                    return BadRequest("Invalid appliesTo parameter.");
            }

            var types = await query
                .Select(ct => new { id = ct.ContactTypeId, name = ct.ContactTypeName })
                .ToListAsync();

            return Ok(types);
        }
    }
}
