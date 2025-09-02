using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("coreidentitypostaladdresses")]
    public class CoreIdentityPostalAddress
    {
        [Key]
        [Column("coreidentitypostaladdressid")]
        public int CoreIdentityPostalAddressId { get; set; }
        [Column("coreidentityid")]
        public int CoreIdentityId { get; set; }
        [Column("postaladdressid")]
        public int PostalAddressId { get; set; }
        [Column("contactsequence")]
        public int ContactSequence { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}