
using System;
using System.ComponentModel.DataAnnotations;

namespace WDRepApp.Server.Entities
{
    public class SsnToken
    {
        [System.ComponentModel.DataAnnotations.Schema.Column("token")]
        public Guid Token { get; set; }
        [System.ComponentModel.DataAnnotations.Schema.Column("encrypted_ssn")]
        public byte[]? EncryptedSsn { get; set; }
        [System.ComponentModel.DataAnnotations.Schema.Column("created_at")]
        public DateTime CreatedAt { get; set; }
        [System.ComponentModel.DataAnnotations.Schema.Column("expires_at")]
        public DateTime ExpiresAt { get; set; }
    }
}
