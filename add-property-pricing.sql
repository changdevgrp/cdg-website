-- ============================================================
--  CDG — Two-tier property pricing
--  client_price = what the client pays CDG
--  pay_rate     = what the cleaner earns for that turnover
--  Run in Supabase -> SQL Editor -> New query -> Run
-- ============================================================

alter table properties add column if not exists client_price numeric not null default 0;
alter table properties add column if not exists pay_rate     numeric not null default 0;

-- Migrate any old single 'rate' value into pay_rate so nothing is lost.
update properties set pay_rate = rate where pay_rate = 0 and rate <> 0;

-- Sessions: record both numbers at completion time so reports stay accurate
-- even if a property's price changes later.
alter table sessions add column if not exists client_price numeric;
alter table sessions add column if not exists pay_amt      numeric;
