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
        [Column("contactsequence")]
        public int ContactSequence { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}