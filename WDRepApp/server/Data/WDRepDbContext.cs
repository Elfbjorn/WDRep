using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Entities;

namespace WDRepApp.Server.Data
{
    public class WDRepDbContext : DbContext
    {
        public WDRepDbContext(DbContextOptions<WDRepDbContext> options) : base(options) { }
        // FIX: Use PascalCase for all DbSet properties and Entity types
    public DbSet<CoreIdentity> CoreIdentity { get; set; }
    public DbSet<PrefixSuffix> PrefixSuffix { get; set; }
    public DbSet<Geography> Geography { get; set; }
    public DbSet<Sex> Sexes { get; set; }
    public DbSet<ContactType> ContactTypes { get; set; }
    public DbSet<GeographyType> GeographyTypes { get; set; }
    public DbSet<Email> Emails { get; set; }
    public DbSet<Phone> Phones { get; set; }
    public DbSet<PostalAddress> PostalAddresses { get; set; }
    public DbSet<CoreIdentityEmail> CoreIdentityEmails { get; set; }
    public DbSet<CoreIdentityPhone> CoreIdentityPhones { get; set; }
    public DbSet<CoreIdentityPostalAddress> CoreIdentityPostalAddresses { get; set; }
    }
}
