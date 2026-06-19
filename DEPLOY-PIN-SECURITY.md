# 🔐 CDG — Deploy the Secure PIN Login (Edge Function)

This makes employee PINs **un-readable** from the website. Logins get checked on
Supabase's servers instead of in the browser. Takes about 10–15 minutes, one time.

You'll do 4 things:
1. Install the Supabase CLI
2. Log in & link your project
3. Deploy the `verify-pin` function
4. Run one SQL file to hide the PIN column

---

## Before you start
- You need your **Supabase project reference ID**. Find it in your Supabase
  dashboard URL: `supabase.com/dashboard/project/<THIS-PART>` — for you it's
  `regwuwjcnbkjofvncodz`.
- Have the `verify-pin` folder handy (the `index.ts` file I gave you).

---

## Step 1 — Install the Supabase CLI

**Mac** (with Homebrew):
```
brew install supabase/tap/supabase
```

**Windows** (with Scoop):
```
scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
scoop install supabase
```

**No Homebrew/Scoop?** Download the installer from:
https://github.com/supabase/cli/releases  (grab the file for your OS)

Verify it installed:
```
supabase --version
```

---

## Step 2 — Log in and link your project

```
supabase login
```
(That opens your browser to authorize — click approve.)

Then, from a folder where you want the project files, link to your project:
```
supabase link --project-ref regwuwjcnbkjofvncodz
```

---

## Step 3 — Put the function in place and deploy

Create the function folder structure and drop in the file:
```
supabase/functions/verify-pin/index.ts
```
(Use the `verify-pin/index.ts` I gave you — same name, same folder.)

If you don't already have a `supabase` folder, the link step in Step 2 creates one.
Just make sure the path ends up exactly: `supabase/functions/verify-pin/index.ts`

Deploy it:
```
supabase functions deploy verify-pin --no-verify-jwt
```
> `--no-verify-jwt` lets your login screen call it with the public anon key
> (the function does its own validation). This is correct for a public PIN pad.

The service-role key the function needs is provided automatically by Supabase
inside the function environment — you do **not** paste any secret anywhere.

---

## Step 4 — Test, THEN lock down

**Test login first (before locking anything):**
- Open your live portal and log in with a real PIN (e.g. Pablo `1000`).
- If it logs you in, the function works. ✅

**Now hide the PIN column** — in Supabase → SQL Editor → run **`lock-down-pins.sql`**.

**Re-test:** log in again. Still works? You're done — PINs are now server-side only. 🎉

---

## What changed in the app (already built into your new portal.html)
- The login pad now calls the `verify-pin` function instead of reading the table.
- The admin **Team** list shows `••••` instead of PINs (they're no longer readable).
- To change someone's PIN, open their profile and type a new one. **Leave the PIN
  box blank to keep their current PIN.** (You set/reset PINs; you don't read them.)
- The old demo master-PIN `0000` backdoor is **disabled on the live site** — admins
  log in with their real PIN (Pablo `1000`, Charles `4002`). It still works in the
  in-chat demo preview only.

## If a login ever fails after deploy
- Make sure you re-uploaded the new `portal.html`.
- In Supabase → Edge Functions → `verify-pin` → check the logs for errors.
- Confirm `config.js` has the correct SUPABASE_URL.
- You can always re-allow reads temporarily by re-running the original
  `supabase-schema.sql` policy block, then try again.

## Rollback (if needed)
Re-grant full read access to get back to the pre-lockdown state:
```
grant select on employees to anon;
```
Then logins fall back to working even without the function.
