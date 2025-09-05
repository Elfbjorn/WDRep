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
    [Column("address1")]
    public string? Address1 { get; set; }
    [Column("address2")]
    public string? Address2 { get; set; }
    [Column("zipcode")]
    public string? ZipCode { get; set; }
    [Column("geographyid")]
    public int GeographyId { get; set; } // Points to city-level Geography
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }

        [Column("createdby")]
        public int CreatedBy { get; set; }
        [Column("createddate")]
        public DateTime CreatedDate { get; set; } = DateTime.UtcNow;
        [Column("createdip")]
        public string createdip { get; set; } = "::0";
        [Column("modifiedby")]
        public int? ModifiedBy { get; set; }
        [Column("modifieddate")]
        public DateTime? ModifiedDate { get; set; }
        [Column("modifiedip")]
        public string? ModifiedIpAddress { get; set; }
        [Column("deletedby")]
        public int? DeletedBy { get; set; }
        [Column("deleteddate")]
        public DateTime? DeletedDate { get; set; }
        [Column("deletedip")]
        public string? DeletedIpAddress { get; set; }
    }
}