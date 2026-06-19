-- ============================================================
--  CDG — Add employee profile fields
--  Run in Supabase -> SQL Editor -> New query -> Run
--  Safe to run once; "if not exists" guards against errors.
-- ============================================================

alter table employees add column if not exists pay_type    text default 'hourly';  -- 'hourly' | 'flat' | 'salary'
alter table employees add column if not exists phone       text;
alter table employees add column if not exists email       text;
alter table employees add column if not exists address     text;
alter table employees add column if not exists hire_date   date;
alter table employees add column if not exists emergency   text;   -- emergency contact name + phone
alter table employees add column if not exists notes       text;

-- (rate already exists; it now means the hourly OR flat amount depending on pay_type)
