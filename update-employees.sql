-- ============================================================
--  CDG — Update employees (real roster)
--  Run in Supabase -> SQL Editor -> New query -> Run
--  Rates are 0 (set hourly rates later or send me a list).
-- ============================================================

delete from employees;
alter sequence employees_id_seq restart with 1;

insert into employees (name, dept, pin, rate, active) values
  ('Pablo Chang', 'admin', '1000', 0, true),
  ('Ryan White', 'handy', '2000', 0, true),
  ('Michel Mesidor', 'hotel', '3001', 0, true),
  ('Victor Angulo', 'hotel', '3002', 0, true),
  ('Zulaima Leon', 'hotel', '3003', 0, true),
  ('Evenyira Delgado', 'airbnb', '4001', 0, true),
  ('Charles McCrary', 'airbnb', '4002', 0, true),
  ('Emma Neiford', 'airbnb', '4003', 0, true),
  ('Alex Ramos', 'airbnb', '4004', 0, true),
  ('Damaris Rodriguez', 'airbnb', '4005', 0, true),
  ('Fabiola Roman', 'airbnb', '4006', 0, true),
  ('Frens Consulting LLC', 'airbnb', '4007', 0, true),
  ('Royal Cleaning Cr LLC', 'airbnb', '4008', 0, true);