




-- DDL for OrganizationsHistory
DROP TABLE IF EXISTS OrganizationsHistory CASCADE;
CREATE TABLE OrganizationsHistory (
    OrganizationsHistoryId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    OrganizationId INT NOT NULL, -- FK to Organizations (deferred)
    OrganizationName VARCHAR(255) NOT NULL,
    OrganizationTypeId INT NOT NULL, -- FK to OrganizationTypes (deferred)
    Address1 VARCHAR(255),
    Address2 VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    ZipCode VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(255),
    Website VARCHAR(255),
    Operation VARCHAR(10) NOT NULL, -- INSERT, UPDATE, DELETE
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for RecordStatuses
DROP TABLE IF EXISTS RecordStatuses CASCADE;
CREATE TABLE RecordStatuses (
    RecordStatusId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20)  NULL,
    StatusAbbreviation VARCHAR(50) NOT NULL UNIQUE,
    StatusName VARCHAR(255) NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for CoreIdentityInvestigationRequests
DROP TABLE IF EXISTS CoreIdentityInvestigationRequests CASCADE;
CREATE TABLE CoreIdentityInvestigationRequests (
    CoreIdentityInvestigationRequestId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    InvestigationRequestId INT NOT NULL, -- FK to InvestigationRequest (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    AssignmentDate TIMESTAMP NOT NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for ServiceProviders
DROP TABLE IF EXISTS ServiceProviders CASCADE;
CREATE TABLE ServiceProviders (
    ServiceProviderId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    ProviderName VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(255) NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

DROP TABLE IF EXISTS InvestigationRequest CASCADE;
CREATE TABLE InvestigationRequest (
    InvestigationRequestId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    SpecialistAssignedId INT NULL, -- FK to CoreIdentity (deferred)
    ServiceProviderId INT NULL, -- FK to ServiceProviders (deferred)
    InvestigationTypeId INT NULL, -- FK to InvestigationTypeLookup (deferred)
    SentDate TIMESTAMP NULL,
    CompletionDate TIMESTAMP NULL,
    ReceivedDate TIMESTAMP NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for DecisionLookup
DROP TABLE IF EXISTS DecisionLookup CASCADE;
CREATE TABLE DecisionLookup (
    DecisionLookupId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    DecisionName VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(255) NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Adjudications
DROP TABLE IF EXISTS Adjudications CASCADE;
CREATE TABLE Adjudications (
    AdjudicationId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    FirstAdjudicatorId INT NULL, -- FK to CoreIdentity (deferred)
    FirstDecisionDate TIMESTAMP NULL,
    FirstDecisionId INT NULL, -- FK to DecisionLookup (deferred)
    SecondAdjudicatorId INT NULL, -- FK to CoreIdentity (deferred)
    SecondDecisionDate TIMESTAMP NULL,
    SecondDecisionId INT NULL, -- FK to DecisionLookup (deferred)
    ThirdAdjudicatorId INT NULL, -- FK to CoreIdentity (deferred)
    ThirdDecisionDate TIMESTAMP NULL,
    ThirdDecisionId INT NULL, -- FK to DecisionLookup (deferred)
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for CoreIdentityAdjudications
DROP TABLE IF EXISTS CoreIdentityAdjudications CASCADE;
CREATE TABLE CoreIdentityAdjudications (
    CoreIdentityAdjudicationId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    AdjudicationId INT NOT NULL, -- FK to Adjudications (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    AssignmentDate TIMESTAMP NOT NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for CountryCodeLookup
DROP TABLE IF EXISTS CountryCodeLookup CASCADE;
CREATE TABLE CountryCodeLookup (
    CountryCodeLookupId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CountryCode VARCHAR(10) NOT NULL UNIQUE,
    CountryId INT NOT NULL, -- FK to CountryLookup (deferred)
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for CountryLookup
DROP TABLE IF EXISTS CountryLookup CASCADE;
CREATE TABLE CountryLookup (
    CountryLookupId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    CountryName VARCHAR(100) NOT NULL UNIQUE,
    IsoCode VARCHAR(3) NOT NULL UNIQUE,
    DialingCode VARCHAR(5) NOT NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for RelationshipTypeLookup
DROP TABLE IF EXISTS RelationshipTypeLookup CASCADE;
CREATE TABLE RelationshipTypeLookup (
    RelationshipTypeLookupId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    RelationshipName VARCHAR(50) NOT NULL UNIQUE,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for SocialMediaPlatformLookup
DROP TABLE IF EXISTS SocialMediaPlatformLookup CASCADE;
CREATE TABLE SocialMediaPlatformLookup (
    SocialMediaPlatformLookupId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    PlatformName VARCHAR(50) NOT NULL UNIQUE,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for EmergencyContacts
DROP TABLE IF EXISTS EmergencyContacts CASCADE;
CREATE TABLE EmergencyContacts (
    EmergencyContactId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    PointOfContactId INT NOT NULL, -- FK to PointsOfContact (deferred)
    RelationshipTypeId INT NOT NULL, -- FK to RelationshipTypeLookup (deferred)
    ContactSequence INT NOT NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Phones
DROP TABLE IF EXISTS Phones CASCADE;
CREATE TABLE Phones (
    PhoneId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CountryCodeId INT NOT NULL, -- FK to CountryCodeLookup (deferred)
    AreaCode VARCHAR(10) NULL,
    Number VARCHAR(20) NOT NULL,
    Extension VARCHAR(10) NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

DROP TABLE IF EXISTS CoreIdentityPhones CASCADE;
CREATE TABLE CoreIdentityPhones (
    CoreIdentityPhoneId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    PhoneId INT NOT NULL, -- FK to Phones (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Emails
DROP TABLE IF EXISTS Emails CASCADE;
CREATE TABLE Emails (
    EmailId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    EmailAddress VARCHAR(320) NOT NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for CoreIdentityEmails
DROP TABLE IF EXISTS CoreIdentityEmails CASCADE;
CREATE TABLE CoreIdentityEmails (
    CoreIdentityEmailId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    EmailId INT NOT NULL, -- FK to Emails (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for PostalAddresses
DROP TABLE IF EXISTS PostalAddresses CASCADE;
CREATE TABLE PostalAddresses (
    PostalAddressId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    Address1 VARCHAR(255) NOT NULL,
    Address2 VARCHAR(255) NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(20) NOT NULL,
    CountryId INT NOT NULL, -- FK to CountryLookup (deferred)
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for CoreIdentityPostalAddresses
DROP TABLE IF EXISTS CoreIdentityPostalAddresses CASCADE;
CREATE TABLE CoreIdentityPostalAddresses (
    CoreIdentityPostalAddressId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    PostalAddressId INT NOT NULL, -- FK to PostalAddresses (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

DROP TABLE IF EXISTS SocialMedia CASCADE;
CREATE TABLE SocialMedia (
    SocialMediaId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    Platform VARCHAR(50) NOT NULL,
    Handle VARCHAR(100) NOT NULL,
    Url VARCHAR(255) NULL,
    IsPrimary BOOLEAN NOT NULL DEFAULT FALSE,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for CoreIdentitySocialMedia
DROP TABLE IF EXISTS CoreIdentitySocialMedia CASCADE;
CREATE TABLE CoreIdentitySocialMedia (
    CoreIdentitySocialMediaId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    SocialMediaId INT NOT NULL, -- FK to SocialMedia (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for PointsOfContactPhones
DROP TABLE IF EXISTS PointsOfContactPhones CASCADE;
CREATE TABLE PointsOfContactPhones (
    PointsOfContactPhoneId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    PointOfContactId INT NOT NULL, -- FK to PointsOfContact (deferred)
    PhoneId INT NOT NULL, -- FK to Phones (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for PointsOfContactEmails
DROP TABLE IF EXISTS PointsOfContactEmails CASCADE;
CREATE TABLE PointsOfContactEmails (
    PointsOfContactEmailId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    PointOfContactId INT NOT NULL, -- FK to PointsOfContact (deferred)
    EmailId INT NOT NULL, -- FK to Emails (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for PointsOfContactPostalAddresses
DROP TABLE IF EXISTS PointsOfContactPostalAddresses CASCADE;
CREATE TABLE PointsOfContactPostalAddresses (
    PointsOfContactPostalAddressId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    PointOfContactId INT NOT NULL, -- FK to PointsOfContact (deferred)
    PostalAddressId INT NOT NULL, -- FK to PostalAddresses (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for PointsOfContactSocialMedia
DROP TABLE IF EXISTS PointsOfContactSocialMedia CASCADE;
CREATE TABLE PointsOfContactSocialMedia (
    PointsOfContactSocialMediaId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    PointOfContactId INT NOT NULL, -- FK to PointsOfContact (deferred)
    SocialMediaId INT NOT NULL, -- FK to SocialMedia (deferred)
    ContactTypeId INT NOT NULL, -- FK to ContactTypeLookup (deferred)
    ContactSequence INT NOT NULL DEFAULT 1,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for ContactTypeLookup
DROP TABLE IF EXISTS ContactTypeLookup CASCADE;
CREATE TABLE ContactTypeLookup (
    ContactTypeLookupId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    TypeName VARCHAR(50) NOT NULL UNIQUE,
    AppliesToPhone BOOLEAN NOT NULL DEFAULT FALSE,
    AppliesToEmail BOOLEAN NOT NULL DEFAULT FALSE,
    AppliesToAddress BOOLEAN NOT NULL DEFAULT FALSE,
    AppliesToSocial BOOLEAN NOT NULL DEFAULT FALSE,
    Description VARCHAR(255) NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

DROP TABLE IF EXISTS CoreIdentity CASCADE;
CREATE TABLE CoreIdentity (
    CoreIdentityId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    PrefixId INT NULL, -- FK to PrefixSuffix (deferred)
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50) NULL,
    LastName VARCHAR(50) NOT NULL,
    SuffixId INT NULL, -- FK to PrefixSuffix (deferred)
    SSN CHAR(9) NOT NULL,
    DOB TIMESTAMP NOT NULL,
    PlaceOfBirthId INT NOT NULL, -- FK to Geography (deferred)
    SexId INT NOT NULL, -- FK to Lookup (deferred)
    LegacyID VARCHAR(11) NULL,
    PreferredName VARCHAR(50) NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Aliases
DROP TABLE IF EXISTS Aliases CASCADE;
CREATE TABLE Aliases (
    AliasId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CoreIdentityId INT NOT NULL, -- FK to CoreIdentity (deferred)
    Alias VARCHAR(2000) NOT NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for ContactTypes
DROP TABLE IF EXISTS ContactTypes CASCADE;
CREATE TABLE ContactTypes (
    ContactTypeId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    ContactTypeName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for OrganizationTypes
DROP TABLE IF EXISTS OrganizationTypes CASCADE;
CREATE TABLE OrganizationTypes (
    OrganizationTypeId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    OrganizationTypeName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for ContractTypes
DROP TABLE IF EXISTS ContractTypes CASCADE;
CREATE TABLE ContractTypes (
    ContractTypeId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    ContractTypeName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for AssignmentTypes
DROP TABLE IF EXISTS AssignmentTypes CASCADE;
CREATE TABLE AssignmentTypes (
    AssignmentTypeId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    AssignmentTypeName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

DROP TABLE IF EXISTS AssignmentStatuses CASCADE;
CREATE TABLE AssignmentStatuses (
    AssignmentStatusId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    AssignmentStatusName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Organizations
DROP TABLE IF EXISTS Organizations CASCADE;
CREATE TABLE Organizations (
    OrganizationId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    OrganizationName VARCHAR(255) NOT NULL,
    OrganizationTypeId INT NOT NULL, -- FK to OrganizationTypes (deferred)
    Address1 VARCHAR(255),
    Address2 VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    ZipCode VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(255),
    Website VARCHAR(255),
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Vendors
DROP TABLE IF EXISTS Vendors CASCADE;
CREATE TABLE Vendors (
    VendorId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    VendorName VARCHAR(255) NOT NULL,
    ContactPersonName VARCHAR(255),
    Address1 VARCHAR(255),
    Address2 VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    ZipCode VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(255),
    Website VARCHAR(255),
    TaxId VARCHAR(50),
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Contracts
DROP TABLE IF EXISTS Contracts CASCADE;
CREATE TABLE Contracts (
    ContractId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    ContractNumber VARCHAR(100) NOT NULL UNIQUE,
    ContractName VARCHAR(255) NOT NULL,
    ContractTypeId INT NOT NULL, -- FK to ContractTypes (deferred)
    OrganizationId INT NOT NULL, -- FK to Organizations (deferred)
    VendorId INT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    ContractValue DECIMAL(15, 2),
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

-- DDL for Contacts
DROP TABLE IF EXISTS Contacts CASCADE;
CREATE TABLE Contacts (
    ContactId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    ContactTypeId INT NOT NULL, -- FK to ContactTypes (deferred)
    OrganizationId INT,
    VendorId INT,
    Title VARCHAR(100),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Mobile VARCHAR(20),
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL,
    CONSTRAINT chk_contact_entity CHECK (
        (
            OrganizationId IS NOT NULL
            AND VendorId IS NULL
        )
        OR (
            OrganizationId IS NULL
            AND VendorId IS NOT NULL
        )
    )
    -- All FKs deferred
);

-- DDL for Assignments
DROP TABLE IF EXISTS Assignments CASCADE;
CREATE TABLE Assignments (
    AssignmentId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    WorkerId INT NOT NULL, -- FK to CoreIdentity (deferred)
    OrganizationId INT NOT NULL, -- FK to Organizations (deferred)
    ContractId INT,
    AssignmentTypeId INT NOT NULL, -- FK to AssignmentTypes (deferred)
    AssignmentStatusId INT NOT NULL, -- FK to AssignmentStatuses (deferred)
    StartDate DATE NOT NULL,
    EndDate DATE,
    HoursPerWeek DECIMAL(5, 2),
    HourlyRate DECIMAL(10, 2),
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

DROP TABLE IF EXISTS TablePrefixes CASCADE;
CREATE TABLE TablePrefixes (
    PrefixId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    TableName VARCHAR(50) NOT NULL UNIQUE,
    TablePrefix VARCHAR(255) NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedDate TIMESTAMP NULL,
    DeletedDate TIMESTAMP NULL,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedBy INT NULL -- FK to CoreIdentity (deferred)
);

-- DDL for Sexes
DROP TABLE IF EXISTS Sexes CASCADE;
CREATE TABLE Sexes (
    SexId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20)  NULL,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    Description TEXT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

CREATE TABLE geography (
    GeographyId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    Description TEXT,
    GeographyTypeID INT NOT NULL, -- FK to GeographyTypes (deferred)
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

CREATE TABLE GeographyTypes (
    GeographyTypeId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    Description TEXT,
    RecordStatusId INT NOT NULL, -- FK to RecordStatuses (deferred)
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    CreatedIpAddress VARCHAR(45) NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedIpAddress VARCHAR(45) NOT NULL,
    DeletedDate TIMESTAMP NULL,
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedIpAddress VARCHAR(45) NULL
    -- All FKs deferred
);

DROP TABLE if exists PrefixSuffix  CASCADE;
create table PrefixSuffix (
    PrefixSuffixId SERIAL PRIMARY KEY,
    HumanReadableId VARCHAR(20) NULL,
    Description VARCHAR(255) not NULL,
    Category char(6) not null,
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedDate TIMESTAMP NULL,
    DeletedDate TIMESTAMP NULL,
    CreatedBy INT NOT NULL, -- FK to CoreIdentity (deferred)
    ModifiedBy INT NULL, -- FK to CoreIdentity (deferred)
    DeletedBy INT NULL, -- FK to CoreIdentity (deferred)
    CreatedIPAddress varchar(45) not null,
    ModifiedIPAddress varchar(45) not null,
    DeletedIPAddress varchar(45) null
);
