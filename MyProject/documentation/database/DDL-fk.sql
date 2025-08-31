-- Foreign Key Constraints
-- Ambiguities: OrganizationTypeId (no OrganizationTypes table), PointOfContactId (no PointsOfContact table)

ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_organizationid;
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_organizationid;
ALTER TABLE organizationshistory ADD CONSTRAINT fk_organizationshistory_organizationid FOREIGN KEY (organizationid) REFERENCES organizations(organizationid);
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_organizationtypeid;
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_organizationtypeid;
ALTER TABLE organizationshistory ADD CONSTRAINT fk_organizationshistory_organizationtypeid FOREIGN KEY (organizationtypeid) REFERENCES organizationtypes(organizationtypeid);
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_recordstatusid;
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_recordstatusid;
ALTER TABLE organizationshistory ADD CONSTRAINT fk_organizationshistory_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_createdby;
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_createdby;
ALTER TABLE organizationshistory ADD CONSTRAINT fk_organizationshistory_createdby FOREIGN KEY (createdby) REFERENCES coreidentity(coreidentityid);
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_modifiedby;
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_modifiedby;
ALTER TABLE organizationshistory ADD CONSTRAINT fk_organizationshistory_modifiedby FOREIGN KEY (modifiedby) REFERENCES coreidentity(coreidentityid);
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_deletedby;
ALTER TABLE organizationshistory DROP CONSTRAINT IF EXISTS fk_organizationshistory_deletedby;
ALTER TABLE organizationshistory ADD CONSTRAINT fk_organizationshistory_deletedby FOREIGN KEY (deletedby) REFERENCES coreidentity(coreidentityid);

ALTER TABLE coreidentityinvestigationrequests DROP CONSTRAINT IF EXISTS fk_ciir_investigationrequestid;
ALTER TABLE coreidentityinvestigationrequests DROP CONSTRAINT IF EXISTS fk_ciir_investigationrequestid;
ALTER TABLE coreidentityinvestigationrequests ADD CONSTRAINT fk_ciir_investigationrequestid FOREIGN KEY (investigationrequestid) REFERENCES investigationrequest(investigationrequestid);
ALTER TABLE coreidentityinvestigationrequests DROP CONSTRAINT IF EXISTS fk_ciir_coreidentityid;
ALTER TABLE coreidentityinvestigationrequests ADD CONSTRAINT fk_ciir_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE coreidentityinvestigationrequests DROP CONSTRAINT IF EXISTS fk_ciir_recordstatusid;
ALTER TABLE coreidentityinvestigationrequests ADD CONSTRAINT fk_ciir_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE coreidentityadjudications ADD CONSTRAINT fk_cia_adjudicationid FOREIGN KEY (adjudicationid) REFERENCES adjudications(adjudicationid);
ALTER TABLE coreidentityadjudications ADD CONSTRAINT fk_cia_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE coreidentityadjudications ADD CONSTRAINT fk_cia_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE emergencycontacts ADD CONSTRAINT fk_ec_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE emergencycontacts ADD CONSTRAINT fk_ec_relationshiptypeid FOREIGN KEY (relationshiptypeid) REFERENCES relationshiptypes(relationshiptypeid);
ALTER TABLE emergencycontacts ADD CONSTRAINT fk_ec_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE phones ADD CONSTRAINT fk_phones_countrycodeid FOREIGN KEY (countrycodeid) REFERENCES countrycodes(countrycodeid);
ALTER TABLE phones ADD CONSTRAINT fk_phones_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE coreidentityphones ADD CONSTRAINT fk_cip_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE coreidentityphones ADD CONSTRAINT fk_cip_phoneid FOREIGN KEY (phoneid) REFERENCES phones(phoneid);
ALTER TABLE coreidentityphones ADD CONSTRAINT fk_cip_contacttypeid FOREIGN KEY (contacttypeid) REFERENCES contacttypes(contacttypeid);
ALTER TABLE coreidentityphones ADD CONSTRAINT fk_cip_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE emails ADD CONSTRAINT fk_emails_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE coreidentityemails ADD CONSTRAINT fk_cie_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE coreidentityemails ADD CONSTRAINT fk_cie_emailid FOREIGN KEY (emailid) REFERENCES emails(emailid);
ALTER TABLE coreidentityemails ADD CONSTRAINT fk_cie_contacttypeid FOREIGN KEY (contacttypeid) REFERENCES contacttypes(contacttypeid);
ALTER TABLE coreidentityemails ADD CONSTRAINT fk_cie_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE postaladdresses ADD CONSTRAINT fk_pa_countryid FOREIGN KEY (countryid) REFERENCES countries(countryid);
ALTER TABLE postaladdresses ADD CONSTRAINT fk_pa_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE coreidentitypostaladdresses ADD CONSTRAINT fk_cipa_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE coreidentitypostaladdresses ADD CONSTRAINT fk_cipa_postaladdressid FOREIGN KEY (postaladdressid) REFERENCES postaladdresses(postaladdressid);
ALTER TABLE coreidentitypostaladdresses ADD CONSTRAINT fk_cipa_contacttypeid FOREIGN KEY (contacttypeid) REFERENCES contacttypes(contacttypeid);
ALTER TABLE coreidentitypostaladdresses ADD CONSTRAINT fk_cipa_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE socialmedia ADD CONSTRAINT fk_sm_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE coreidentitysocialmedia ADD CONSTRAINT fk_cism_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE coreidentitysocialmedia ADD CONSTRAINT fk_cism_socialmediaid FOREIGN KEY (socialmediaid) REFERENCES socialmedia(socialmediaid);
ALTER TABLE coreidentitysocialmedia ADD CONSTRAINT fk_cism_contacttypeid FOREIGN KEY (contacttypeid) REFERENCES contacttypes(contacttypeid);
ALTER TABLE coreidentitysocialmedia ADD CONSTRAINT fk_cism_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE contracts ADD CONSTRAINT fk_contracts_organizationid FOREIGN KEY (organizationid) REFERENCES organizations(organizationid);
ALTER TABLE contracts ADD CONSTRAINT fk_contracts_vendorid FOREIGN KEY (vendorid) REFERENCES vendors(vendorid);
ALTER TABLE contracts ADD CONSTRAINT fk_contracts_contracttypeid FOREIGN KEY (contracttypeid) REFERENCES contracttypes(contracttypeid);
ALTER TABLE contracts ADD CONSTRAINT fk_contracts_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE assignments ADD CONSTRAINT fk_assignments_workerid FOREIGN KEY (workerid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE assignments ADD CONSTRAINT fk_assignments_organizationid FOREIGN KEY (organizationid) REFERENCES organizations(organizationid);
ALTER TABLE assignments ADD CONSTRAINT fk_assignments_contractid FOREIGN KEY (contractid) REFERENCES contracts(contractid);
ALTER TABLE assignments ADD CONSTRAINT fk_assignments_assignmenttypeid FOREIGN KEY (assignmenttypeid) REFERENCES assignmenttypes(assignmenttypeid);
-- PointsOfContact FKs
ALTER TABLE pointsofcontact ADD CONSTRAINT fk_pointsofcontact_prefixid FOREIGN KEY (prefixid) REFERENCES prefixsuffix(prefixsuffixid);
ALTER TABLE pointsofcontact ADD CONSTRAINT fk_pointsofcontact_suffixid FOREIGN KEY (suffixid) REFERENCES prefixsuffix(prefixsuffixid);
ALTER TABLE pointsofcontact ADD CONSTRAINT fk_pointsofcontact_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);
ALTER TABLE pointsofcontact ADD CONSTRAINT fk_pointsofcontact_createdby FOREIGN KEY (createdby) REFERENCES coreidentity(coreidentityid);
ALTER TABLE pointsofcontact ADD CONSTRAINT fk_pointsofcontact_modifiedby FOREIGN KEY (modifiedby) REFERENCES coreidentity(coreidentityid);
ALTER TABLE pointsofcontact ADD CONSTRAINT fk_pointsofcontact_deletedby FOREIGN KEY (deletedby) REFERENCES coreidentity(coreidentityid);

-- Junction tables for PointsOfContact
ALTER TABLE pointsofcontactphones ADD CONSTRAINT fk_pointsofcontactphones_pointofcontactid FOREIGN KEY (pointofcontactid) REFERENCES pointsofcontact(pointofcontactid);
ALTER TABLE pointsofcontactphones ADD CONSTRAINT fk_pointsofcontactphones_phoneid FOREIGN KEY (phoneid) REFERENCES phones(phoneid);
ALTER TABLE pointsofcontactphones ADD CONSTRAINT fk_pointsofcontactphones_contacttypeid FOREIGN KEY (contacttypeid) REFERENCES contacttypes(contacttypeid);
ALTER TABLE pointsofcontactphones ADD CONSTRAINT fk_pointsofcontactphones_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE pointsofcontactemails ADD CONSTRAINT fk_pointsofcontactemails_pointofcontactid FOREIGN KEY (pointofcontactid) REFERENCES pointsofcontact(pointofcontactid);
ALTER TABLE pointsofcontactemails ADD CONSTRAINT fk_pointsofcontactemails_emailid FOREIGN KEY (emailid) REFERENCES emails(emailid);
ALTER TABLE pointsofcontactemails ADD CONSTRAINT fk_pointsofcontactemails_contacttypeid FOREIGN KEY (contacttypeid) REFERENCES contacttypes(contacttypeid);
ALTER TABLE pointsofcontactemails ADD CONSTRAINT fk_pointsofcontactemails_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE assignments ADD CONSTRAINT fk_assignments_assignmentstatusid FOREIGN KEY (assignmentstatusid) REFERENCES assignmentstatuses(assignmentstatusid);
ALTER TABLE assignments ADD CONSTRAINT fk_assignments_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE tableprefixes ADD CONSTRAINT fk_tableprefixes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE sexes ADD CONSTRAINT fk_sexes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE geography ADD CONSTRAINT fk_geography_geographytypeid FOREIGN KEY (geographytypeid) REFERENCES geographytypes(geographytypeid);
ALTER TABLE geography ADD CONSTRAINT fk_geography_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE geographytypes ADD CONSTRAINT fk_geographytypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE prefixsuffix ADD CONSTRAINT fk_prefixsuffix_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE coreidentity ADD CONSTRAINT fk_coreidentity_prefixid FOREIGN KEY (prefixid) REFERENCES prefixsuffix(prefixsuffixid);
ALTER TABLE coreidentity ADD CONSTRAINT fk_coreidentity_suffixid FOREIGN KEY (suffixid) REFERENCES prefixsuffix(prefixsuffixid);
ALTER TABLE coreidentity ADD CONSTRAINT fk_coreidentity_placeofbirthid FOREIGN KEY (placeofbirthid) REFERENCES geography(geographyid);
ALTER TABLE coreidentity ADD CONSTRAINT fk_coreidentity_sexid FOREIGN KEY (sexid) REFERENCES sexes(sexid);
ALTER TABLE coreidentity ADD CONSTRAINT fk_coreidentity_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE vendors ADD CONSTRAINT fk_vendors_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE contacttypes ADD CONSTRAINT fk_contacttypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE contracttypes ADD CONSTRAINT fk_contracttypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE countrycodes ADD CONSTRAINT fk_countrycodes_countryid FOREIGN KEY (countryid) REFERENCES countries(countryid);
ALTER TABLE countrycodes ADD CONSTRAINT fk_countrycodes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE countries ADD CONSTRAINT fk_countries_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE decisions ADD CONSTRAINT fk_decisions_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE adjudications ADD CONSTRAINT fk_adjudications_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE aliases ADD CONSTRAINT fk_aliases_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE aliases ADD CONSTRAINT fk_aliases_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE assignmenttypes ADD CONSTRAINT fk_assignmenttypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE assignmentstatuses ADD CONSTRAINT fk_assignmentstatuses_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE packages ADD CONSTRAINT fk_packages_specialistid FOREIGN KEY (specialistid) REFERENCES coreidentity(coreidentityid);
ALTER TABLE packages ADD CONSTRAINT fk_packages_packagetypeid FOREIGN KEY (packagetypeid) REFERENCES packagetypes(packagetypeid);
ALTER TABLE packages ADD CONSTRAINT fk_packages_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE packagetypes ADD CONSTRAINT fk_packagetypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE formtypes ADD CONSTRAINT fk_formtypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE packageformevents ADD CONSTRAINT fk_packageformevents_packageid FOREIGN KEY (packageid) REFERENCES packages(packageid);
ALTER TABLE packageformevents ADD CONSTRAINT fk_packageformevents_formtypeid FOREIGN KEY (formtypeid) REFERENCES formtypes(formtypeid);
ALTER TABLE packageformevents ADD CONSTRAINT fk_packageformevents_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

ALTER TABLE auditlogs ADD CONSTRAINT fk_auditlogs_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES recordstatuses(recordstatusid);

-- Disable all foreign key constraints
DO $$
DECLARE r RECORD;
BEGIN
    FOR r IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' LOOP
        EXECUTE format('ALTER TABLE %I DISABLE TRIGGER ALL;', r.tablename);
    END LOOP;
END $$;

-- Enable all foreign key constraints
DO $$
DECLARE r RECORD;
BEGIN
    FOR r IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' LOOP
        EXECUTE format('ALTER TABLE %I ENABLE TRIGGER ALL;', r.tablename);
    END LOOP;
END $$;
