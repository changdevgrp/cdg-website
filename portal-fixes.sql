-- ============================================================
--  CDG PORTAL — FIXES MIGRATION
--  Run this in Supabase → SQL Editor → New query → Run.
--  Safe to run more than once (uses IF NOT EXISTS).
-- ============================================================

-- ------------------------------------------------------------
-- 1) FIX NOTES NOT SAVING
--    The app writes two columns that were missing from the
--    sessions table: pay_amt and client_price. When Supabase
--    receives an unknown column it rejects the WHOLE row, so
--    notes (and the rest of the session) never saved.
--    Adding the columns lets every save succeed.
-- ------------------------------------------------------------
alter table sessions add column if not exists pay_amt      numeric;
alter table sessions add column if not exists client_price numeric;
alter table sessions add column if not exists notes        text;   -- ensure present

-- ------------------------------------------------------------
-- 2) ROOM / TASK LOGS  (housekeeping sub-tasks)
--    A separate log so employees can record each room/area they
--    worked — room #, start, notes, end — WITHOUT touching their
--    main clock-in timer. One shift (session) can have many of
--    these. emp_id + day lets admins review per person per day.
-- ------------------------------------------------------------
create table if not exists room_logs (
  id          bigint generated always as identity primary key,
  emp_id      bigint references employees(id) on delete cascade,
  session_id  bigint references sessions(id)  on delete set null,  -- the shift it happened during (optional)
  dept        text,
  room        text,                 -- room number / area / unit
  notes       text,
  start_ts    timestamptz,
  end_ts      timestamptz,
  dur_ms      bigint,
  status      text default 'open',  -- 'open' while running, 'done' when ended
  created_at  timestamptz not null default now()
);

create index if not exists room_logs_emp_idx   on room_logs (emp_id);
create index if not exists room_logs_start_idx on room_logs (start_ts);

-- ------------------------------------------------------------
-- 3) ROW LEVEL SECURITY for room_logs
--    Matches how the rest of the portal is configured: the app
--    uses the anon key, so allow the anon role to read/write.
--    (Same posture as the existing sessions table.)
-- ------------------------------------------------------------
alter table room_logs enable row level security;

drop policy if exists room_logs_all on room_logs;
create policy room_logs_all on room_logs
  for all
  to anon, authenticated
  using (true)
  with check (true);

-- ------------------------------------------------------------
-- 4) REALTIME (optional, mirrors sessions)
--    Lets admin screens update live. Ignore any "already added"
--    notice if you run this twice.
-- ------------------------------------------------------------
do $$
begin
  begin
    alter publication supabase_realtime add table room_logs;
  exception when duplicate_object then
    null;
  end;
end $$;

-- ============================================================
--  DONE. After running:
--   • Notes will save on every session.
--   • Room logs are ready for the housekeeping sub-task logger.
-- ============================================================
