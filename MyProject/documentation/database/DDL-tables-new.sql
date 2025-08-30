DROP TABLE IF EXISTS Packages CASCADE;
CREATE TABLE Packages (
	PackagesId SERIAL PRIMARY KEY,
	HumanReadableId VARCHAR(20) NULL,
	RecordStatusId INT NOT NULL,
	SpecialistId INT NOT NULL,
	PackageTypeId INT NOT NULL,
	PackageComments TEXT NULL,
	SF86Required BOOLEAN NOT NULL,
	CreatedBy INT NOT NULL,
	CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CreatedIpAddress VARCHAR(45) NOT NULL DEFAULT '::0',
	ModifiedBy INT NULL,
	ModifiedDate TIMESTAMP NULL,
	ModifiedIpAddress VARCHAR(45) NULL,
	DeletedBy INT NULL,
	DeletedDate TIMESTAMP NULL,
	DeletedIpAddress VARCHAR(45) NULL
	-- All FKs deferred
);

DROP TABLE IF EXISTS PackageTypes CASCADE;
CREATE TABLE PackageTypes (
	PackageTypesId SERIAL PRIMARY KEY,
	HumanReadableId VARCHAR(20) NULL,
	RecordStatusId INT NOT NULL,
	PackageTypeName VARCHAR(100) NOT NULL UNIQUE,
	Description VARCHAR(255) NULL,
	CreatedBy INT NOT NULL,
	CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CreatedIpAddress VARCHAR(45) NOT NULL DEFAULT '::0',
	ModifiedBy INT NULL,
	ModifiedDate TIMESTAMP NULL,
	ModifiedIpAddress VARCHAR(45) NULL,
	DeletedBy INT NULL,
	DeletedDate TIMESTAMP NULL,
	DeletedIpAddress VARCHAR(45) NULL
	-- All FKs deferred
);

DROP TABLE IF EXISTS FormTypes CASCADE;
CREATE TABLE FormTypes (
	FormTypesId SERIAL PRIMARY KEY,
	HumanReadableId VARCHAR(20) NULL,
	RecordStatusId INT NOT NULL,
	FormTypeName VARCHAR(100) NOT NULL UNIQUE,
	Description VARCHAR(255) NULL,
	CreatedBy INT NOT NULL,
	CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CreatedIpAddress VARCHAR(45) NOT NULL DEFAULT '::0',
	ModifiedBy INT NULL,
	ModifiedDate TIMESTAMP NULL,
	ModifiedIpAddress VARCHAR(45) NULL,
	DeletedBy INT NULL,
	DeletedDate TIMESTAMP NULL,
	DeletedIpAddress VARCHAR(45) NULL
	-- All FKs deferred
);

DROP TABLE IF EXISTS PackageFormEvents CASCADE;
CREATE TABLE PackageFormEvents (
	PackageFormEventsId SERIAL PRIMARY KEY,
	HumanReadableId VARCHAR(20) NULL,
	RecordStatusId INT NOT NULL,
	PackageId INT NOT NULL,
	FormTypeId INT NOT NULL,
	EventType VARCHAR(20) NOT NULL,
	EventDate TIMESTAMP NOT NULL,
	Comments VARCHAR(255) NULL,
	CreatedBy INT NOT NULL,
	CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CreatedIpAddress VARCHAR(45) NOT NULL DEFAULT '::0',
	ModifiedBy INT NULL,
	ModifiedDate TIMESTAMP NULL,
	ModifiedIpAddress VARCHAR(45) NULL,
	DeletedBy INT NULL,
	DeletedDate TIMESTAMP NULL,
	DeletedIpAddress VARCHAR(45) NULL
	-- All FKs deferred
);

DROP TABLE IF EXISTS AuditLogs CASCADE;
CREATE TABLE AuditLogs (
	AuditLogsId SERIAL PRIMARY KEY,
	HumanReadableId VARCHAR(20) NULL,
	RecordStatusId INT NOT NULL,
	TableName VARCHAR(100) NOT NULL,
	RecordId VARCHAR(100) NOT NULL,
	Operation VARCHAR(10) NOT NULL,
	ChangedData JSONB NULL,
	CreatedBy INT NOT NULL,
	CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CreatedIpAddress VARCHAR(45) NOT NULL DEFAULT '::0',
	ModifiedBy INT NULL,
	ModifiedDate TIMESTAMP NULL,
	ModifiedIpAddress VARCHAR(45) NULL,
	DeletedBy INT NULL,
	DeletedDate TIMESTAMP NULL,
	DeletedIpAddress VARCHAR(45) NULL
	-- All FKs deferred
);
-- DDL-tables-new.sql
-- This file contains tables that appear only once in the original DDL or are easily deconflicted (same columns/types, possibly different order).
-- All table names are pluralized per DatabaseRules.md. All base columns and trigger requirements are applied.

-- Example (replace with actual tables after analysis):
-- CREATE TABLE ExamplePlural (
--     ExamplePluralId SERIAL PRIMARY KEY,
--     HumanReadableId VARCHAR(20) NULL,
--     RecordStatusId INT NOT NULL,
--     CreatedBy INT NOT NULL,
--     CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     CreatedIpAddress VARCHAR(45) NOT NULL DEFAULT '::0',
--     ModifiedBy INT NULL,
--     ModifiedDate TIMESTAMP NULL,
--     ModifiedIpAddress VARCHAR(45) NULL,
--     DeletedBy INT NULL,
--     DeletedDate TIMESTAMP NULL,
--     DeletedIpAddress VARCHAR(45) NULL,
--     -- Table-specific columns here
-- );
