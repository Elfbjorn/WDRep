using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRep.Server.Entities
{
    [Table("prefixsuffix")]
    public class PrefixSuffix
    {
        [Key]
        [Column("prefixsuffixid")]
        public int PrefixSuffixId { get; set; }

        [Column("humanreadableid")]
        public string? HumanReadableId { get; set; }

        [Column("description")]
        public string Description { get; set; }

        [Column("category")]
        public string Category { get; set; }

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