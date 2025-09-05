namespace WDRepApp.Server.Entities
{
    using System.ComponentModel.DataAnnotations.Schema;
    [Table("prefixsuffix")]
    public class PrefixSuffix
    {
        [Column("prefixsuffixid")]
        public int PrefixSuffixId { get; set; }
        [Column("description")]
        public string Description { get; set; }
        [Column("category")]
        public string Category { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}
