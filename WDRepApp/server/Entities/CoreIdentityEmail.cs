using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("coreidentityemails")]
    public class CoreIdentityEmail
    {
        [Key]
        [Column("coreidentityemailid")]
        public int CoreIdentityEmailId { get; set; }
        [Column("coreidentityid")]
        public int CoreIdentityId { get; set; }
        [Column("emailid")]
        public int EmailId { get; set; }
        [Column("contactsequence")]
        public int ContactSequence { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}