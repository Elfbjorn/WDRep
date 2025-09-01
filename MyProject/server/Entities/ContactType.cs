using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRep.Server.Entities
{
    [Table("contacttypes")]
    public class ContactType
    {
        [Key]
        [Column("contacttypeid")]
        public int ContactTypeId { get; set; }

        [Column("contacttypename")]
        public string ContactTypeName { get; set; }

        [Column("appliestoemail")]
        public bool AppliesToEmail { get; set; }

        [Column("appliestophone")]
        public bool AppliesToPhone { get; set; }

        [Column("appliestopostaladdress")]
        public bool AppliesToPostalAddress { get; set; }

        [Column("appliestosocialmedia")]
        public bool AppliesToSocialMedia { get; set; }

        [Column("appliestowebsite")]
        public bool AppliesToWebsite { get; set; }

        [Column("recordstatusid")]
        public int RecordStatusID { get; set; }
    }
}