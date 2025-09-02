using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("phones")]
    public class Phone
    {
        [Key]
        [Column("phoneid")]
        public int PhoneId { get; set; }
        [Column("phonenumber")]
        public string? PhoneNumber { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}