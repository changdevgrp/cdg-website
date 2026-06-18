# CDG Website — Setup & Integration Guide

Your site is **8 files**. All run fine as-is in demo mode; the backends turn on when you paste your keys/URLs.

| File | What it is |
|---|---|
| `index.html` | Homepage |
| `services.html` | Services (all brands + Handy-Force tabs) |
| `founders.html` | Meet the Founders |
| `culture.html` | Be the C.H.A.N.G.E. culture |
| `initiative.html` | Community initiative + patron tiers + nomination form |
| `portal.html` | Employee login + time tracker |
| `supabase-schema.sql` | Database setup (run once in Supabase) |
| `SETUP-GUIDE.md` | This file |

Upload the 6 `.html` files to Hostinger `public_html/`. Keep filenames exactly as-is so the links work.

---

## 1) Supabase — employee data + nominations

**A. Create the tables (once)**
1. Go to supabase.com → your project → **SQL Editor** → **New query**.
2. Open `supabase-schema.sql`, copy everything, paste, click **Run**.
3. You'll get the `employees`, `properties`, `sessions`, and `nominations` tables, seeded with your demo crew + properties.

**B. Get your two public values**
1. Supabase → **Project Settings** → **API**.
2. Copy the **Project URL** and the **anon / public** key. (The anon key is safe in client-side code — it's designed for the browser.)

**C. Paste them into the files**
- In `portal.html`, near the top of the `<script>`:
  ```js
  const SUPABASE_URL      = 'https://YOURPROJECT.supabase.co';
  const SUPABASE_ANON_KEY = 'your-anon-public-key';
  ```
- In `initiative.html`, same two lines (so the nomination form saves).

Re-upload both files. Done — the portal now reads/writes real data, and nominations land in your `nominations` table.

**Reading nominations:** Supabase → **Table Editor** → `nominations`.

**Security note (important):** The starter policies let the public anon key read the `employees` table, which means PINs are technically readable by someone digging in the browser. That's acceptable for an internal MVP. Before you're fully public/serious, tell me and we'll move PIN checks into a Supabase **Edge Function / RPC** so PINs are never exposed. (Nominations are insert-only — the public can't read other people's submissions.)

---

## 2) Stripe — patron payments (no code, no secret keys)

The cleanest path for a static site is **Payment Links**:
1. Stripe Dashboard → **Products** → **Payment Links** → **New**.
2. Create 4 recurring (monthly) links: **$25 Supporter**, **$50 Advocate**, **$100 Champion**, **$250 Guardian**.
3. Copy each link URL.
4. In `initiative.html`, fill the `STRIPE_LINKS` block:
   ```js
   const STRIPE_LINKS = {
     Supporter: 'https://buy.stripe.com/xxxx',
     Advocate:  'https://buy.stripe.com/xxxx',
     Champion:  'https://buy.stripe.com/xxxx',
     Guardian:  'https://buy.stripe.com/xxxx'
   };
   ```
Re-upload. Clicking a tier now opens its Stripe checkout. (Until filled, buttons fall back to a pre-filled email — nothing breaks.)

No secret keys ever go in the website. Stripe handles the card page on their domain.

---

## 3) Mailchimp — "The C.H.A.N.G.E. Report" newsletter

Mailchimp gives you a hosted form that posts straight to your audience (no API key in the site):
1. Mailchimp → **Audience** → **Signup forms** → **Embedded form**.
2. Copy the form's **action URL** (looks like `https://YOURLIST.us21.list-manage.com/subscribe/post?u=...&id=...`).
3. Send it to me and I'll drop a styled "Join The C.H.A.N.G.E. Report" signup block into the homepage footer and/or the initiative page — matched to the site design.

(If you'd rather, Mailchimp's own embed code works too, but the styled version will look on-brand.)

---

## 4) GitHub — version control + optional auto-deploy

**Simple backup/versioning:**
1. Create a repo at github.com (e.g. `cdg-website`).
2. Upload the `.html` files (drag-and-drop in the GitHub web UI works).

**Optional — free hosting via GitHub Pages:** repo **Settings** → **Pages** → deploy from `main` branch. You'd get a `github.io` URL; you can later point `changdevgrp.com` at it instead of Hostinger if you prefer. Hostinger is totally fine to keep — GitHub is mainly your safety net + history.

---

## Quick status

- [x] Public site (6 pages) — done, mobile-ready
- [x] Employee portal — Supabase-ready (paste keys to go live)
- [x] Nomination form — Supabase-ready
- [x] Patron tiers — Stripe Payment Link-ready
- [ ] Mailchimp signup block — send me your form action URL
- [ ] founders.html — send me your real bio + headshot + any team members
- [ ] (Later) move PIN auth to an Edge Function for full security

Questions or want me to wire the Mailchimp block? Just send the action URL.
