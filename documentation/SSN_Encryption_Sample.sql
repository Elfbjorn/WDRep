-- To store (insert/update) an SSN encrypted:
UPDATE coreidentity
SET ssn = pgp_sym_encrypt('123-45-6789'::text, current_setting('EAGLE_SEK')::text)
WHERE coreidentityid = 1;

-- To select/decrypt the SSN:
SELECT pgp_sym_decrypt(ssn::bytea, current_setting('EAGLE_SEK')::text) AS ssn
FROM coreidentity
WHERE coreidentityid = 1;
