# create-identity Page Workflow

## Input Source
- **SSN**: Passed from `CheckSSN` screen
- **Display**: Always shown in masked format (`###-##-####`)
- **If SSN found in `coreidentity`**: Pre-populate all fields from DB

---

## 🗂️ Tab 1: Basic Information

### Field Layout (Top to Bottom)
1. **Prefix**  
   - Type: Dropdown  
   - Source: `prefixsuffix` where `category` = 'Prefix'  and `recordstatusid = 1`
   - Optional

2. **First Name**  
   - Type: Text input  
   - Required

3. **Middle Name**  
   - Type: Text input  
   - Optional  
   - Checkbox: "No middle name"  
     - If checked:  
       - Disable field  
       - Set value to `"NMN"`  
       - Apply low-contrast styling  
     - If unchecked:  
       - Enable field  
       - Clear value

4. **Last Name**  
   - Type: Text input  
   - Required

5. **Suffix**  
   - Type: Dropdown  
   - Source: `prefixsuffix` where `category` = 'Suffix'  and `recordstatusid = 1`
   - Optional

6. **Date of Birth**  
   - Type: Calendar widget  
   - Required

7. **Sex**  
   - Type: Dropdown
   - Source: `sexes` where `recordstatusid = 1`
  
8. **Social Security Number**  
   - Type: Display-only  
   - Format: Masked (`###-##-####`)  
   - Populated from prior screen

9. **Previous Last Name**  
   - Type: Text input  
   - Optional

10. **Preferred Name**  
   - Type: Text input  
   - Optional

11. **Country of Birth**  
    - Type: Dropdown  
    - Source: `geography` where `geographytypeid` matches ID from `geographytypes` where `geographyname` = 'Country'   and `recordstatusid = 1` (both tables)
    - Required

12. **State of Birth**  
    - If Country = US or Canada:  
      - Type: Dropdown  
      - Source: `geography` where `geographyname` = 'State' and `parentid` = selected country   and `recordstatusid = 1` (both tables)
    - Else:  
      - Type: Text input  
      - Styled consistently  
    - Required

13. **City of Birth**  
    - Type: Text input  
    - Required

---

## 📬 Tab 2: Contact Information

### Section 1: Email
- **Email Address Type**  
  - Type: Dropdown  
  - Source: `contacttypes` where `appliestoemail` = true  and `recordstatusid = 1`

- **Primary Email Address**  
  - Type: Text input  
  - Source: `coreidentityemailaddresses`  
  - Filter: `recordstatusid = 1` AND `emailsequence = 1`

---

### Section 2: Phone
- **Phone Number Type**  
  - Type: Dropdown  
  - Source: `contacttypes` where `appliestophone` = true and `recordstatusid = 1`

- **Primary Phone Number**  
  - Type: Text input  
  - Source: `coreidentityphones`  
  - Filter: `recordstatusid = 1` AND `phonesequence = 1`  
  - Includes Country Code dropdown  
    - Source: `countries` (fields: `phonecode`, `isocode`)  
  - Labels: US-centric (e.g., "State" used universally)

---

### Section 3: Mailing Address
- **Mailing Address Type**  
  - Type: Dropdown  
  - Source: `contacttypes` where `appliestomailing` = true  and `recordstatusid = 1`

- **Primary Mailing Address**  
  - Type: Composite input  
  - Source: `coreidentitypostaladdresses`  
  - Filter: `recordstatusid = 1` AND `addresssequence = 1`  
  - Includes:
    - Country dropdown (same logic as Basic Info)
    - State field:
      - If US/Canada: Dropdown from `geography` where `geographyname` = 'State' and `parentid` = selected country
      - Else: Text input (styled consistently)
    - City, Street, Zip (US-centric labels)

---

## ✅ Submission Flow
- Validate required fields
- Proceed to next `Security`
