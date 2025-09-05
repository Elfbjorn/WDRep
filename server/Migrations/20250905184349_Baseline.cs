using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace server.Migrations
{
    /// <inheritdoc />
    public partial class Baseline : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "aliases",
                columns: table => new
                {
                    aliasid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    humanreadableid = table.Column<string>(type: "text", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    alias = table.Column<string>(type: "text", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_aliases", x => x.aliasid);
                });

            migrationBuilder.CreateTable(
                name: "contacttypes",
                columns: table => new
                {
                    contacttypeid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    contacttypename = table.Column<string>(type: "text", nullable: true),
                    appliestoemail = table.Column<bool>(type: "boolean", nullable: false),
                    appliestophone = table.Column<bool>(type: "boolean", nullable: false),
                    appliestopostaladdress = table.Column<bool>(type: "boolean", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_contacttypes", x => x.contacttypeid);
                });

            migrationBuilder.CreateTable(
                name: "coreidentity",
                columns: table => new
                {
                    coreidentityid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    preferredname = table.Column<string>(type: "text", nullable: true),
                    firstname = table.Column<string>(type: "text", nullable: true),
                    middlename = table.Column<string>(type: "text", nullable: true),
                    lastname = table.Column<string>(type: "text", nullable: true),
                    ssn = table.Column<byte[]>(type: "bytea", nullable: true),
                    dob = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    prefixid = table.Column<int>(type: "integer", nullable: true),
                    suffixid = table.Column<int>(type: "integer", nullable: true),
                    sexid = table.Column<int>(type: "integer", nullable: true),
                    placeofbirthid = table.Column<int>(type: "integer", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: false),
                    modifiedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_coreidentity", x => x.coreidentityid);
                });

            migrationBuilder.CreateTable(
                name: "coreidentityaliases",
                columns: table => new
                {
                    coreidentityaliasid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    humanreadableid = table.Column<string>(type: "text", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    coreidentityid = table.Column<int>(type: "integer", nullable: false),
                    aliasid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_coreidentityaliases", x => x.coreidentityaliasid);
                });

            migrationBuilder.CreateTable(
                name: "coreidentityemails",
                columns: table => new
                {
                    coreidentityemailid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    coreidentityid = table.Column<int>(type: "integer", nullable: false),
                    emailid = table.Column<int>(type: "integer", nullable: false),
                    contacttypeid = table.Column<int>(type: "integer", nullable: false),
                    contactsequence = table.Column<int>(type: "integer", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_coreidentityemails", x => x.coreidentityemailid);
                });

            migrationBuilder.CreateTable(
                name: "coreidentityphones",
                columns: table => new
                {
                    coreidentityphoneid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    coreidentityid = table.Column<int>(type: "integer", nullable: false),
                    phoneid = table.Column<int>(type: "integer", nullable: false),
                    contacttypeid = table.Column<int>(type: "integer", nullable: false),
                    contactsequence = table.Column<int>(type: "integer", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_coreidentityphones", x => x.coreidentityphoneid);
                });

            migrationBuilder.CreateTable(
                name: "coreidentitypostaladdresses",
                columns: table => new
                {
                    coreidentitypostaladdressid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    coreidentityid = table.Column<int>(type: "integer", nullable: false),
                    postaladdressid = table.Column<int>(type: "integer", nullable: false),
                    contacttypeid = table.Column<int>(type: "integer", nullable: false),
                    contactsequence = table.Column<int>(type: "integer", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_coreidentitypostaladdresses", x => x.coreidentitypostaladdressid);
                });

            migrationBuilder.CreateTable(
                name: "defaultitems",
                columns: table => new
                {
                    defaultitemid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    defaultitempage = table.Column<string>(type: "text", nullable: false),
                    defaultitemtab = table.Column<string>(type: "text", nullable: true),
                    cancellink = table.Column<string>(type: "text", nullable: true),
                    cancellinktext = table.Column<string>(type: "text", nullable: true),
                    previouslink = table.Column<string>(type: "text", nullable: true),
                    previouslinktext = table.Column<string>(type: "text", nullable: true),
                    nextlink = table.Column<string>(type: "text", nullable: true),
                    nextlinktext = table.Column<string>(type: "text", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_defaultitems", x => x.defaultitemid);
                });

            migrationBuilder.CreateTable(
                name: "emails",
                columns: table => new
                {
                    emailid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    emailaddress = table.Column<string>(type: "text", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_emails", x => x.emailid);
                });

            migrationBuilder.CreateTable(
                name: "geography",
                columns: table => new
                {
                    geographyid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    geographyname = table.Column<string>(type: "text", nullable: true),
                    geographytypeid = table.Column<int>(type: "integer", nullable: false),
                    parentid = table.Column<int>(type: "integer", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_geography", x => x.geographyid);
                });

            migrationBuilder.CreateTable(
                name: "geographytypes",
                columns: table => new
                {
                    geographytypeid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    description = table.Column<string>(type: "text", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_geographytypes", x => x.geographytypeid);
                });

            migrationBuilder.CreateTable(
                name: "menuitems",
                columns: table => new
                {
                    menuitemid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    menuitemname = table.Column<string>(type: "text", nullable: false),
                    menuitemtypeid = table.Column<int>(type: "integer", nullable: false),
                    parentid = table.Column<int>(type: "integer", nullable: true),
                    immediatelink = table.Column<string>(type: "text", nullable: true),
                    nextlink = table.Column<string>(type: "text", nullable: true),
                    cancellink = table.Column<string>(type: "text", nullable: true),
                    previouslink = table.Column<string>(type: "text", nullable: true),
                    sequenceid = table.Column<int>(type: "integer", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    cancellinktext = table.Column<string>(type: "text", nullable: true),
                    nextlinktext = table.Column<string>(type: "text", nullable: true),
                    previouslinktext = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_menuitems", x => x.menuitemid);
                });

            migrationBuilder.CreateTable(
                name: "menuitemtypes",
                columns: table => new
                {
                    menuitemtypeid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    menuitemtypename = table.Column<string>(type: "text", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_menuitemtypes", x => x.menuitemtypeid);
                });

            migrationBuilder.CreateTable(
                name: "phones",
                columns: table => new
                {
                    phoneid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    phonenumber = table.Column<string>(type: "text", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_phones", x => x.phoneid);
                });

            migrationBuilder.CreateTable(
                name: "postaladdresses",
                columns: table => new
                {
                    postaladdressid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    address1 = table.Column<string>(type: "text", nullable: true),
                    address2 = table.Column<string>(type: "text", nullable: true),
                    zipcode = table.Column<string>(type: "text", nullable: true),
                    geographyid = table.Column<int>(type: "integer", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false),
                    createdby = table.Column<int>(type: "integer", nullable: false),
                    createddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    createdip = table.Column<string>(type: "text", nullable: false),
                    modifiedby = table.Column<int>(type: "integer", nullable: true),
                    modifieddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    modifiedip = table.Column<string>(type: "text", nullable: true),
                    deletedby = table.Column<int>(type: "integer", nullable: true),
                    deleteddate = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    deletedip = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_postaladdresses", x => x.postaladdressid);
                });

            migrationBuilder.CreateTable(
                name: "prefixsuffix",
                columns: table => new
                {
                    prefixsuffixid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    description = table.Column<string>(type: "text", nullable: false),
                    category = table.Column<string>(type: "text", nullable: false),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_prefixsuffix", x => x.prefixsuffixid);
                });

            migrationBuilder.CreateTable(
                name: "sexes",
                columns: table => new
                {
                    sexid = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    description = table.Column<string>(type: "text", nullable: true),
                    recordstatusid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_sexes", x => x.sexid);
                });

            migrationBuilder.CreateTable(
                name: "ssn_tokens",
                columns: table => new
                {
                    token = table.Column<Guid>(type: "uuid", nullable: false),
                    encrypted_ssn = table.Column<byte[]>(type: "bytea", nullable: true),
                    created_at = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    expires_at = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ssn_tokens", x => x.token);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "aliases");

            migrationBuilder.DropTable(
                name: "contacttypes");

            migrationBuilder.DropTable(
                name: "coreidentity");

            migrationBuilder.DropTable(
                name: "coreidentityaliases");

            migrationBuilder.DropTable(
                name: "coreidentityemails");

            migrationBuilder.DropTable(
                name: "coreidentityphones");

            migrationBuilder.DropTable(
                name: "coreidentitypostaladdresses");

            migrationBuilder.DropTable(
                name: "defaultitems");

            migrationBuilder.DropTable(
                name: "emails");

            migrationBuilder.DropTable(
                name: "geography");

            migrationBuilder.DropTable(
                name: "geographytypes");

            migrationBuilder.DropTable(
                name: "menuitems");

            migrationBuilder.DropTable(
                name: "menuitemtypes");

            migrationBuilder.DropTable(
                name: "phones");

            migrationBuilder.DropTable(
                name: "postaladdresses");

            migrationBuilder.DropTable(
                name: "prefixsuffix");

            migrationBuilder.DropTable(
                name: "sexes");

            migrationBuilder.DropTable(
                name: "ssn_tokens");
        }
    }
}
