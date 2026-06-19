-- ============================================================
--  CDG — Lock down employee PINs (run AFTER deploying verify-pin)
--  Run in Supabase -> SQL Editor -> New query -> Run
--
--  WHAT THIS DOES:
--  The browser can still read employee info (names, depts, etc.)
--  for the admin panel, but it can NO LONGER read the `pin` column.
--  PIN checks happen only inside the verify-pin Edge Function,
--  which uses the service-role key on the server.
-- ============================================================

-- Remove blanket column access, then grant every column EXCEPT pin.
revoke select on employees from anon;
grant select (id, name, dept, rate, active, created_at,
              pay_type, phone, email, address, hire_date, emergency, notes)
  on employees to anon;

-- (The existing row-level "anon read employees" policy stays in place;
--  this just removes the pin column from what anon may read.)

-- Quick check — this should ERROR with "permission denied for column pin":
--   select pin from employees limit 1;
-- And this should still work:
--   select id, name, dept from employees limit 1;
