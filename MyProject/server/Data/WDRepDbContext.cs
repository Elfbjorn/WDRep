using Microsoft.EntityFrameworkCore;
using WDRep.Server.Entities;

namespace WDRep.Server.Data
{
    public class WDRepDbContext : DbContext
    {
        public WDRepDbContext(DbContextOptions<WDRepDbContext> options) : base(options) { }

        public DbSet<ContactType> ContactTypes { get; set; }
        public DbSet<PrefixSuffix> PrefixSuffix { get; set; }
        public DbSet<Geography> Geography { get; set; }
    }
}