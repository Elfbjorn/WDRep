using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Entities
{
    [Table("defaultitems")]
    public class DefaultItem
    {
        [Key]
        [Column("defaultitemid")]
        public int DefaultItemId { get; set; }

        [Column("defaultitempage")]
        [Required]
        public string DefaultItemPage { get; set; } = string.Empty;

        [Column("defaultitemtab")]
        public string? DefaultItemTab { get; set; }

        [Column("cancellink")]
        public string? CancelLink { get; set; }

        [Column("cancellinktext")]
        public string? CancelLinkText { get; set; }

        [Column("previouslink")]
        public string? PreviousLink { get; set; }

        [Column("previouslinktext")]
        public string? PreviousLinkText { get; set; }

        [Column("nextlink")]
        public string? NextLink { get; set; }

        [Column("nextlinktext")]
        public string? NextLinkText { get; set; }

        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}
