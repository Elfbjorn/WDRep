using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using WDRepApp.Server.Entities;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System;

namespace WDRepApp.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GeographyController : ControllerBase
    {
        private readonly WDRepDbContext _db;
        public GeographyController(WDRepDbContext db)
        {
            _db = db;
        }

        // GET: /api/geography/find-or-create?name=CityName&type=city&parentId=123
        [HttpGet("find-or-create")]
        public async Task<IActionResult> FindOrCreate(string name, string type, int parentId)
        {
            if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(type) || parentId <= 0)
                return BadRequest(new { error = "Missing or invalid parameters." });

            var geoType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == type.ToLower());
            if (geoType == null)
                return BadRequest(new { error = $"Geography type '{type}' not found." });

            var normalized = Regex.Replace(name.Trim().ToLowerInvariant(), "[^a-z]", "");
            var possible = await _db.Geography
                .Where(g => g.GeographyTypeId == geoType.GeographyTypeId && g.ParentId == parentId)
                .ToListAsync();
            var match = possible.FirstOrDefault(g =>
                !string.IsNullOrWhiteSpace(g.GeographyName) &&
                Regex.Replace(g.GeographyName.Trim().ToLowerInvariant(), "[^a-z]", "") == normalized);
            if (match != null)
            {
                return Ok(new { geographyId = match.GeographyId, geographyName = match.GeographyName });
            }
            // Create new city
            var geo = new Geography
            {
                GeographyName = name.Trim(),
                GeographyTypeId = geoType.GeographyTypeId,
                ParentId = parentId,
                RecordStatusId = 1
            };
            _db.Geography.Add(geo);
            await _db.SaveChangesAsync();
            return Ok(new { geographyId = geo.GeographyId, geographyName = geo.GeographyName });
        }

        // GET: /api/geography/{id}/hierarchy
        [HttpGet("{id}/hierarchy")]
        public async Task<IActionResult> GetHierarchy(int id)
        {
            var city = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == id);
            if (city == null)
                return NotFound();
            var state = city.ParentId.HasValue ? await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == city.ParentId.Value) : null;
            var country = state?.ParentId != null ? await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == state.ParentId.Value) : null;
            // If no state, try to get country directly
            if (country == null && city.ParentId.HasValue)
                country = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == city.ParentId.Value);
            return Ok(new {
                city = city != null ? new { city.GeographyId, city.GeographyName } : null,
                state = state != null ? new { state.GeographyId, state.GeographyName } : null,
                country = country != null ? new { country.GeographyId, country.GeographyName } : null
            });
        }
    }
}
