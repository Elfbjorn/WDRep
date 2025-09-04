using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WDRepApp.Server.Data;
using WDRepApp.Server.Entities;
using WDRepApp.Server.DTOs;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System;

namespace WDRepApp.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IdentityController : ControllerBase
    {
        [HttpGet("geography-parents/{geographyId}")]
        public async Task<IActionResult> GetGeographyParents(int geographyId)
        {
            _logger.LogInformation($"[GetGeographyParents] Fetching parents for GeographyId={geographyId}");
            var city = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == geographyId);
            if (city == null)
            {
                _logger.LogWarning($"[GetGeographyParents] City not found for GeographyId={geographyId}");
                return NotFound();
            }
            var state = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == city.ParentId);
            if (state == null)
            {
                _logger.LogWarning($"[GetGeographyParents] State not found for CityId={city.GeographyId}, ParentId={city.ParentId}");
            }
            var country = state != null ? await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == state.ParentId) : null;
            if (country == null)
            {
                _logger.LogWarning($"[GetGeographyParents] Country not found for StateId={state?.GeographyId}, ParentId={state?.ParentId}");
            }
            return Ok(new {
                city = new { id = city.GeographyId, name = city.GeographyName },
                state = state != null ? new { id = state.GeographyId, name = state.GeographyName } : null,
                country = country != null ? new { id = country.GeographyId, name = country.GeographyName } : null
            });
        }
        // adamDebug: Given a geographyId, returns city, state, country info for debugging
        private async Task<(string? cityName, int? cityId, string? stateName, int? stateId, string? countryName, int? countryId)> adamDebug(int geographyId)
        {
            _logger.LogInformation($"adamDebug: Starting with geographyId={geographyId}");
            // Step 1: Query for city
            _logger.LogInformation($"adamDebug: Querying city Geography for id={geographyId}");
            var city = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == geographyId && g.RecordStatusId == 1);
            if (city == null)
            {
                _logger.LogWarning($"adamDebug: No city Geography found for id={geographyId}");
                return (null, null, null, null, null, null);
            }
            _logger.LogInformation($"adamDebug: City Geography found: Id={city.GeographyId}, Name={city.GeographyName}, TypeId={city.GeographyTypeId}, ParentId={city.ParentId}");
            var cityType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.GeographyTypeId == city.GeographyTypeId && gt.RecordStatusId == 1);
            if (cityType == null)
            {
                _logger.LogWarning($"adamDebug: No GeographyType found for city TypeId={city.GeographyTypeId}");
                return (null, null, null, null, null, null);
            }
            _logger.LogInformation($"adamDebug: City GeographyType found: Id={cityType.GeographyTypeId}, Desc={cityType.Description}");
            if (cityType.Description?.ToLower() != "city")
            {
                _logger.LogWarning($"adamDebug: City GeographyType is not 'city', it is '{cityType.Description}'");
                return (null, null, null, null, null, null);
            }
            // Step 2: Query for state
            if (!city.ParentId.HasValue)
            {
                _logger.LogWarning($"adamDebug: City Geography has no ParentId (state)");
                return (city.GeographyName, city.GeographyId, null, null, null, null);
            }
            _logger.LogInformation($"adamDebug: Querying state Geography for id={city.ParentId.Value}");
            var state = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == city.ParentId.Value && g.RecordStatusId == 1);
            if (state == null)
            {
                _logger.LogWarning($"adamDebug: No state Geography found for id={city.ParentId.Value}");
                return (city.GeographyName, city.GeographyId, null, null, null, null);
            }
            _logger.LogInformation($"adamDebug: State Geography found: Id={state.GeographyId}, Name={state.GeographyName}, TypeId={state.GeographyTypeId}, ParentId={state.ParentId}");
            var stateType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.GeographyTypeId == state.GeographyTypeId && gt.RecordStatusId == 1);
            if (stateType == null)
            {
                _logger.LogWarning($"adamDebug: No GeographyType found for state TypeId={state.GeographyTypeId}");
                return (city.GeographyName, city.GeographyId, null, null, null, null);
            }
            _logger.LogInformation($"adamDebug: State GeographyType found: Id={stateType.GeographyTypeId}, Desc={stateType.Description}");
            if (stateType.Description?.ToLower() != "state")
            {
                _logger.LogWarning($"adamDebug: State GeographyType is not 'state', it is '{stateType.Description}'");
                return (city.GeographyName, city.GeographyId, null, null, null, null);
            }
            // Step 3: Query for country
            if (!state.ParentId.HasValue)
            {
                _logger.LogWarning($"adamDebug: State Geography has no ParentId (country)");
                return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, null, null);
            }
            _logger.LogInformation($"adamDebug: Querying country Geography for id={state.ParentId.Value}");
            var country = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == state.ParentId.Value && g.RecordStatusId == 1);
            if (country == null)
            {
                _logger.LogWarning($"adamDebug: No country Geography found for id={state.ParentId.Value}");
                return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, null, null);
            }
            _logger.LogInformation($"adamDebug: Country Geography found: Id={country.GeographyId}, Name={country.GeographyName}, TypeId={country.GeographyTypeId}, ParentId={country.ParentId}");
            var countryType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.GeographyTypeId == country.GeographyTypeId && gt.RecordStatusId == 1);
            if (countryType == null)
            {
                _logger.LogWarning($"adamDebug: No GeographyType found for country TypeId={country.GeographyTypeId}");
                return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, null, null);
            }
            _logger.LogInformation($"adamDebug: Country GeographyType found: Id={countryType.GeographyTypeId}, Desc={countryType.Description}");
            if (countryType.Description?.ToLower() != "country")
            {
                _logger.LogWarning($"adamDebug: Country GeographyType is not 'country', it is '{countryType.Description}'");
                return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, null, null);
            }
            _logger.LogInformation($"adamDebug: Final field bindings: city=({city.GeographyName}, {city.GeographyId}), state=({state.GeographyName}, {state.GeographyId}), country=({country.GeographyName}, {country.GeographyId})");
            return (city.GeographyName, city.GeographyId, state.GeographyName, state.GeographyId, country.GeographyName, country.GeographyId);
        }

        private readonly WDRepDbContext _db;
        private readonly string _sek;
        private readonly ILogger<IdentityController> _logger;
        public IdentityController(WDRepDbContext db, ILogger<IdentityController> logger)
        {
            _db = db;
            _logger = logger;
            var sek = Environment.GetEnvironmentVariable("EAGLE_SEK");
            if (string.IsNullOrWhiteSpace(sek))
                throw new InvalidOperationException("EAGLE_SEK environment variable must be set for encryption.");
            _sek = sek;
        }

                [HttpPost("create")]
                public async Task<ActionResult<CreateIdentityResponse>> CreateIdentity([FromBody] CreateIdentityRequest request)
        {
            var ip = HttpContext?.Connection?.RemoteIpAddress?.ToString() ?? Environment.GetEnvironmentVariable("REMOTE_ADDR") ?? "::0";
            // Normalize SSN to 9 digits
            var ssnDigits = Regex.Replace(request.Ssn ?? "", "[^0-9]", "");
            if (ssnDigits.Length != 9)
                return BadRequest(new CreateIdentityResponse { Success = false, Error = "Invalid SSN format" });

            byte[]? encryptedSsn;
            int? coreIdentityIdToUse = null;
            using (var transaction = await _db.Database.BeginTransactionAsync())
            {
                // Encrypt SSN for insert
                using (var cmd = _db.Database.GetDbConnection().CreateCommand())
                {
                    cmd.CommandText = "SELECT pgp_sym_encrypt(@ssn, @sek)";
                    var paramSsn = cmd.CreateParameter();
                    paramSsn.ParameterName = "@ssn";
                    paramSsn.Value = ssnDigits;
                    cmd.Parameters.Add(paramSsn);
                    var paramSek = cmd.CreateParameter();
                    paramSek.ParameterName = "@sek";
                    paramSek.Value = _sek;
                    cmd.Parameters.Add(paramSek);
                    await _db.Database.OpenConnectionAsync();
                    var result = await cmd.ExecuteScalarAsync();
                    encryptedSsn = result as byte[];
                }

                // Check for existing coreidentity by decrypted SSN
                List<int> foundIds = new List<int>();
                using (var cmd = _db.Database.GetDbConnection().CreateCommand())
                {
                    cmd.CommandText = "SELECT coreidentityid FROM coreidentity WHERE pgp_sym_decrypt(ssn, @sek) = @ssn ORDER BY coreidentityid ASC";
                    var paramSsn = cmd.CreateParameter();
                    paramSsn.ParameterName = "@ssn";
                    paramSsn.Value = ssnDigits;
                    cmd.Parameters.Add(paramSsn);
                    var paramSek = cmd.CreateParameter();
                    paramSek.ParameterName = "@sek";
                    paramSek.Value = _sek;
                    cmd.Parameters.Add(paramSek);
                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            foundIds.Add(reader.GetInt32(0));
                        }
                    }
                }
                if (foundIds.Count > 0)
                {
                    coreIdentityIdToUse = foundIds.Min();
                    if (foundIds.Count > 1)
                    {
                        _logger.LogWarning($"Multiple coreidentity records found for SSN. Using lowest coreidentityid={coreIdentityIdToUse}. IDs: {string.Join(",", foundIds)}");
                    }
                    // Optionally update the record here if needed
                }
                else
                {
                    // Insert new coreidentity
                    DateTime? dobUtc = null;
                    if (!string.IsNullOrWhiteSpace(request.Dob) && DateTime.TryParse(request.Dob, out var dobParsed))
                    {
                        dobUtc = DateTime.SpecifyKind(dobParsed, DateTimeKind.Utc);
                    }
                    var country = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == request.CountryOfBirthId);
                    if (country == null)
                        return BadRequest(new CreateIdentityResponse { Success = false, Error = "Invalid country of birth" });
                    var stateType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "state");
                    Geography? state = null;
                    if (country.GeographyName == "United States" || country.GeographyName == "Canada")
                    {
                        if (request.StateOfBirthId.HasValue)
                        {
                            state = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == request.StateOfBirthId.Value);
                        }
                    }
                    else if (!string.IsNullOrWhiteSpace(request.StateOfBirthText) && stateType != null)
                    {
                        var normalizedState = Regex.Replace(request.StateOfBirthText.Trim().ToLowerInvariant(), "[^a-z]", "");
                        var stateTypeId = stateType.GeographyTypeId;
                        var possibleStates = await _db.Geography
                            .Where(g => g.GeographyTypeId == stateTypeId && g.ParentId == country.GeographyId)
                            .ToListAsync();
                        state = possibleStates.FirstOrDefault(g =>
                            !string.IsNullOrWhiteSpace(g.GeographyName) &&
                            Regex.Replace(g.GeographyName.Trim().ToLowerInvariant(), "[^a-z]", "") == normalizedState);
                        if (state == null)
                        {
                            state = new Geography
                            {
                                GeographyName = request.StateOfBirthText.Trim(),
                                GeographyTypeId = stateTypeId,
                                ParentId = country.GeographyId,
                                RecordStatusId = 1
                            };
                            _db.Geography.Add(state);
                            await _db.SaveChangesAsync();
                        }
                    }
                    var cityType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "city");
                    Geography? city = null;
                    if (!string.IsNullOrWhiteSpace(request.CityOfBirth) && cityType != null)
                    {
                        var normalizedCity = Regex.Replace(request.CityOfBirth.Trim().ToLowerInvariant(), "[^a-z]", "");
                        var cityTypeId = cityType.GeographyTypeId;
                        var parentId = state != null ? state.GeographyId : country.GeographyId;
                        var possibleCities = await _db.Geography
                            .Where(g => g.GeographyTypeId == cityTypeId && g.ParentId == parentId)
                            .ToListAsync();
                        city = possibleCities.FirstOrDefault(g =>
                            !string.IsNullOrWhiteSpace(g.GeographyName) &&
                            Regex.Replace(g.GeographyName.Trim().ToLowerInvariant(), "[^a-z]", "") == normalizedCity);
                        if (city == null)
                        {
                            city = new Geography
                            {
                                GeographyName = request.CityOfBirth.Trim(),
                                GeographyTypeId = cityTypeId,
                                ParentId = parentId,
                                RecordStatusId = 1
                            };
                            _db.Geography.Add(city);
                            await _db.SaveChangesAsync();
                        }
                    }
                    var coreIdentity = new CoreIdentity
                    {
                        FirstName = request.FirstName?.Trim(),
                        MiddleName = request.MiddleName?.Trim(),
                        LastName = request.LastName?.Trim(),
                        PreferredName = request.PreferredName?.Trim(),
                        Dob = dobUtc,
                        Ssn = encryptedSsn,
                        PrefixId = request.PrefixId,
                        SuffixId = request.SuffixId,
                        SexId = request.SexId,
                        PlaceOfBirthId = city?.GeographyId ?? state?.GeographyId ?? country.GeographyId,
                        RecordStatusId = 1,
                        CreatedBy = 2,
                        CreatedIp = ip,
                        ModifiedBy = 2,
                        ModifiedIp = ip
                    };
                    _db.CoreIdentity.Add(coreIdentity);
                    await _db.SaveChangesAsync();
                    coreIdentityIdToUse = coreIdentity.CoreIdentityId;
                }
                await transaction.CommitAsync();
            }


                    // Insert alias and coreidentityaliases if Previous Last Name is non-blank
                    var prevLastName = request.PreviousLastName?.Trim();
                    if (!string.IsNullOrWhiteSpace(prevLastName) && coreIdentityIdToUse.HasValue)
                    {
                        var alias = new Alias
                        {
                            AliasValue = prevLastName,
                            RecordStatusId = 1,
                            CreatedBy = 2,
                            CreatedIp = ip
                        };
                        _db.Aliases.Add(alias);
                        await _db.SaveChangesAsync();
                        var coreIdentityAlias = new CoreIdentityAlias
                        {
                            CoreIdentityId = coreIdentityIdToUse.Value,
                            AliasId = alias.AliasId,
                            RecordStatusId = 1,
                            CreatedBy = 2,
                            CreatedIp = ip
                        };
                        _db.CoreIdentityAliases.Add(coreIdentityAlias);
                        await _db.SaveChangesAsync();
                    }

                    // Insert email and junction
                    int? emailId = null;
                    if (!string.IsNullOrWhiteSpace(request.PrimaryEmail) && coreIdentityIdToUse.HasValue)
                    {
                        var email = new Email {
                            EmailAddress = request.PrimaryEmail.Trim(),
                            RecordStatusId = 1,
                            CreatedBy = 2,
                            createdip = ip
                        };
                        _db.Emails.Add(email);
                        await _db.SaveChangesAsync();
                        emailId = email.EmailId;
                        var ciEmail = new CoreIdentityEmail
                        {
                            CoreIdentityId = coreIdentityIdToUse.Value,
                            EmailId = email.EmailId,
                            ContactTypeId = request.EmailTypeId ?? 1,
                            ContactSequence = 1,
                            RecordStatusId = 1,
                            CreatedBy = 2,
                            createdip = ip
                        };
                        _db.CoreIdentityEmails.Add(ciEmail);
                        await _db.SaveChangesAsync();
                    }

                    // Insert phone and junction
                    int? phoneId = null;
                    if (!string.IsNullOrWhiteSpace(request.PrimaryPhone) && coreIdentityIdToUse.HasValue)
                    {
                        var phone = new Phone {
                            PhoneNumber = request.PrimaryPhone.Trim(),
                            RecordStatusId = 1,
                            CreatedBy = 2,
                            createdip = ip
                        };
                        _db.Phones.Add(phone);
                        await _db.SaveChangesAsync();
                        phoneId = phone.PhoneId;
                        var ciPhone = new CoreIdentityPhone
                        {
                            CoreIdentityId = coreIdentityIdToUse.Value,
                            PhoneId = phone.PhoneId,
                            ContactTypeId = request.PhoneTypeId ?? 1,
                            ContactSequence = 1,
                            RecordStatusId = 1,
                            CreatedBy = 2,
                            createdip = ip
                        };
                        _db.CoreIdentityPhones.Add(ciPhone);
                        await _db.SaveChangesAsync();
                    }

                    // Insert postal address and junction (modular, robust)
                    int? postalAddressId = null;
                    if (!string.IsNullOrWhiteSpace(request.AddressLine1) && !string.IsNullOrWhiteSpace(request.ContactCityText) && request.ContactCountryId.HasValue && coreIdentityIdToUse.HasValue)
                    {
                        var paCountry = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == request.ContactCountryId.Value);
                        if (paCountry == null)
                        {
                            return BadRequest(new CreateIdentityResponse { Success = false, Error = "Invalid country for postal address." });
                        }
                        // Resolve state geographyid (dropdown or text)
                        int? paStateGeoId = null;
                        string? paStateText = null;
                        if (request.ContactStateId.HasValue)
                        {
                            paStateGeoId = request.ContactStateId.Value;
                        }
                        else if (!string.IsNullOrWhiteSpace(request.ContactStateText))
                        {
                            // Lookup or create state by text
                            var paStateType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "state");
                            if (paStateType != null)
                            {
                                var paNormalizedState = Regex.Replace(request.ContactStateText.Trim().ToLowerInvariant(), "[^a-z]", "");
                                var paStateTypeId = paStateType.GeographyTypeId;
                                var paPossibleStates = await _db.Geography
                                    .Where(g => g.GeographyTypeId == paStateTypeId && g.ParentId == paCountry.GeographyId)
                                    .ToListAsync();
                                var paState = paPossibleStates.FirstOrDefault(g =>
                                    !string.IsNullOrWhiteSpace(g.GeographyName) &&
                                    Regex.Replace(g.GeographyName.Trim().ToLowerInvariant(), "[^a-z]", "") == paNormalizedState);
                                if (paState == null)
                                {
                                    paState = new Geography
                                    {
                                        GeographyName = request.ContactStateText.Trim(),
                                        GeographyTypeId = paStateTypeId,
                                        ParentId = paCountry.GeographyId,
                                        RecordStatusId = 1
                                    };
                                    _db.Geography.Add(paState);
                                    await _db.SaveChangesAsync();
                                }
                                paStateGeoId = paState.GeographyId;
                                paStateText = paState.GeographyName;
                            }
                        }
                        // Lookup or create city under resolved state
                        if (paStateGeoId.HasValue)
                        {
                            var paCityType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "city");
                            if (paCityType != null)
                            {
                                var paNormalizedCity = Regex.Replace(request.ContactCityText.Trim().ToLowerInvariant(), "[^a-z]", "");
                                var paCityTypeId = paCityType.GeographyTypeId;
                                var paPossibleCities = await _db.Geography
                                    .Where(g => g.GeographyTypeId == paCityTypeId && g.ParentId == paStateGeoId.Value)
                                    .ToListAsync();
                                var paCity = paPossibleCities.FirstOrDefault(g =>
                                    !string.IsNullOrWhiteSpace(g.GeographyName) &&
                                    Regex.Replace(g.GeographyName.Trim().ToLowerInvariant(), "[^a-z]", "") == paNormalizedCity);
                                if (paCity == null)
                                {
                                    paCity = new Geography
                                    {
                                        GeographyName = request.ContactCityText.Trim(),
                                        GeographyTypeId = paCityTypeId,
                                        ParentId = paStateGeoId.Value,
                                        RecordStatusId = 1
                                    };
                                    _db.Geography.Add(paCity);
                                    await _db.SaveChangesAsync();
                                }
                                // Insert postal address and mapping
                                var postalAddress = new PostalAddress
                                {
                                    Address1 = request.AddressLine1?.Trim(),
                                    Address2 = request.AddressLine2?.Trim(),
                                    ZipCode = request.ContactZip?.Trim(),
                                    GeographyId = paCity.GeographyId,
                                    RecordStatusId = 1,
                                    CreatedBy = 2,
                                    createdip = ip
                                };
                                _db.PostalAddresses.Add(postalAddress);
                                await _db.SaveChangesAsync();
                                postalAddressId = postalAddress.PostalAddressId;
                                var ciPostal = new CoreIdentityPostalAddress
                                {
                                    CoreIdentityId = coreIdentityIdToUse.Value,
                                    PostalAddressId = postalAddress.PostalAddressId,
                                    ContactTypeId = request.AddressTypeId ?? 1,
                                    ContactSequence = 1,
                                    RecordStatusId = 1,
                                    CreatedBy = 2,
                                    createdip = ip
                                };
                                _db.CoreIdentityPostalAddresses.Add(ciPostal);
                                await _db.SaveChangesAsync();
                            }
                        }
                    }


                    return Ok(new CreateIdentityResponse { CoreIdentityId = coreIdentityIdToUse ?? 0, Success = true });
                }

    [HttpPost("check-ssn")]
    public async Task<IActionResult> CheckSSN([FromBody] string ssn)
    {
                    // Normalize and validate SSN
                    var normalized = Regex.Replace(ssn ?? "", "[^0-9]", "");
                    if (!Regex.IsMatch(normalized, "^\\d{9}$"))
                        return BadRequest("Invalid SSN format");

                    // Query using decryption in SQL
                    var match = await _db.CoreIdentity
                        .FromSqlRaw(@"
                            SELECT * FROM coreidentity
                            WHERE pgp_sym_decrypt(ssn, {0}) = {1}
                            LIMIT 1
                        ", _sek, normalized)
                        .AsNoTracking()
                        .FirstOrDefaultAsync();

                    Guid token;
                    if (match == null)
                    {
                        // Generate a token and store encrypted SSN in ssn_tokens
                        token = Guid.NewGuid();
                        var nowUtc = DateTime.UtcNow;
                        var expiresAtUtc = nowUtc.AddMinutes(10);
                        await _db.Database.ExecuteSqlRawAsync(@"
                            INSERT INTO ssn_tokens (token, encrypted_ssn, created_at, expires_at)
                            VALUES ({0}, pgp_sym_encrypt({1}, {2}), {3}, {4})
                        ", token, normalized, _sek, nowUtc, expiresAtUtc);
                        return Ok(new { found = false, token });
                    }
                    // If found, also generate a token and store encrypted SSN in ssn_tokens
                    token = Guid.NewGuid();
                    var nowUtc2 = DateTime.UtcNow;
                    var expiresAtUtc2 = nowUtc2.AddMinutes(10);
                    await _db.Database.ExecuteSqlRawAsync(@"
                        INSERT INTO ssn_tokens (token, encrypted_ssn, created_at, expires_at)
                        VALUES ({0}, pgp_sym_encrypt({1}, {2}), {3}, {4})
                    ", token, normalized, _sek, nowUtc2, expiresAtUtc2);

                    // Fetch related data: geography, email, phone, postal address
                    var coreId = match.CoreIdentityId;
                    _logger.LogInformation("[CheckSSN] Found coreidentityid: {CoreId} for SSN: {SSN}", coreId, normalized);
                    var placeOfBirth = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == match.PlaceOfBirthId);
                    Geography? cityOfBirth = null;
                    Geography? stateOfBirth = null;
                    Geography? countryOfBirth = null;
                    if (placeOfBirth != null)
                    {
                        // Traverse up the parent chain to find city, state, country
                        var current = placeOfBirth;
                        string? cityName = null, stateName = null, countryName = null;
                        int? cityId = null, stateId = null, countryId = null;
                        while (current != null)
                        {
                            var geoType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.GeographyTypeId == current.GeographyTypeId);
                            var desc = geoType?.Description?.ToLower();
                            if (desc == "city" && cityOfBirth == null)
                            {
                                cityOfBirth = current;
                                cityId = current.GeographyId;
                                cityName = current.GeographyName;
                            }
                            else if (desc == "state" && stateOfBirth == null)
                            {
                                stateOfBirth = current;
                                stateId = current.GeographyId;
                                stateName = current.GeographyName;
                            }
                            else if (desc == "country" && countryOfBirth == null)
                            {
                                countryOfBirth = current;
                                countryId = current.GeographyId;
                                countryName = current.GeographyName;
                            }
                            if (desc == "country")
                                break;
                            if (current.ParentId == null)
                                break;
                            current = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == current.ParentId);
                        }
                    }
                    var emailInfo = await (from e in _db.Emails
                                      join ce in _db.CoreIdentityEmails on e.EmailId equals ce.EmailId
                                      where ce.CoreIdentityId == coreId && ce.ContactSequence == 1 && ce.RecordStatusId == 1
                                      select new { e.EmailAddress, ce.ContactTypeId }).FirstOrDefaultAsync();
                    var phoneInfo = await (from p in _db.Phones
                                      join cp in _db.CoreIdentityPhones on p.PhoneId equals cp.PhoneId
                                      where cp.CoreIdentityId == coreId && cp.ContactSequence == 1 && cp.RecordStatusId == 1
                                      select new { p.PhoneNumber, cp.ContactTypeId }).FirstOrDefaultAsync();
                    var addressRaw = await (from a in _db.PostalAddresses
                                        join cpa in _db.CoreIdentityPostalAddresses on a.PostalAddressId equals cpa.PostalAddressId
                                        where cpa.CoreIdentityId == coreId && cpa.ContactSequence == 1 && cpa.RecordStatusId == 1
                                        select new {
                                            address1 = a.Address1,
                                            address2 = a.Address2,
                                            zipcode = a.ZipCode,
                                            geographyId = a.GeographyId
                                        }).FirstOrDefaultAsync();

                    int? debugGeoId = addressRaw?.geographyId;
                    string? debugCityName = null;
                    int? debugCityId = null;
                    string? debugStateName = null;
                    int? debugStateId = null;
                    string? debugCountryName = null;
                    int? debugCountryId = null;
                    if (debugGeoId.HasValue)
                    {
                        var debugResult = await adamDebug(debugGeoId.Value);
                        debugCityName = debugResult.cityName;
                        debugCityId = debugResult.cityId;
                        debugStateName = debugResult.stateName;
                        debugStateId = debugResult.stateId;
                        debugCountryName = debugResult.countryName;
                        debugCountryId = debugResult.countryId;
                    }
                    var address = new {
                        address1 = addressRaw?.address1,
                        address2 = addressRaw?.address2,
                        zipcode = addressRaw?.zipcode,
                        geographyId = addressRaw?.geographyId,
                        cityId = debugCityId,
                        cityName = debugCityName,
                        stateId = debugStateId,
                        stateName = debugStateName,
                        countryId = debugCountryId,
                        countryName = debugCountryName
                    };
                    _logger.LogInformation("[CheckSSN] Returning address for coreidentityid {CoreId}: {@Address}", coreId, address);

                    // Get aliases for this coreidentity, most recent first
                    var aliases = await (from ca in _db.CoreIdentityAliases
                                        join a in _db.Aliases on ca.AliasId equals a.AliasId
                                        where ca.CoreIdentityId == coreId && ca.RecordStatusId == 1 && a.RecordStatusId == 1
                                        orderby ca.CreatedDate descending
                                        select new { a.AliasValue, ca.CreatedDate }).ToListAsync();
                    var mostRecentAlias = aliases.FirstOrDefault()?.AliasValue;
                    var priorAliases = aliases.Skip(1).Select(x => x.AliasValue).ToList();
                    _logger.LogInformation("[CheckSSN] Returning full response for coreidentityid {CoreId}: {@Response}", coreId, new {
                        coreidentityid = match.CoreIdentityId,
                        found = true,
                        firstname = match.FirstName,
                        middlename = match.MiddleName,
                        lastname = match.LastName,
                        preferredname = match.PreferredName,
                        previouslastname = mostRecentAlias,
                        prioraliases = priorAliases,
                        ssn = normalized,
                        dob = match.Dob,
                        prefixid = match.PrefixId,
                        suffixid = match.SuffixId,
                        sexid = match.SexId,
                        countryofbirthid = countryOfBirth?.GeographyId,
                        stateofbirthid = stateOfBirth?.GeographyId,
                        cityofbirthid = cityOfBirth?.GeographyId,
                        countryofbirth = countryOfBirth?.GeographyName,
                        stateofbirth = stateOfBirth?.GeographyName,
                        cityofbirth = cityOfBirth?.GeographyName,
                        email = emailInfo?.EmailAddress,
                        emailtypeid = emailInfo?.ContactTypeId,
                        phone = phoneInfo?.PhoneNumber,
                        phonetypeid = phoneInfo?.ContactTypeId,
                        address,
                        token
                    });
                    return Ok(new {
                        coreidentityid = match.CoreIdentityId,
                        found = true,
                        firstname = match.FirstName,
                        middlename = match.MiddleName,
                        lastname = match.LastName,
                        preferredname = match.PreferredName,
                        previouslastname = mostRecentAlias,
                        prioraliases = priorAliases,
                        ssn = normalized,
                        dob = match.Dob,
                        prefixid = match.PrefixId,
                        suffixid = match.SuffixId,
                        sexid = match.SexId,
                        countryofbirthid = countryOfBirth?.GeographyId,
                        stateofbirthid = stateOfBirth?.GeographyId,
                        cityofbirthid = cityOfBirth?.GeographyId,
                        countryofbirth = countryOfBirth?.GeographyName,
                        stateofbirth = stateOfBirth?.GeographyName,
                        cityofbirth = cityOfBirth?.GeographyName,
                        email = emailInfo?.EmailAddress,
                        emailtypeid = emailInfo?.ContactTypeId,
                        phone = phoneInfo?.PhoneNumber,
                        phonetypeid = phoneInfo?.ContactTypeId,
                        address,
                        token
                    });
                }

    [HttpPost("ssn-from-token")]
    public async Task<IActionResult> GetSSNFromToken([FromBody] SsnTokenRequest request)
    {
            var token = request.Token;
            var sek = _sek;
            // 1. Look up the encrypted SSN by token
            var ssnToken = await _db.SsnTokens.FirstOrDefaultAsync(t => t.Token == token);
            if (ssnToken == null)
            {
                Console.WriteLine($"[GetSSNFromToken] Token not found: {token}");
                return NotFound(new { error = "Token not found" });
            }
            if (ssnToken.ExpiresAt <= DateTime.UtcNow)
            {
                Console.WriteLine($"[GetSSNFromToken] Token expired: {token}, expires_at={ssnToken.ExpiresAt}, now={DateTime.UtcNow}");
                // Optionally, delete expired token
                _db.SsnTokens.Remove(ssnToken);
                await _db.SaveChangesAsync();
                return NotFound(new { error = "Token expired" });
            }

            // 2. Delete the token for one-time use
            _db.SsnTokens.Remove(ssnToken);
            await _db.SaveChangesAsync();

            // 3. Decrypt the SSN using raw SQL (since EF can't call pgp_sym_decrypt directly)
            string? decryptedSsn = null;
            try
            {
                using (var cmd = _db.Database.GetDbConnection().CreateCommand())
                {
                    cmd.CommandText = "SELECT pgp_sym_decrypt(@ssn, @sek)";
                    var paramSsn = cmd.CreateParameter();
                    paramSsn.ParameterName = "@ssn";
                    paramSsn.Value = ssnToken.EncryptedSsn;
                    cmd.Parameters.Add(paramSsn);
                    var paramSek = cmd.CreateParameter();
                    paramSek.ParameterName = "@sek";
                    paramSek.Value = sek;
                    cmd.Parameters.Add(paramSek);
                    await _db.Database.OpenConnectionAsync();
                    var result = await cmd.ExecuteScalarAsync();
                    decryptedSsn = result?.ToString();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[GetSSNFromToken] Exception during decryption: {ex.Message}");
                return StatusCode(500, new { error = "Decryption failed", details = ex.Message });
            }
            Console.WriteLine($"[GetSSNFromToken] Success for token: {token}");
            return Ok(new { ssn = decryptedSsn });
        }

    [HttpGet("dropdowns")]
    public async Task<IActionResult> GetDropdowns()
    {
            var prefixes = await _db.PrefixSuffix
                .FromSqlRaw(@"select prefixsuffixid, description, category, recordstatusid from prefixsuffix where recordstatusid = 1 and category = 'Prefix';")
                .ToListAsync();
            var suffixes = await _db.PrefixSuffix
                .FromSqlRaw(@"select prefixsuffixid, description, category, recordstatusid from prefixsuffix where recordstatusid = 1 and category = 'Suffix';")
                .ToListAsync();
            var sexes = await _db.Sexes
                .FromSqlRaw(@"select sexid, description, recordstatusid from sexes where recordstatusid = 1 order by description;")
                .ToListAsync();
            var emailTypes = await _db.ContactTypes
                .FromSqlRaw(@"select contacttypeid, contacttypename, recordstatusid from contacttypes where recordstatusid = 1 and appliestoemail = TRUE;")
                .ToListAsync();
            var phoneTypes = await _db.ContactTypes
                .FromSqlRaw(@"select contacttypeid, contacttypename, recordstatusid from contacttypes where recordstatusid = 1 and appliestophone = TRUE;")
                .ToListAsync();
            var addressTypes = await _db.ContactTypes
                .FromSqlRaw(@"select contacttypeid, contacttypename, recordstatusid from contacttypes where recordstatusid = 1 and appliestopostaladdress = TRUE;")
                .ToListAsync();

            var countryType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "country");
            var countries = new List<Geography>();
            if (countryType != null) {
                countries = await _db.Geography
                    .Where(x => x.RecordStatusId == 1 && x.GeographyTypeId == countryType.GeographyTypeId)
                    .OrderBy(x => x.GeographyName)
                    .ToListAsync();
            }

            return Ok(new {
                prefixes,
                suffixes,
                sexes,
                countries,
                emailTypes,
                phoneTypes,
                addressTypes
            });
        }

    [HttpGet("states/{countryId}")]
    public async Task<IActionResult> GetStates(int countryId)
    {
            var stateType = await _db.GeographyTypes.FirstOrDefaultAsync(gt => gt.Description != null && gt.Description.ToLower() == "state");
            if (stateType == null)
            {
                return Ok(new List<Geography>());
            }

            var states = await _db.Geography
                .Where(g => g.RecordStatusId == 1 && g.ParentId == countryId && g.GeographyTypeId == stateType.GeographyTypeId)
                .OrderBy(g => g.GeographyName)
                .ToListAsync();

            return Ok(states);
        }

    [HttpGet("{coreIdentityId}/primary-email")]
    public async Task<IActionResult> GetPrimaryEmail(int coreIdentityId)
    {
            var email = await (from e in _db.Emails
                               join ce in _db.CoreIdentityEmails on e.EmailId equals ce.EmailId
                               where ce.RecordStatusId == 1 &&
                                     ce.CoreIdentityId == coreIdentityId &&
                                     ce.ContactSequence == 1
                               select e).FirstOrDefaultAsync();
            return email == null ? NotFound() : Ok(email);
        }

    [HttpGet("{coreIdentityId}/primary-phone")]
    public async Task<IActionResult> GetPrimaryPhone(int coreIdentityId)
    {
            var phone = await (from p in _db.Phones
                               join cp in _db.CoreIdentityPhones on p.PhoneId equals cp.PhoneId
                               where cp.RecordStatusId == 1 &&
                                     cp.CoreIdentityId == coreIdentityId &&
                                     cp.ContactSequence == 1
                               select p).FirstOrDefaultAsync();
            return phone == null ? NotFound() : Ok(phone);
        }

    [HttpGet("{coreIdentityId}/primary-address")]
    public async Task<IActionResult> GetPrimaryAddress(int coreIdentityId)
    {
        _logger.LogInformation($"[GetPrimaryAddress] Fetching primary address for CoreIdentityId={coreIdentityId}");
        var result = await (from a in _db.PostalAddresses
                            join cpa in _db.CoreIdentityPostalAddresses on a.PostalAddressId equals cpa.PostalAddressId
                            where cpa.RecordStatusId == 1 &&
                                  cpa.CoreIdentityId == coreIdentityId &&
                                  cpa.ContactSequence == 1
                            select new {
                                a.PostalAddressId,
                                a.Address1,
                                a.Address2,
                                a.ZipCode,
                                a.GeographyId, // this is city
                                cpa.ContactTypeId
                            }).FirstOrDefaultAsync();
        if (result == null)
        {
            _logger.LogWarning($"[GetPrimaryAddress] No primary address found for CoreIdentityId={coreIdentityId}");
            return NotFound();
        }

        var city = await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == result.GeographyId);
        if (city == null)
        {
            _logger.LogWarning($"[GetPrimaryAddress] City not found for GeographyId={result.GeographyId}");
        }
        var state = city != null ? await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == city.ParentId) : null;
        if (state == null)
        {
            _logger.LogWarning($"[GetPrimaryAddress] State not found for CityId={city?.GeographyId}, ParentId={city?.ParentId}");
        }
        var country = state != null ? await _db.Geography.FirstOrDefaultAsync(g => g.GeographyId == state.ParentId) : null;
        if (country == null)
        {
            _logger.LogWarning($"[GetPrimaryAddress] Country not found for StateId={state?.GeographyId}, ParentId={state?.ParentId}");
        }

        var addressTypeName = result.ContactTypeId != null ? (await _db.ContactTypes.Where(ct => ct.ContactTypeId == result.ContactTypeId).Select(ct => ct.ContactTypeName).FirstOrDefaultAsync()) : null;

        var response = new WDRepApp.DTOs.PrimaryAddressResponse
        {
            PostalAddressId = result.PostalAddressId,
            Address1 = result.Address1,
            Address2 = result.Address2,
            ZipCode = result.ZipCode,
            AddressTypeId = result.ContactTypeId,
            AddressTypeName = addressTypeName,
            ContactCityId = city?.GeographyId,
            ContactCity = city?.GeographyName,
            ContactStateId = state?.GeographyId,
            ContactState = state?.GeographyName,
            ContactCountryId = country?.GeographyId,
            ContactCountry = country?.GeographyName,
            GeographyId = city?.GeographyId
        };

        _logger.LogInformation($"[GetPrimaryAddress] Returning address DTO: {@response}");
        return Ok(response);
    }
}
public class SsnTokenRequest
{
    public Guid Token { get; set; }
}
}
