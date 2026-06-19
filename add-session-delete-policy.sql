-- ============================================================
--  CDG — Allow deleting a logged session (for fixing mispunches)
--  Run in Supabase -> SQL Editor -> New query -> Run
-- ============================================================

create policy "anon delete sessions" on sessions for delete using (true);
