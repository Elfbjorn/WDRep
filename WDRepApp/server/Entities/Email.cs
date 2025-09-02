using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("emails")]
    public class Email
    {
        [Key]
        [Column("emailid")]
        public int EmailId { get; set; }
        [Column("emailaddress")]
        public string? EmailAddress { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}