using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("geographytypes")]
    public class GeographyType // Renamed from geographytypes
    {
        [Key]
        [Column("geographytypeid")]
        public int GeographyTypeId { get; set; }
        [Column("description")] // FIX: The column name is 'description' per the database schema.
        public string? Description { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}