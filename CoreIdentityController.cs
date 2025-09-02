using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace MyProject.Api.Controllers
{
    [ApiController]
    [Route("api/coreidentity")]
    public class CoreIdentityController : ControllerBase
    {
        [HttpGet("by-ssn/{ssn}")]
        public Task<IActionResult> GetBySsn(string ssn)
        {
            // This is a placeholder implementation.
            // In a real-world scenario, this would look up the SSN in a database.
            if (string.IsNullOrWhiteSpace(ssn))
            {
                return Task.FromResult<IActionResult>(BadRequest("SSN must be provided."));
            }

            // For demonstration, we can simulate a "not found" case for a specific SSN.
            if (ssn == "000-00-0000")
            {
                return Task.FromResult<IActionResult>(NotFound());
            }

            var identity = new
            {
                Ssn = ssn,
                FirstName = "John",
                LastName = "Doe"
            };

            return Task.FromResult<IActionResult>(Ok(identity));
        }
    }
}