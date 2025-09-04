namespace WDRepApp.Server.Entities
{
    using System.ComponentModel.DataAnnotations.Schema;
    [Table("geography")]
    public class Geography
    {
    [Column("geographyid")]
    public int GeographyId { get; set; }
    [Column("geographyname")]
    public string? GeographyName { get; set; }
    [Column("geographytypeid")]
    public int GeographyTypeId { get; set; }
    [Column("parentid")]
    public int? ParentId { get; set; }
    [Column("recordstatusid")]
    public int RecordStatusId { get; set; }
    }
}
