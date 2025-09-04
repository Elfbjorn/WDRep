using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("coreidentityaliases")]
    public class CoreIdentityAlias
    {
        [Key]
        [Column("coreidentityaliasid")]
        public int CoreIdentityAliasId { get; set; }
        [Column("humanreadableid")]
        public string? HumanReadableId { get; set; }
        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
        [Column("coreidentityid")]
        public int CoreIdentityId { get; set; }
        [Column("aliasid")]
        public int AliasId { get; set; }
        [Column("createdby")]
        public int CreatedBy { get; set; } = 2;
        [Column("createddate")]
        public DateTime CreatedDate { get; set; } = DateTime.UtcNow;
        [Column("createdip")]
        public string CreatedIp { get; set; } = "::0";
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
