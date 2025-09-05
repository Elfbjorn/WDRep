using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("sexes")]
   public class Sex // Renamed from sexes
    {
        [Key]
        [Column("sexid")]
        public int SexId { get; set; }
        [Column("description")]
        public string? Description { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}