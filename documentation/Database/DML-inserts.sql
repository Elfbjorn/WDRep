-- Seed data for TablePrefixes
DELETE FROM tableprefixes;
INSERT INTO tableprefixes (tablename, tableprefix, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip)
VALUES
('tableprefixes', 'TP', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('recordstatuses', 'REC', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('sexes', 'SX', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('prefixsuffix', 'PS', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('vendors', 'VEN', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('phones', 'PHN', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('coreidentity', 'CI', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('adjudications', 'ADJ', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('aliases', 'AL', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('assignments', 'ASN', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('assignmenttypes', 'AST', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('contacts', 'CON', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('contacttypes', 'CT', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('contracts', 'CTR', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('contracttypes', 'CTT', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('geography', 'GEO', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('geographytypes', 'GET', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('pointsofcontact', 'POC', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('emailaddresses', 'EML', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('postaladdresses', 'PAD', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('organizations', 'ORG', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('organizationtypes', 'ORT', 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for RecordStatuses
DELETE FROM recordstatuses;
INSERT INTO recordstatuses (statusabbreviation, statusname, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip)
VALUES
('A', 'Active', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('I', 'Inactive', 2, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('D', 'Deleted', 3, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('R', 'Archived', 4, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for PrefixSuffix
INSERT INTO prefixsuffix (description, category, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip)
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


DELETE FROM coreidentity;
DELETE FROM sexes;
INSERT INTO sexes (sexid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip)
OVERRIDING SYSTEM VALUE
VALUES
(1, 'Female', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
(2, 'Male', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
(3, 'Unspecified', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

DELETE FROM coreidentity;
INSERT INTO coreidentity (firstname, lastname, ssn, dob, placeofbirthid, sexid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip)
VALUES ('System', 'User', pgp_sym_encrypt('000112222'::text, '3ncrYp+ed'::text), '2025-08-30', 1, 3, 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

INSERT INTO geographytypes (description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip)
VALUES
('Country', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('State', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL),
('City', 1, 0, current_timestamp, '::0', 0, current_timestamp, '::0', NULL, NULL, NULL);

-- Seed data for Geographies
INSERT INTO geography (geographyname, geographytypeid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip)
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


INSERT INTO contacttypes (
  contacttypename, appliestoemail, appliestophone, appliestopostaladdress, appliestosocialmedia, appliestowebsite,
  recordstatusid, createdby, createdip
) VALUES
('Home',   TRUE, TRUE, TRUE, FALSE, FALSE, 1, 1, '::0'),
('Work',   TRUE, TRUE, TRUE, FALSE, FALSE, 1, 1, '::0'),
('School', TRUE, TRUE, TRUE, FALSE, FALSE, 1, 1, '::0'),
('Mobile', FALSE, TRUE, FALSE, FALSE, FALSE, 1, 1, '::0');

INSERT INTO defaultitems (defaultitempage, defaultitemtab, cancellink, cancellinktext, previouslink, previouslinktext, nextlink, nextlinktext, recordstatusid)
VALUES
('check-ssn', '', 'check-ssn', 'No', '', '', 'create-identity.Basic Information', 'Yes', 1),
('create-identity', 'Basic Information', 'check-ssn', 'Cancel', '', '', 'create-identity.Contact Information', 'Next', 1),
('create-identity', 'Contact Information', 'check-ssn', 'Cancel', 'create-identity.Basic Information', 'Back', 'create-alignment.Organization', 'Next', 1)'
