-- ============================================================
--  CHANG DEVELOPMENT GROUP — Supabase schema
--  Run this in Supabase → SQL Editor → New query → Run
-- ============================================================

-- ---------- EMPLOYEES ----------
create table if not exists employees (
  id          bigint generated always as identity primary key,
  name        text    not null,
  dept        text    not null check (dept in ('rivus','handy','airbnb','hotel','admin')),
  pin         text    not null unique,
  rate        numeric not null default 0,
  active      boolean not null default true,
  created_at  timestamptz not null default now()
);

-- ---------- PROPERTIES (Airbnb flat-rate list) ----------
create table if not exists properties (
  id          bigint generated always as identity primary key,
  name        text    not null,
  addr        text,
  rate        numeric not null default 0,
  active      boolean not null default true,
  created_at  timestamptz not null default now()
);

-- ---------- SESSIONS (every clock-in / clean / shift) ----------
create table if not exists sessions (
  id          bigint generated always as identity primary key,
  emp_id      bigint references employees(id) on delete set null,
  dept        text,
  kind        text,                 -- 'stop' | 'clean' | 'shift'
  label       text,                 -- location / property / hotel
  sub         text,                 -- job type / address / shift detail
  client      text,
  start_ts    timestamptz,
  end_ts      timestamptz,
  dur_ms      bigint,
  pay         numeric,
  status      text default 'done',
  gps_lat     double precision,
  gps_lng     double precision,
  notes       text,
  created_at  timestamptz not null default now()
);

-- ---------- CONTACT MESSAGES (homepage contact form) ----------
create table if not exists contacts (
  id          bigint generated always as identity primary key,
  name        text,
  email       text,
  topic       text,
  message     text,
  status      text default 'new',
  created_at  timestamptz not null default now()
);

-- ---------- NOMINATIONS (Be the C.H.A.N.G.E. form) ----------
create table if not exists nominations (
  id            bigint generated always as identity primary key,
  who           text,               -- a family / senior / veteran / myself
  your_name     text,
  your_email    text,
  your_phone    text,
  nominee_name  text,
  city          text,
  need          text,               -- cleaning / repairs / lawn / not sure
  story         text,
  status        text default 'new',
  created_at    timestamptz not null default now()
);

-- ============================================================
--  SEED DATA — demo employees & properties (edit freely)
-- ============================================================
insert into employees (name, dept, pin, rate) values
  ('Maria Gomez','rivus','1111',22),
  ('James Rivera','handy','2222',25),
  ('Sofia Torres','airbnb','3333',0),
  ('Carlos Diaz','hotel','4444',18),
  ('Pablo Chang','admin','5555',0)
on conflict (pin) do nothing;

insert into properties (name, addr, rate) values
  ('Beachside Villa','14 Ocean Dr',120),
  ('Downtown Loft','88 Bay St #4',85),
  ('Riverside Retreat','22 River Rd',110),
  ('Ponte Vedra Estate','5 Palm Blvd',160),
  ('Atlantic Beach Cottage','9 Shore Ln',95),
  ('Southside Suite','301 Phillips Hwy',90);

-- ============================================================
--  ROW LEVEL SECURITY
--  MVP policies: allow the anon (public) key to read/write.
--  NOTE: this is fine to launch an internal tool, but PINs are
--  readable with the anon key. For production, move PIN checks
--  to an RPC/Edge Function and tighten these policies.
-- ============================================================
alter table employees   enable row level security;
alter table properties  enable row level security;
alter table sessions    enable row level security;
alter table nominations enable row level security;
alter table contacts    enable row level security;

-- employees: read + write (admin panel manages these)
create policy "anon read employees"  on employees  for select using (true);
create policy "anon write employees" on employees  for insert with check (true);
create policy "anon update employees" on employees for update using (true);
create policy "anon delete employees" on employees for delete using (true);

-- properties: read + write
create policy "anon read properties"  on properties for select using (true);
create policy "anon write properties" on properties for insert with check (true);
create policy "anon update properties" on properties for update using (true);
create policy "anon delete properties" on properties for delete using (true);

-- sessions: read + insert + update
create policy "anon read sessions"   on sessions for select using (true);
create policy "anon write sessions"  on sessions for insert with check (true);
create policy "anon update sessions" on sessions for update using (true);

-- nominations: insert only from public (don't let public read others' nominations)
create policy "anon insert nominations" on nominations for insert with check (true);
-- (You read nominations from the Supabase dashboard, or add an authed admin policy later.)

-- contacts: insert only from public (you read messages from the dashboard)
create policy "anon insert contacts" on contacts for insert with check (true);
