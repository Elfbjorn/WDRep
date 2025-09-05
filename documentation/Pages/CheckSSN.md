# check-ssn Page Workflow

## Step-by-Step Logic

1. **User Input**
   - Field: "Enter SSN" (Text box)

2. **SSN Normalization**
   - Standardize format
   - Validate against regex (e.g., `^\d{3}-?\d{2}-?\d{4}$`)

3. **Validation Outcome**
   - If invalid:
     - Display error message
     - Reset screen
   - If valid:
     - Proceed to DB lookup

4. **Database Lookup**
   - Table: `coreidentity`
   - Field: `ssn`
   - If match found:
     - Return: `firstname`, `middlename`, `lastname`, `ssn`, `dob`
     - Display on screen
   - If no match:
     - Display: "No match found"

5. **User Prompt**
   - "Would you like to proceed?"
   - If No:
     - Reset screen
   - If Yes:
     - Navigate to `create-identity` page
     - Pass SSN (masked format)

6. **SSN Display**
   - Always shown as `###-##-####`
   - On blur: re-renders in masked format
