using System;

namespace WDRepApp.Server.Models
{
    /// <summary>
    /// Model for creating or updating identity information
    /// This is separate from the DTO to provide a clean model representation
    /// </summary>
    public class CreateIdentityRequest
    {
        public Guid SsnToken { get; set; }
        public string? FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string? LastName { get; set; }
        public string? PreferredName { get; set; }
        public string? Dob { get; set; }
        public int? PrefixId { get; set; }
        public int? SuffixId { get; set; }
        public int? SexId { get; set; }
        public int? PlaceOfBirthId { get; set; }
        
        // Contact information
        public string? PrimaryEmail { get; set; }
        public int? EmailTypeId { get; set; }
        public string? PrimaryPhone { get; set; }
        public int? PhoneTypeId { get; set; }
        
        // Address information
        public string? AddressLine1 { get; set; }
        public string? AddressLine2 { get; set; }
        public string? ContactCityText { get; set; }
        public string? ContactStateText { get; set; }
        public int? ContactStateId { get; set; }
        public int? ContactCountryId { get; set; }
        public string? ContactZip { get; set; }
        public int? AddressTypeId { get; set; }
        
        // Birth location
        public string? CityOfBirth { get; set; }
        public string? StateOfBirthText { get; set; }
        public int? StateOfBirthId { get; set; }
        public int? CountryOfBirthId { get; set; }
        
        // Legacy fields
        public string? PreviousLastName { get; set; }
        public int? ContactGeographyId { get; set; }
    }
}