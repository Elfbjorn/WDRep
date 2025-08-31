# CheckSSN

**Page URL**
checkSSN

**Page Elements**
- Title: `[Eagle] Check Social Security Number`
- Page Header: `Check Social Security Number`
- Input Fields: Social Security Number Field
  - Must allow for SSNs to be entered however the user sees fit (i.e., XXX-XX-XXXX, XXX.XX.XXXX, XXX XX XXXX, XXXXXXXXX, etc.)
  - Must automatically correct for mask into XXX-XX-XXXX format
  - No portion of the SSN should be blanked out -- that is, display all digits
- Button: `Check`
  - Performs a database lookup against the `CoreIdentity` table
  - If there is a match, displays information on the screen using the format shown in the table at the bottom of this file
  - If there is no match, displays a message that the user is not found
  - Regardless of outcome, asks user if they want to continue (buttons `Yes` and `No`)
    - If no, clears the screen and resets localStorage, cookies, etc., related to this search
    - If yes, takes the user to the next screen called [`CreateIdentity`](CreateIdentity.md)
- Button: `Cancel`
  - Clears the screen and resets localStorage, cookies, etc., related to this search

## Confirmation Format

In the event that a match was identified in the database, a table will be displayed with the following information:

| Name | SSN | DOB | 
| ---- | --- | --- |
| `[Last Name], [First Name] [Middle Name]` | `Full social security number in masked format` | `Date of birth in YYYY-MM-DD format` |

Note that if the middle name within the database is stored as 'NMN', then it should omit the middle name in the output.