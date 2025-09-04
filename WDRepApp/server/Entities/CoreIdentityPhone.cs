using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("coreidentityphones")]
    public class CoreIdentityPhone
    {
        [Key]
        [Column("coreidentityphoneid")]
        public int CoreIdentityPhoneId { get; set; }
        [Column("coreidentityid")]
        public int CoreIdentityId { get; set; }
        [Column("phoneid")]
        public int PhoneId { get; set; }
        [Column("contacttypeid")]
        public int ContactTypeId { get; set; }
        [Column("contactsequence")]
        public int ContactSequence { get; set; }
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