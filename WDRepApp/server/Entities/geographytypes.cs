using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("geographytypes")]
    public class GeographyTypes
    {
        [Key]
        [Column("geographytypeid")]
        public int GeographyTypeId { get; set; }
    [Column("description")]
    public string Description { get; set; } = null!;
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}
