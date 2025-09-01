using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Npgsql;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using WDRep.Server.Data; // Replace with your actual namespace for DbContext

namespace server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LookupController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly WdrepDbContext _context;

        public LookupController(IConfiguration config, WdrepDbContext context)
        {
            _config = config;
            _context = context;
        }

        [HttpGet("prefixsuffix")]
        public IActionResult GetPrefixSuffix([FromQuery] string type)
        {
            var connString = _config.GetConnectionString("DefaultConnection");
            var results = new List<object>();
            using var conn = new NpgsqlConnection(connString);
            conn.Open();
            using var cmd = new NpgsqlCommand("SELECT prefixsuffixid, description, category FROM prefixsuffix WHERE category = @type", conn);
            cmd.Parameters.AddWithValue("@type", type);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                results.Add(new {
                    id = reader["prefixsuffixid"],
                    description = reader["description"],
                    category = reader["category"]
                });
            }
            return Ok(results);
        }

        [HttpGet("countries")]
        public async Task<IActionResult> GetCountries()
        {
            var countries = await _context.Geography
                .Where(g => g.GeographyTypeId == countryTypeId) // countryTypeId should be set appropriately
                .Select(g => new { id = g.GeographyId, name = g.GeographyName })
                .ToListAsync();

            return Ok(countries);
        }

        [HttpGet("states")]
        public async Task<IActionResult> GetStates(int countryId)
        {
            var states = await _context.Geography
                .Where(g => g.ParentId == countryId && g.GeographyTypeId == stateTypeId) // stateTypeId should be set appropriately
                .Select(g => new { id = g.GeographyId, name = g.GeographyName })
                .ToListAsync();

            return Ok(states);
        }
    }
}
