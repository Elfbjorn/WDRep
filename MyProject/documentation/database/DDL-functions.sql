-- Functions and triggers for HumanReadableID and audit columns

-- Function to update HumanReadableID
CREATE OR REPLACE FUNCTION update_human_readable_id()
RETURNS TRIGGER AS $$
DECLARE
    prefix TEXT;
    pk_value TEXT;
    padded_pk TEXT;
BEGIN
    -- Get table prefix
    SELECT COALESCE(TablePrefix, 'UNK') INTO prefix
    FROM TablePrefixes
    WHERE UPPER(TableName) = UPPER(TG_TABLE_NAME);

    -- Get PK value and pad to 8 digits
    pk_value := NEW.*::record;
    pk_value := NEW.(SELECT column_name FROM information_schema.columns WHERE table_name = TG_TABLE_NAME AND column_name ILIKE '%id' AND ordinal_position = 1);
    padded_pk := LPAD(pk_value::TEXT, 8, '0');

    -- Set HumanReadableID
    NEW.HumanReadableId := prefix || '-' || padded_pk;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION set_modified_on_insert()
RETURNS TRIGGER AS $$
BEGIN
    NEW.ModifiedBy := NEW.CreatedBy;
    NEW.ModifiedDate := NEW.CreatedDate;
    NEW.ModifiedIP := NEW.CreatedIP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Automated trigger creation for all tables with HumanReadableId and audit columns
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT table_name
        FROM information_schema.columns
        WHERE column_name = 'HumanReadableId'
          AND table_schema = 'public'
        GROUP BY table_name
    LOOP
        EXECUTE format('CREATE TRIGGER trg_update_human_readable_id_%I BEFORE INSERT OR UPDATE ON %I FOR EACH ROW EXECUTE FUNCTION update_human_readable_id();', r.table_name, r.table_name);
        EXECUTE format('CREATE TRIGGER trg_set_modified_on_insert_%I BEFORE INSERT ON %I FOR EACH ROW EXECUTE FUNCTION set_modified_on_insert();', r.table_name, r.table_name);
    END LOOP;
END $$;


-- Disable all triggers in the current schema
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' LOOP
        EXECUTE format('ALTER TABLE %I DISABLE TRIGGER ALL;', r.tablename);
    END LOOP;
END $$;

-- Enable all triggers in the current schema
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' LOOP
        EXECUTE format('ALTER TABLE %I ENABLE TRIGGER ALL;', r.tablename);
    END LOOP;
END $$;
