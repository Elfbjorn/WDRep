# General Rules

## Database Assumptions

At the time of this writing, everything is designed for PostgreSQL.  However, it is possible this will change to a SQL Server 2022 environment.  For now, focus on PostreSQL.

## Triggers

A trigger is required to ensure that the HumanReadableID field is maintained up-to-date.  The trigger will operate as follows:

- On insert or update, determine the name of the table being acted on
  - This includes non-trigger-based update attempts to the HumanReadableID field itself
- Query the `TablePrefixes` table (case-insensitive comparison) to determine the `TablePrefix` for the given table
  - Maintain the uppercase prefix
  - If no match is found, use the prefix `UNK`
- Append a hyphen character
- Append the primary key value, left-padded with 0's, to 8 characters (beyond the hyphen)
  - If the number of characters in the primary key value is greater than 8, append the entirety of the value

A trigger is required to update the `ModifiedBy`, `ModifiedDate`, and `ModifiedIP` fields for each table on new inserts.  These values will default to the values in `CreatedBy`, `CreatedDate`, and `CreatedIP` fields.
 
**Examples**

| Table Name | Table Prefix | Primary Key Value | Human Readable ID |
| --- | --- | --- | --- |
| CoreIdentities | CI | 17 | CI-00000017 |
| Vendors | VEN | 12483957 | VEN-12483957 |
| Contracts | CTR | 938475913 | CTR-938475913 |


## Table Column Requirements

All tables will have the following structure:

| Column Name | Column Type | Nullable? | Notes |
| --- | --- | --- | --- |
| `Primary Key` | INT | No | Name will be `[TableNameInSingularForm]ID` |
| HumanReadableID | VARCHAR(20) | Yes | Will be populated and maintained by a trigger |
| // These will be the table-specific values | Depends | Depends | More information to come |
| RecordStatusID | INT | No | Foreign key to `RecordStatuses` table; default value of whatever `Active` ID is |
| CreatedBy | INT | No | Foreign key to `CoreIdentity` table |
| CreatedDate | Timestamp | No | Default to `current_timestamp` |
| CreatedIP | VARCHAR(45) | No | Default to '::0' |
| ModifiedBy | INT | Yes | Trigger will populate on insert to `CreatedBy` value; FK to `CoreIdentity` table on new insert |
| ModifiedDate | Timestamp | Yes | Trigger will populate on insert to `CreatedDate` value on new insert |
| ModifiedIP | VARCHAR(45) | Yes | Trigger will populate on insert to `CreatedIP` value on new insert |
| DeletedBy | INT | Yes | Does not get populated on insert or modify unless `RecordStatusID` becomes the value of `Deleted`; FK to `CoreIdentity` table |
| DeletedDate | Timestamp | Yes | Does not get populated on insert or modify unless `RecordStatusID` becomes the value of `Deleted` |
| DeletedIP | VARCHAR(45) | Yes | Does not get populated on insert or modify unless `RecordStatusID` becomes the value of `Deleted` |


## Seed Data Defaults

All inserts performed will use the following default values:

| Field Name | Field Value |
| --- | --- |
| CreatedBy | 0 |
| CreatedDate | `current_timestamp` |
| CreatedIP | ::0 |
| ModifiedBy | 0 |
| ModifiedDate | `current_timestamp` |
| ModifiedIP | ::0 |
| DeletedBy | `null` |
| DeletedDate | `null` |
| DeletedIP | `null` |
| RecordStatusID | 1 |

# Seeding Values
The values below are those that are specific to the table in question.  Any fields or values not provided are assumed to be null.

## TablePrefixes

| TableName | TablePrefix |
| --- | --- |
| TablePrefixes | TP |
| RecordStatuses | REC |
| Sexes | SX |
| PrefixesSuffixes | PS |
| Vendors | VEN |
| Phones | PHN |
| CoreIdentities | CI |
| Adjudications | ADJ |
| Aliases | AL |
| Assignments | ASN |
| Assignment Types | AST |
| Contacts | CON |
| ContactTypes | CT |
| Contracts | CTR |
| ContractTypes | CTT |
| Geography | GEO |
| GeographyTypes | GET |
| PointsOfContact | POC |
| EmailAddresses | EML |
| PostalAddresses | PAD |
| Organizations | ORG |
| OrganizationTypes | ORT |

## RecordStatuses

| StatusAbbreviation | StatusDescription |
| --- | --- |
| A | Active |
| I | Inactive |
| D | Deleted |
| R | Archived |

## PrefixesSuffixes

| Description | Category |
| --- | --- |
| Mr. | Prefix |
| Ms. | Prefix |
| Mrs. | Prefix |
| Sir | Prefix |
| Lady | Prefix |
| Miss | Prefix |
| Dr. | Prefix |
| Gen. | Prefix |
| Adm. | Prefix |
| Col. | Prefix |
| Lt. Col. | Prefix |
| Maj. | Prefix |
| Cpt. | Prefix |
| Lt. | Prefix |
| Ens. | Prefix |
| Sgt. | Prefix |
| Cpl. | Prefix |
| Pvt. | Prefix |
| Hon. | Prefix |
| Sen. | Prefix |
| Rep. | Prefix |
| Mayor | Prefix |
| Gov. | Prefix |
| Sr. | Suffix |
| Jr. | Suffix |
| III | Suffix |
| IV | Suffix | 
| V | Suffix |
| MD | Suffix |
| Esq. | Suffix |

## CoreIdentities

| FirstName | LastName | SSN | DOB | PlaceOfBirth | SexId | 
| System | User | 000112222 | 2025-08-30 | 1 | 3 |

## Sexes

| Abbreviation | Description |
| --- | --- |
| F | Female |
| M | Male |
| X | Unspecified |

## GeographyTypes

| Description |
| --- |
| Country |
| State |
| City |

## Geographies

| GeographyName | GeographyAbbr | GeographyTypeID | ParentID |
| --- | --- | --- | --- |
| United States | US | `lookup to GeographyTypes: Country` | `null` |
| Canada | CA | `lookup to GeographyTypes: Country` | `null` |
| New York | NY | `lookup to GeographyTypes: State` | `lookup to Geographyies: United States` |
| Florida | FL | `lookup to GeographyTypes: State` | `lookup to Geographyies: United States` |
| California | CA | `lookup to GeographyTypes: State` | `lookup to Geographyies: United States` |
| Arizona | AZ | `lookup to GeographyTypes: State` | `lookup to Geographyies: United States` |
| Wisconsin | WI | `lookup to GeographyTypes: State` | `lookup to Geographyies: United States` |
| Kansas | KS | `lookup to GeographyTypes: State` | `lookup to Geographyies: United States` |
| Kentucky | KY | `lookup to GeographyTypes: State` | `lookup to Geographyies: United States` |
| Ontario | ON | `lookup to GeographyTypes: State` | `lookup to Geographyies: Canada` |
| Quebec | QC | `lookup to GeographyTypes: State` | `lookup to Geographyies: Canada` |
| Saskatchewan | SK | `lookup to GeographyTypes: State` | `lookup to Geographyies: Canada` |
| British Columbia | BC | `lookup to GeographyTypes: State` | `lookup to Geographyies: Canada` |

