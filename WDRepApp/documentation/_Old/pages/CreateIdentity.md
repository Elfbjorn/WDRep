# CreateIdentity

**Page URL**
checkSSN

**Page Elements**
- Title: `[Eagle] Create Identity`
- Page Header: `Create Identity`
- Input Fields:
  - Prefix - drop-down populated by lookup values from the FK relationship to the PrefixSuffix table where the type is Prefix
  - First Name - Required Field
  - Middle Name - Optional
    - To the side of that will be a checkbox that says "No Middle Name"
    - If checked, the "Middle Name" field disappears from the screen, and the value will be 'NMN'
    - If unchecked, the field reappears and the value is blanked out
  - Last Name - required
  - Suffix - drop-down populated by lookup values from the FK relationship to the PrefixSuffix table where the type is Suffix  
  - Previous last name - optional field
  - Preferred name - optional field
  - Date of birth - required, and in the past
  - Social Security Number - Required and pre-populated from prior screen
  - Sex - constrained to values of "Female", "Male", and "Unspecified"
  - Place of Birth
    - Country, State, and City
    - If the country is not the United States, then "State" gets replaced with "Region" (for displays purposes only), and "Region" and "City" both become optional fields
    - If the country is the United States, then the "State" and "City" are both required
      - State is a cascading drop-down value from the geography table (I forget what this is called)
    - On submit, the geography table will end up with a country, region/state, and city hierarchy added to the geography table
  - Primary email address
  - Primary phone number
  - Primary postal address
    - For all contact information (email, phone, postal), it must look and feel like the person will always be entering US information (i.e., "ZIP Code" not "Postal Code"; "State" not "State or Province", etc.)
    - Values must still support internationalization
    - For phone numbers, reference the appropriate portion of the schema that has country codes with country names and whatnot
    - If the schema needs to be modified to support country phone codes, do so -- right now, I believe it just supports ISO codes for country abbreviations
    - All contact information must identify if it's home, work, cell, etc., which should be a lookup to the contacttype table
    
