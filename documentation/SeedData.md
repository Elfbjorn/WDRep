# General Rules
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

