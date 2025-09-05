using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("menuitemtypes")]
    public class MenuItemType
    {
        [Key]
        public int menuitemtypeid { get; set; }
        public string menuitemtypename { get; set; }
        public int recordstatusid { get; set; }
    }
}
