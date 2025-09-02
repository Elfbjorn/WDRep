using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WDRepApp.Server.Entities
{
    [Table("coreidentity")]
    public class CoreIdentity
    {
        [Key]
        [Column("coreidentityid")]
        public int CoreIdentityId { get; set; }

        [Column("firstname")]
        public string? FirstName { get; set; }

        [Column("middlename")]
        public string? MiddleName { get; set; }

        [Column("lastname")]
        public string? LastName { get; set; }

        [Column("ssn")]
        public string? Ssn { get; set; }

        [Column("dob")]
        public DateTime? Dob { get; set; }

        [Column("prefixid")]
        public int? PrefixId { get; set; }

        [Column("suffixid")]
        public int? SuffixId { get; set; }

        [Column("sexid")]
        public int? SexId { get; set; }

        [Column("placeofbirthid")]
        public int? PlaceOfBirthId { get; set; }

        [Column("recordstatusid")]
        public int RecordStatusId { get; set; }
    }
}
