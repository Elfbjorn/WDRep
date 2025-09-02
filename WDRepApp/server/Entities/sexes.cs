namespace WDRepApp.Server.Entities
{
    using System.ComponentModel.DataAnnotations.Schema;
    [Table("sexes")]
    public class Sexes
    {
        [Column("sexid")]
        public int SexId { get; set; }
        [Column("description")]
        public string? Description { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}
