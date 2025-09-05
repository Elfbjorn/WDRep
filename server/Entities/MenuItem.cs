using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("menuitems")]
    public class MenuItem
    {
        [Key]
        public int menuitemid { get; set; }
        public string menuitemname { get; set; }
        public int menuitemtypeid { get; set; }
        public int? parentid { get; set; }
        public string? immediatelink { get; set; }
        public string? nextlink { get; set; }
        public string? cancellink { get; set; }
        public string? previouslink { get; set; }
    public int sequenceid { get; set; }
    public int recordstatusid { get; set; }
    public string? cancellinktext { get; set; }
    public string? nextlinktext { get; set; }
    public string? previouslinktext { get; set; }
    }
}
