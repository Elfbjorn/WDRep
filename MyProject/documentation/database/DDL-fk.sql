-- Foreign Key Constraints
-- Ambiguities: OrganizationTypeId (no OrganizationTypes table), PointOfContactId (no PointsOfContact table)

ALTER TABLE OrganizationsHistory ADD CONSTRAINT fk_OrganizationsHistory_OrganizationId FOREIGN KEY (OrganizationId) REFERENCES Organizations(OrganizationId);
ALTER TABLE OrganizationsHistory ADD CONSTRAINT fk_OrganizationsHistory_OrganizationTypeId FOREIGN KEY (OrganizationTypeId) REFERENCES OrganizationTypes(OrganizationTypeId);
ALTER TABLE OrganizationsHistory ADD CONSTRAINT fk_OrganizationsHistory_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);
ALTER TABLE OrganizationsHistory ADD CONSTRAINT fk_OrganizationsHistory_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE OrganizationsHistory ADD CONSTRAINT fk_OrganizationsHistory_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE OrganizationsHistory ADD CONSTRAINT fk_OrganizationsHistory_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES CoreIdentity(CoreIdentityId);

ALTER TABLE CoreIdentityInvestigationRequests ADD CONSTRAINT fk_CIIR_InvestigationRequestId FOREIGN KEY (InvestigationRequestId) REFERENCES InvestigationRequest(InvestigationRequestId);
ALTER TABLE CoreIdentityInvestigationRequests ADD CONSTRAINT fk_CIIR_CoreIdentityId FOREIGN KEY (CoreIdentityId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE CoreIdentityInvestigationRequests ADD CONSTRAINT fk_CIIR_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE CoreIdentityAdjudications ADD CONSTRAINT fk_CIA_AdjudicationId FOREIGN KEY (AdjudicationId) REFERENCES Adjudications(AdjudicationID);
ALTER TABLE CoreIdentityAdjudications ADD CONSTRAINT fk_CIA_CoreIdentityId FOREIGN KEY (CoreIdentityId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE CoreIdentityAdjudications ADD CONSTRAINT fk_CIA_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE EmergencyContacts ADD CONSTRAINT fk_EC_CoreIdentityId FOREIGN KEY (CoreIdentityId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE EmergencyContacts ADD CONSTRAINT fk_EC_RelationshipTypeId FOREIGN KEY (RelationshipTypeId) REFERENCES RelationshipTypes(RelationshipTypeId);
ALTER TABLE EmergencyContacts ADD CONSTRAINT fk_EC_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Phones ADD CONSTRAINT fk_Phones_CountryCodeId FOREIGN KEY (CountryCodeId) REFERENCES CountryCodes(CountryCodeId);
ALTER TABLE Phones ADD CONSTRAINT fk_Phones_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE CoreIdentityPhones ADD CONSTRAINT fk_CIP_CoreIdentityId FOREIGN KEY (CoreIdentityId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE CoreIdentityPhones ADD CONSTRAINT fk_CIP_PhoneId FOREIGN KEY (PhoneId) REFERENCES Phones(PhoneId);
ALTER TABLE CoreIdentityPhones ADD CONSTRAINT fk_CIP_ContactTypeId FOREIGN KEY (ContactTypeId) REFERENCES ContactTypes(ContactTypeId);
ALTER TABLE CoreIdentityPhones ADD CONSTRAINT fk_CIP_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Emails ADD CONSTRAINT fk_Emails_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE CoreIdentityEmails ADD CONSTRAINT fk_CIE_CoreIdentityId FOREIGN KEY (CoreIdentityId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE CoreIdentityEmails ADD CONSTRAINT fk_CIE_EmailId FOREIGN KEY (EmailId) REFERENCES Emails(EmailId);
ALTER TABLE CoreIdentityEmails ADD CONSTRAINT fk_CIE_ContactTypeId FOREIGN KEY (ContactTypeId) REFERENCES ContactTypes(ContactTypeId);
ALTER TABLE CoreIdentityEmails ADD CONSTRAINT fk_CIE_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE PostalAddresses ADD CONSTRAINT fk_PA_CountryId FOREIGN KEY (CountryId) REFERENCES Countries(CountryId);
ALTER TABLE PostalAddresses ADD CONSTRAINT fk_PA_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE CoreIdentityPostalAddresses ADD CONSTRAINT fk_CIPA_CoreIdentityId FOREIGN KEY (CoreIdentityId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE CoreIdentityPostalAddresses ADD CONSTRAINT fk_CIPA_PostalAddressId FOREIGN KEY (PostalAddressId) REFERENCES PostalAddresses(PostalAddressId);
ALTER TABLE CoreIdentityPostalAddresses ADD CONSTRAINT fk_CIPA_ContactTypeId FOREIGN KEY (ContactTypeId) REFERENCES ContactTypes(ContactTypeId);
ALTER TABLE CoreIdentityPostalAddresses ADD CONSTRAINT fk_CIPA_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE SocialMedia ADD CONSTRAINT fk_SM_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE CoreIdentitySocialMedia ADD CONSTRAINT fk_CISM_CoreIdentityId FOREIGN KEY (CoreIdentityId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE CoreIdentitySocialMedia ADD CONSTRAINT fk_CISM_SocialMediaId FOREIGN KEY (SocialMediaId) REFERENCES SocialMedia(SocialMediaId);
ALTER TABLE CoreIdentitySocialMedia ADD CONSTRAINT fk_CISM_ContactTypeId FOREIGN KEY (ContactTypeId) REFERENCES ContactTypes(ContactTypeId);
ALTER TABLE CoreIdentitySocialMedia ADD CONSTRAINT fk_CISM_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Contracts ADD CONSTRAINT fk_Contracts_OrganizationId FOREIGN KEY (OrganizationId) REFERENCES Organizations(OrganizationId);
ALTER TABLE Contracts ADD CONSTRAINT fk_Contracts_VendorId FOREIGN KEY (VendorId) REFERENCES Vendors(VendorId);
ALTER TABLE Contracts ADD CONSTRAINT fk_Contracts_ContractTypeId FOREIGN KEY (ContractTypeId) REFERENCES ContractTypes(ContractTypeId);
ALTER TABLE Contracts ADD CONSTRAINT fk_Contracts_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Assignments ADD CONSTRAINT fk_Assignments_WorkerId FOREIGN KEY (WorkerId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE Assignments ADD CONSTRAINT fk_Assignments_OrganizationId FOREIGN KEY (OrganizationId) REFERENCES Organizations(OrganizationId);
ALTER TABLE Assignments ADD CONSTRAINT fk_Assignments_ContractId FOREIGN KEY (ContractId) REFERENCES Contracts(ContractId);
ALTER TABLE Assignments ADD CONSTRAINT fk_Assignments_AssignmentTypeId FOREIGN KEY (AssignmentTypeId) REFERENCES AssignmentTypes(AssignmentTypeID);
-- PointsOfContact FKs
ALTER TABLE PointsOfContact ADD CONSTRAINT fk_PointsOfContact_PrefixId FOREIGN KEY (PrefixId) REFERENCES PrefixSuffix(PrefixSuffixId);
ALTER TABLE PointsOfContact ADD CONSTRAINT fk_PointsOfContact_SuffixId FOREIGN KEY (SuffixId) REFERENCES PrefixSuffix(PrefixSuffixId);
ALTER TABLE PointsOfContact ADD CONSTRAINT fk_PointsOfContact_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);
ALTER TABLE PointsOfContact ADD CONSTRAINT fk_PointsOfContact_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE PointsOfContact ADD CONSTRAINT fk_PointsOfContact_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE PointsOfContact ADD CONSTRAINT fk_PointsOfContact_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES CoreIdentity(CoreIdentityId);

-- Junction tables for PointsOfContact
ALTER TABLE PointsOfContactPhones ADD CONSTRAINT fk_PointsOfContactPhones_PointOfContactId FOREIGN KEY (PointOfContactId) REFERENCES PointsOfContact(PointOfContactId);
ALTER TABLE PointsOfContactPhones ADD CONSTRAINT fk_PointsOfContactPhones_PhoneId FOREIGN KEY (PhoneId) REFERENCES Phones(PhoneId);
ALTER TABLE PointsOfContactPhones ADD CONSTRAINT fk_PointsOfContactPhones_ContactTypeId FOREIGN KEY (ContactTypeId) REFERENCES ContactTypes(ContactTypeId);
ALTER TABLE PointsOfContactPhones ADD CONSTRAINT fk_PointsOfContactPhones_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE PointsOfContactEmails ADD CONSTRAINT fk_PointsOfContactEmails_PointOfContactId FOREIGN KEY (PointOfContactId) REFERENCES PointsOfContact(PointOfContactId);
ALTER TABLE PointsOfContactEmails ADD CONSTRAINT fk_PointsOfContactEmails_EmailId FOREIGN KEY (EmailId) REFERENCES Emails(EmailId);
ALTER TABLE PointsOfContactEmails ADD CONSTRAINT fk_PointsOfContactEmails_ContactTypeId FOREIGN KEY (ContactTypeId) REFERENCES ContactTypes(ContactTypeId);
ALTER TABLE PointsOfContactEmails ADD CONSTRAINT fk_PointsOfContactEmails_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Assignments ADD CONSTRAINT fk_Assignments_AssignmentStatusId FOREIGN KEY (AssignmentStatusId) REFERENCES AssignmentStatuses(AssignmentStatusID);
ALTER TABLE Assignments ADD CONSTRAINT fk_Assignments_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE TablePrefixes ADD CONSTRAINT fk_TablePrefixes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Sexes ADD CONSTRAINT fk_Sexes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE geography ADD CONSTRAINT fk_geography_GeographyTypeId FOREIGN KEY (GeographyTypeId) REFERENCES GeographyTypes(GeographyTypeId);
ALTER TABLE geography ADD CONSTRAINT fk_geography_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE GeographyTypes ADD CONSTRAINT fk_GeographyTypes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE PrefixSuffix ADD CONSTRAINT fk_PrefixSuffix_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE CoreIdentity ADD CONSTRAINT fk_CoreIdentity_PrefixId FOREIGN KEY (PrefixId) REFERENCES PrefixSuffix(PrefixSuffixId);
ALTER TABLE CoreIdentity ADD CONSTRAINT fk_CoreIdentity_SuffixId FOREIGN KEY (SuffixId) REFERENCES PrefixSuffix(PrefixSuffixId);
ALTER TABLE CoreIdentity ADD CONSTRAINT fk_CoreIdentity_PlaceOfBirthId FOREIGN KEY (PlaceOfBirthId) REFERENCES geography(GeographyId);
ALTER TABLE CoreIdentity ADD CONSTRAINT fk_CoreIdentity_SexId FOREIGN KEY (SexId) REFERENCES Sexes(SexId);
ALTER TABLE CoreIdentity ADD CONSTRAINT fk_CoreIdentity_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Vendors ADD CONSTRAINT fk_Vendors_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE ContactTypes ADD CONSTRAINT fk_ContactTypes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE ContractTypes ADD CONSTRAINT fk_ContractTypes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE CountryCodes ADD CONSTRAINT fk_CountryCodes_CountryId FOREIGN KEY (CountryId) REFERENCES Countries(CountryId);
ALTER TABLE CountryCodes ADD CONSTRAINT fk_CountryCodes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Countries ADD CONSTRAINT fk_Countries_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Decisions ADD CONSTRAINT fk_Decisions_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Adjudications ADD CONSTRAINT fk_Adjudications_RecordStatusID FOREIGN KEY (RecordStatusID) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Aliases ADD CONSTRAINT fk_Aliases_CoreIdentityID FOREIGN KEY (CoreIdentityID) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE Aliases ADD CONSTRAINT fk_Aliases_RecordStatusID FOREIGN KEY (RecordStatusID) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE AssignmentTypes ADD CONSTRAINT fk_AssignmentTypes_RecordStatusID FOREIGN KEY (RecordStatusID) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE AssignmentStatuses ADD CONSTRAINT fk_AssignmentStatuses_RecordStatusID FOREIGN KEY (RecordStatusID) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE Packages ADD CONSTRAINT fk_Packages_SpecialistId FOREIGN KEY (SpecialistId) REFERENCES CoreIdentity(CoreIdentityId);
ALTER TABLE Packages ADD CONSTRAINT fk_Packages_PackageTypeId FOREIGN KEY (PackageTypeId) REFERENCES PackageTypes(PackageTypesId);
ALTER TABLE Packages ADD CONSTRAINT fk_Packages_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE PackageTypes ADD CONSTRAINT fk_PackageTypes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE FormTypes ADD CONSTRAINT fk_FormTypes_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE PackageFormEvents ADD CONSTRAINT fk_PackageFormEvents_PackageId FOREIGN KEY (PackageId) REFERENCES Packages(PackagesId);
ALTER TABLE PackageFormEvents ADD CONSTRAINT fk_PackageFormEvents_FormTypeId FOREIGN KEY (FormTypeId) REFERENCES FormTypes(FormTypesId);
ALTER TABLE PackageFormEvents ADD CONSTRAINT fk_PackageFormEvents_RecordStatusId FOREIGN KEY (RecordStatusId) REFERENCES RecordStatuses(RecordStatusId);

ALTER TABLE AuditLogs ADD CONSTRAINT fk_AuditLogs_RecordStatusID FOREIGN KEY (RecordStatusID) REFERENCES RecordStatuses(RecordStatusId);

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
