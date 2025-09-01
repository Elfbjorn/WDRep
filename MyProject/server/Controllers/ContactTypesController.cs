using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Npgsql;

namespace server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContactTypesController : ControllerBase
    {
        private readonly IConfiguration _config;
        public ContactTypesController(IConfiguration config)
        {
            _config = config;
        }

        [HttpGet]
        public IActionResult GetContactTypes()
        {
            var connString = _config.GetConnectionString("DefaultConnection");
            var results = new List<object>();
            using var conn = new NpgsqlConnection(connString);
            conn.Open();
            using var cmd = new NpgsqlCommand("SELECT contacttypeid, contacttypename, description FROM contacttypes ORDER BY contacttypename", conn);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                results.Add(new {
                    id = reader["contacttypeid"],
                    name = reader["contacttypename"],
                    description = reader["description"]
                });
            }
            return Ok(results);
        }
    }
}
