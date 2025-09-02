using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Entities;

namespace WDRepApp.Server.Data
{
    public class WDRepDbContext : DbContext
    {
    public WDRepDbContext(DbContextOptions<WDRepDbContext> options) : base(options) { }

    public DbSet<WDRepApp.Server.Entities.SsnToken> SsnTokens { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<WDRepApp.Server.Entities.SsnToken>().ToTable("ssn_tokens");
            modelBuilder.Entity<WDRepApp.Server.Entities.SsnToken>().HasKey(t => t.Token);
            modelBuilder.Entity<WDRepApp.Server.Entities.SsnToken>().Property(t => t.Token).HasColumnName("token");
            modelBuilder.Entity<WDRepApp.Server.Entities.SsnToken>().Property(t => t.EncryptedSsn).HasColumnName("encrypted_ssn");
            modelBuilder.Entity<WDRepApp.Server.Entities.SsnToken>().Property(t => t.CreatedAt).HasColumnName("created_at");
            modelBuilder.Entity<WDRepApp.Server.Entities.SsnToken>().Property(t => t.ExpiresAt).HasColumnName("expires_at");
        }
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
