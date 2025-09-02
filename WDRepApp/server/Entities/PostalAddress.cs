using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("postaladdresses")]
    public class PostalAddress
    {
       [Key]
        [Column("postaladdressid")]
        public int PostalAddressId { get; set; }
        [Column("addressline1")]
        public string? AddressLine1 { get; set; }
        [Column("addressline2")]
        public string? AddressLine2 { get; set; }
        [Column("city")]
        public string? City { get; set; }
        [Column("state")]
        public string? State { get; set; }
        [Column("postalcode")]
        public string? PostalCode { get; set; }
        [Column("countryid")]
        public int? CountryId { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}