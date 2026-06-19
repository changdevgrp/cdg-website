/* ============================================================
   CDG — ONE config file for the whole site.
   Edit this file ONLY. Every page reads its keys from here.
   ------------------------------------------------------------
   All values below are SAFE to live in a public website
   (they are public/publishable keys by design). NEVER put a
   Supabase service_role key or a Stripe SECRET key here.
   ============================================================ */
window.CDG_CONFIG = {

  // --- Supabase (Project Settings -> API) ---
  SUPABASE_URL:      "https://regwuwjcnbkjofvncodz.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJlZ3d1d2pjbmJram9mdm5jb2R6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE4MTUzMTksImV4cCI6MjA5NzM5MTMxOX0.QGSkfKSJsiPmfw_fRJn1BizIL7yhzyzwzPfF6UTeXIM",

  // --- Web3Forms (web3forms.com) — contact form emails ---
  WEB3FORMS_KEY:     "1f26f115-2dca-4b8b-98b2-543d1a03ef70",

  // --- Stripe Payment Links (Dashboard -> Payment Links) ---
  STRIPE_LINKS: {
    Supporter: "https://buy.stripe.com/00w9ASeki0fpeqv1oh5Vu0w",   // $25/mo
    Advocate:  "https://buy.stripe.com/5kQ6oG0ts1jt5TZff75Vu0x",   // $50/mo
    Champion:  "https://buy.stripe.com/bJeeVcb86genaaf6IB5Vu0y",   // $100/mo
    Guardian:  "https://buy.stripe.com/dRm28q3FE7HRaafc2V5Vu0z"    // $250/mo
  }

};
