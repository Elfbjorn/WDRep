using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using WDRepApp.Entities;

namespace WDRepApp.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DefaultItemsController : ControllerBase
    {
        private readonly WDRepDbContext _context;
        public DefaultItemsController(WDRepDbContext context)
        {
            _context = context;
        }

        // GET: api/defaultitems?page=check-ssn&tab=
        [HttpGet]
        public async Task<IActionResult> GetDefaultItem([FromQuery] string page, [FromQuery] string? tab)
        {
            if (string.IsNullOrWhiteSpace(page))
                return BadRequest("Page is required");

            var item = await _context.DefaultItems
                .Where(d => d.DefaultItemPage == page && (d.DefaultItemTab == tab || (d.DefaultItemTab == null && (tab == null || tab == ""))))
                .OrderByDescending(d => d.DefaultItemTab != null) // Prefer exact tab match
                .FirstOrDefaultAsync();

            if (item == null)
                return NotFound();

            return Ok(item);
        }
    }
}
