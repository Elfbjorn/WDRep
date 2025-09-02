using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("prefixsuffix")]
    public class PrefixSuffix // Renamed from prefixsuffix
    {
        [Key]
        [Column("prefixsuffixid")]
        public int PrefixSuffixId { get; set; }
        [Column("description")]
        public string? Description { get; set; }
        [Column("category")]
        public string? Category { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}