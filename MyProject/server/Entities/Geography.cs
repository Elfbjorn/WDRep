// filepath: /workspaces/WDRep/MyProject/server/Entities/Geography.cs
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRep.Server.Entities
{
    [Table("geography")]
    public class Geography
    {
        [Key]
        [Column("geographyid")]
        public int GeographyId { get; set; }

        [Column("humanreadableid")]
        public string? HumanReadableId { get; set; }

        [Column("geographyname")]
        public string GeographyName { get; set; }

        [Column("geographytypeid")]
        public int GeographyTypeId { get; set; }

        [Column("parentid")]
        public int? ParentId { get; set; }

        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }

        [Column("createdby")]
        public int CreatedBy { get; set; }

        [Column("createddate")]
        public DateTime CreatedDate { get; set; }

        [Column("createdip")]
        public string CreatedIp { get; set; }

        [Column("modifiedby")]
        public int? ModifiedBy { get; set; }

        [Column("modifieddate")]
        public DateTime? ModifiedDate { get; set; }

        [Column("modifiedip")]
        public string? ModifiedIp { get; set; }

        [Column("deletedby")]
        public int? DeletedBy { get; set; }

        [Column("deleteddate")]
        public DateTime? DeletedDate { get; set; }

        [Column("deletedip")]
        public string? DeletedIp { get; set; }
    }
}