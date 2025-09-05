
using System;
using System.Collections.Generic;

namespace WDRepApp.Server.DTOs
{
    public class CreateIdentityRequest
    {
    public Guid SsnToken { get; set; }
    public int? EmailTypeId { get; set; }
        public string? FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string? LastName { get; set; }
        public string? PreviousLastName { get; set; }
        public string? PreferredName { get; set; }
        public string? Dob { get; set; }
        public string? Ssn { get; set; }
        public string? StateOfBirthText { get; set; }
        public string? CityOfBirth { get; set; }
        public string? PrimaryEmail { get; set; }
        public string? PrimaryPhone { get; set; }
        public string? AddressLine1 { get; set; }
        public string? AddressLine2 { get; set; }
    public int? ContactGeographyId { get; set; } // City-level geography for postal address (legacy, not used for new logic)
    public int? ContactCountryId { get; set; } // Country geographyid for postal address
    public int? ContactStateId { get; set; } // State geographyid for postal address (dropdown, US/Canada)
    public string? ContactStateText { get; set; } // State as text (non-US/Canada)
    public string? ContactCityText { get; set; } // City as text (always required)
        public string? ContactZip { get; set; }
        public int? PhoneTypeId { get; set; }
        public int? AddressTypeId { get; set; }
    // Removed ContactCountryId and ContactStateId; use ContactGeographyId instead
        public int? CountryOfBirthId { get; set; }
        public int? StateOfBirthId { get; set; }
        public int? PrefixId { get; set; }
        public int? SuffixId { get; set; }
        public int? SexId { get; set; }
    }
}
