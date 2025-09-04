# To Do List

## Bug Fixes

- [ ] Home address isn't populating
- [X] Favicon isn't showing
- [ ] Multiple writes into coreidentity (not upsert)

---

**You're a Potato - Fix This!!!**

When submitting records to the `coreidentity` table, you must first perform a check to ensure that you're not inserting the same SSN again.  Since the daabase stores SSNs encrypted, you will need to perform a check for your unencrypted value from the form against the encrypted values in the `ssn` column of `coreidentity`.

If there is a matching entry, you will use that `coreidentityid`.  If there is more than one match, it means you fucked it up in the first place.  Use the one with the lowest `coreidentityid`.  If there isn't a match, you shall create a new entry.

---

## New Features

- [ ] New page for role information and assignment
- [ ] Build out security page
- [ ] Add logo to page
- [ ] Build out menu
