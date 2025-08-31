-- Seed data for TablePrefixes
INSERT INTO TablePrefixes (TableName, TablePrefix, RecordStatusId, CreatedBy, CreatedDate, CreatedIP, ModifiedBy, ModifiedDate, ModifiedIP, DeletedBy, DeletedDate, DeletedIP)
VALUES
('TablePrefixes', 'TP', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('RecordStatuses', 'REC', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Sexes', 'SX', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('PrefixesSuffixes', 'PS', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Vendors', 'VEN', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Phones', 'PHN', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('CoreIdentities', 'CI', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Adjudications', 'ADJ', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Aliases', 'AL', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Assignments', 'ASN', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Assignment Types', 'AST', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Contacts', 'CON', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('ContactTypes', 'CT', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Contracts', 'CTR', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('ContractTypes', 'CTT', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Geography', 'GEO', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('GeographyTypes', 'GET', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('PointsOfContact', 'POC', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('EmailAddresses', 'EML', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('PostalAddresses', 'PAD', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Organizations', 'ORG', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('OrganizationTypes', 'ORT', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for RecordStatuses
INSERT INTO RecordStatuses (StatusAbbreviation, StatusName, RecordStatusId, CreatedBy, CreatedDate, CreatedIP, ModifiedBy, ModifiedDate, ModifiedIP, DeletedBy, DeletedDate, DeletedIP)
VALUES
('A', 'Active', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('I', 'Inactive', 2, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('D', 'Deleted', 3, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('R', 'Archived', 4, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for PrefixSuffix
INSERT INTO PrefixSuffix (Description, Category, RecordStatusId, CreatedBy, CreatedDate, CreatedIP, ModifiedBy, ModifiedDate, ModifiedIP, DeletedBy, DeletedDate, DeletedIP)
VALUES
('Mr.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Ms.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Mrs.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Sir', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Lady', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Miss', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Dr.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Gen.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Adm.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Col.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Lt. Col.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Maj.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Cpt.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Lt.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Ens.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Sgt.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Cpl.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Pvt.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Hon.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Sen.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Rep.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Mayor', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Gov.', 'Prefix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Sr.', 'Suffix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Jr.', 'Suffix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('III', 'Suffix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('IV', 'Suffix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('V', 'Suffix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('MD', 'Suffix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Esq.', 'Suffix', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for CoreIdentity
INSERT INTO CoreIdentity (FirstName, LastName, SSN, DOB, PlaceOfBirthId, SexId, RecordStatusId, CreatedBy, CreatedDate, CreatedIP, ModifiedBy, ModifiedDate, ModifiedIP, DeletedBy, DeletedDate, DeletedIP)
VALUES ('System', 'User', '000112222', '2025-08-30', 1, 3, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for Sexes
INSERT INTO Sexes (Description, RecordStatusId, CreatedBy, CreatedDate, CreatedIP, ModifiedBy, ModifiedDate, ModifiedIP, DeletedBy, DeletedDate, DeletedIP)
VALUES
('Female', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Male', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Unspecified', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for GeographyTypes
INSERT INTO GeographyTypes (Description, RecordStatusId, CreatedBy, CreatedDate, CreatedIP, ModifiedBy, ModifiedDate, ModifiedIP, DeletedBy, DeletedDate, DeletedIP)
VALUES
('Country', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('State', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('City', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for Geographies
INSERT INTO Geography (Description, GeographyTypeId, RecordStatusId, CreatedBy, CreatedDate, CreatedIP, ModifiedBy, ModifiedDate, ModifiedIP, DeletedBy, DeletedDate, DeletedIP)
VALUES
('United States', 1, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Canada', 1, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('New York', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Florida', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('California', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Arizona', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Wisconsin', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Kansas', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Kentucky', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Ontario', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Quebec', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('Saskatchewan', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('British Columbia', 2, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);
