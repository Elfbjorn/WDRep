using Microsoft.AspNetCore.Mvc;
using Npgsql;
using Microsoft.Extensions.Configuration;

namespace server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HealthController : ControllerBase
    {
        private readonly IConfiguration _config;
        public HealthController(IConfiguration config)
        {
            _config = config;
        }

        [HttpGet("db-status")]
        public IActionResult GetDbStatus()
        {
            var connString = _config.GetConnectionString("DefaultConnection");
            try
            {
                using var conn = new NpgsqlConnection(connString);
                conn.Open();
                return Ok(new { status = "Database is reachable" });
            }
            catch
            {
                return StatusCode(500, new { status = "Database is NOT reachable" });
            }
        }
    }
}
