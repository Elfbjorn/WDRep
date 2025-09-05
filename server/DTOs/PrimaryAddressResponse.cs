using System.Text.Json.Serialization;
namespace WDRepApp.DTOs
{
    public class PrimaryAddressResponse
    {
        public int PostalAddressId { get; set; }
        public string? Address1 { get; set; }
        public string? Address2 { get; set; }
        public string? ZipCode { get; set; }
        public int? AddressTypeId { get; set; }
        public string? AddressTypeName { get; set; }
    [JsonPropertyName("contactCountryId")]
    public int? ContactCountryId { get; set; }
    [JsonPropertyName("contactCountry")]
    public string? ContactCountry { get; set; }
    [JsonPropertyName("contactStateId")]
    public int? ContactStateId { get; set; }
    [JsonPropertyName("contactState")]
    public string? ContactState { get; set; }
    [JsonPropertyName("contactCityId")]
    public int? ContactCityId { get; set; }
    [JsonPropertyName("contactCity")]
    public string? ContactCity { get; set; }
        public int? GeographyId { get; set; } // City GeographyId for compatibility
    }
}
