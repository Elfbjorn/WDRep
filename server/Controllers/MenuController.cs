using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using System.Linq;
using System.Threading.Tasks;

namespace WDRepApp.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MenuController : ControllerBase
    {
        private readonly WDRepDbContext _context;
        public MenuController(WDRepDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetMenu()
        {
            var menu = await (from m in _context.MenuItems
                              join mt in _context.MenuItemTypes on m.menuitemtypeid equals mt.menuitemtypeid
                              where m.recordstatusid == 1 && mt.recordstatusid == 1
                              orderby m.sequenceid
                              select new
                              {
                                  m.menuitemid,
                                  m.menuitemname,
                                  menuitemtypename = mt.menuitemtypename,
                                  m.parentid,
                                  m.immediatelink,
                                  m.nextlink,
                                  m.cancellink,
                                  m.previouslink,
                                  m.cancellinktext,
                                  m.nextlinktext,
                                  m.previouslinktext
                              }).ToListAsync();
            return Ok(menu);
        }
    }
}
