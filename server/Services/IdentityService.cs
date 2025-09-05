using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using WDRepApp.Server.DTOs;
using WDRepApp.Server.Entities;
using System.Text.RegularExpressions;

namespace WDRepApp.Server.Services
{
    public interface IIdentityService
    {
        Task<CreateIdentityResponse> CreateOrUpdateIdentityAsync(CreateIdentityRequest request, Guid ssnToken);
        Task<CoreIdentity?> FindIdentityBySsnAsync(string ssn);
    }

    public class IdentityService : IIdentityService
    {
        private readonly WDRepDbContext _db;
        private readonly string _sek;
        private readonly ILogger<IdentityService> _logger;

        public IdentityService(WDRepDbContext db, ILogger<IdentityService> logger)
        {
            _db = db;
            _logger = logger;
            var sek = Environment.GetEnvironmentVariable("EAGLE_SEK");
            if (string.IsNullOrWhiteSpace(sek))
                throw new InvalidOperationException("EAGLE_SEK environment variable must be set for encryption.");
            _sek = sek;
        }

        public async Task<CoreIdentity?> FindIdentityBySsnAsync(string ssn)
        {
            // Normalize SSN
            var normalized = Regex.Replace(ssn ?? "", "[^0-9]", "");
            if (!Regex.IsMatch(normalized, "^\\d{9}$"))
                return null;

            try
            {
                var identity = await _db.CoreIdentity
                    .FromSqlRaw(@"
                        SELECT * FROM coreidentity
                        WHERE pgp_sym_decrypt(ssn::bytea, {0}::text) = {1}::text
                        LIMIT 1
                    ", _sek, normalized)
                    .AsNoTracking()
                    .FirstOrDefaultAsync();

                return identity;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to find identity by SSN: wrong key or corrupt data");
                return null;
            }
        }

        public async Task<CreateIdentityResponse> CreateOrUpdateIdentityAsync(CreateIdentityRequest request, Guid ssnToken)
        {
            try
            {
                // Validate SSN token and get decrypted SSN
                var decryptedSsn = await ValidateTokenAndGetSsnAsync(ssnToken);
                if (decryptedSsn == null)
                {
                    return new CreateIdentityResponse 
                    { 
                        Success = false, 
                        Error = "Invalid or expired SSN token" 
                    };
                }

                // Check for existing identity with this SSN
                var existingIdentity = await FindIdentityBySsnAsync(decryptedSsn);
                
                if (existingIdentity != null)
                {
                    // Update existing identity
                    return await UpdateExistingIdentityAsync(existingIdentity, request, decryptedSsn);
                }
                else
                {
                    // Create new identity
                    return await CreateNewIdentityAsync(request, decryptedSsn);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to create or update identity");
                return new CreateIdentityResponse 
                { 
                    Success = false, 
                    Error = $"An error occurred: {ex.Message}" 
                };
            }
        }

        private async Task<string?> ValidateTokenAndGetSsnAsync(Guid token)
        {
            // Look up the encrypted SSN by token
            var ssnToken = await _db.SsnTokens.FirstOrDefaultAsync(t => t.Token == token);
            if (ssnToken == null || ssnToken.ExpiresAt <= DateTime.UtcNow)
            {
                if (ssnToken != null)
                {
                    _db.SsnTokens.Remove(ssnToken);
                    await _db.SaveChangesAsync();
                }
                return null;
            }

            // Delete the token for one-time use
            _db.SsnTokens.Remove(ssnToken);
            await _db.SaveChangesAsync();

            // Decrypt the SSN
            try
            {
                using var cmd = _db.Database.GetDbConnection().CreateCommand();
                cmd.CommandText = "SELECT pgp_sym_decrypt(@ssn, @sek)";
                var paramSsn = cmd.CreateParameter();
                paramSsn.ParameterName = "@ssn";
                paramSsn.Value = ssnToken.EncryptedSsn;
                cmd.Parameters.Add(paramSsn);
                var paramSek = cmd.CreateParameter();
                paramSek.ParameterName = "@sek";
                paramSek.Value = _sek;
                cmd.Parameters.Add(paramSek);
                await _db.Database.OpenConnectionAsync();
                var result = await cmd.ExecuteScalarAsync();
                return result?.ToString();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to decrypt SSN from token");
                return null;
            }
        }

        private async Task<CreateIdentityResponse> CreateNewIdentityAsync(CreateIdentityRequest request, string ssn)
        {
            var identity = new CoreIdentity
            {
                PreferredName = request.PreferredName,
                FirstName = request.FirstName,
                MiddleName = request.MiddleName,
                LastName = request.LastName,
                Dob = DateTime.TryParse(request.Dob, out var dob) ? dob : null,
                PrefixId = request.PrefixId,
                SuffixId = request.SuffixId,
                SexId = request.SexId,
                // Set default values as per entity defaults
                RecordStatusId = 1, // Active
                CreatedBy = 2,
                CreatedIp = "::0",
                ModifiedBy = 2,
                ModifiedIp = "::0"
            };

            // Encrypt and set SSN using raw SQL
            await _db.Database.ExecuteSqlRawAsync(@"
                INSERT INTO coreidentity (preferredname, firstname, middlename, lastname, ssn, dob, prefixid, suffixid, sexid, recordstatusid, createdby, createdip, modifiedby, modifiedip)
                VALUES ({0}, {1}, {2}, {3}, pgp_sym_encrypt({4}::text, {5}::text), {6}, {7}, {8}, {9}, {10}, {11}, {12}, {13}, {14})
            ", 
                identity.PreferredName, 
                identity.FirstName, 
                identity.MiddleName, 
                identity.LastName, 
                ssn, 
                _sek, 
                identity.Dob, 
                identity.PrefixId, 
                identity.SuffixId, 
                identity.SexId, 
                identity.RecordStatusId, 
                identity.CreatedBy, 
                identity.CreatedIp, 
                identity.ModifiedBy, 
                identity.ModifiedIp);

            // Get the created identity ID
            var createdIdentity = await FindIdentityBySsnAsync(ssn);
            
            _logger.LogInformation($"Created new identity with ID: {createdIdentity?.CoreIdentityId}");
            
            return new CreateIdentityResponse 
            { 
                Success = true, 
                CoreIdentityId = createdIdentity?.CoreIdentityId ?? 0 
            };
        }

        private async Task<CreateIdentityResponse> UpdateExistingIdentityAsync(CoreIdentity existingIdentity, CreateIdentityRequest request, string ssn)
        {
            // Update the existing identity using raw SQL to handle encrypted SSN
            await _db.Database.ExecuteSqlRawAsync(@"
                UPDATE coreidentity 
                SET preferredname = {0}, firstname = {1}, middlename = {2}, lastname = {3}, 
                    dob = {4}, prefixid = {5}, suffixid = {6}, sexid = {7}, 
                    modifiedby = {8}, modifiedip = {9}
                WHERE coreidentityid = {10}
            ", 
                request.PreferredName ?? existingIdentity.PreferredName,
                request.FirstName ?? existingIdentity.FirstName,
                request.MiddleName ?? existingIdentity.MiddleName,
                request.LastName ?? existingIdentity.LastName,
                DateTime.TryParse(request.Dob, out var dob) ? dob : existingIdentity.Dob,
                request.PrefixId ?? existingIdentity.PrefixId,
                request.SuffixId ?? existingIdentity.SuffixId,
                request.SexId ?? existingIdentity.SexId,
                2, // ModifiedBy
                "::0", // ModifiedIp
                existingIdentity.CoreIdentityId);

            _logger.LogInformation($"Updated existing identity with ID: {existingIdentity.CoreIdentityId}");
            
            return new CreateIdentityResponse 
            { 
                Success = true, 
                CoreIdentityId = existingIdentity.CoreIdentityId 
            };
        }
    }
}