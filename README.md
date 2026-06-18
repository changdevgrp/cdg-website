# Chang Development Group — Website

The official multi-page website and internal employee portal for **Chang Development Group (CDG)** — a family of service companies building businesses and empowering communities across Florida.

**Live:** [changdevgrp.com](https://changdevgrp.com)
**Motto:** *Be the C.H.A.N.G.E. — Building Businesses. Empowering Communities.*

---

## Pages

| File | Purpose |
|------|---------|
| `index.html` | Homepage — brand, portfolio, mission |
| `services.html` | All service brands + Handy-Force tabs (Repair / Builds / Lawn) |
| `founders.html` | Meet the Founders |
| `culture.html` | Be the C.H.A.N.G.E. culture code / Agents of C.H.A.N.G.E. |
| `initiative.html` | Community initiative — patron tiers, nomination form, newsletter |
| `portal.html` | Employee hub — PIN login + time tracker + payroll (Supabase) |
| `supabase-schema.sql` | Database schema — run once in Supabase |
| `SETUP-GUIDE.md` | Step-by-step integration guide |

## Brands

Luxe Harbor Collective · Cleaning Rangers · Handy-Force · Rivus Force · KVMN Media

## Tech

- Static HTML/CSS/JS (no build step) — deploys anywhere
- **Supabase** — employee data, sessions, payroll, nominations
- **Stripe** — patron payments (Payment Links)
- **Mailchimp** — The C.H.A.N.G.E. Report newsletter

## Setup

See [`SETUP-GUIDE.md`](SETUP-GUIDE.md) for connecting Supabase, Stripe, Mailchimp, and deployment. Keys/URLs go in the clearly-marked config blocks at the top of each file's `<script>` — no secret keys are ever committed.

## Deploy

Currently hosted on Hostinger (`public_html/`). The included `CNAME` file also enables **GitHub Pages** on `changdevgrp.com` if you switch — Settings → Pages → deploy from `main`.

---

© Chang Development Group LLC · Florida, USA
