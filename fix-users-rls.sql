-- رفع قطع ارتباط کاربران بعد از RLS
-- این Policyها برای کارکرد سایت با anon key لازم‌اند

ALTER TABLE IF EXISTS public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.inbox ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.saved ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.reports ENABLE ROW LEVEL SECURITY;

-- USERS: خواندن و ثبت‌نام
DROP POLICY IF EXISTS users_select ON public.users;
DROP POLICY IF EXISTS users_insert ON public.users;
DROP POLICY IF EXISTS users_update ON public.users;
DROP POLICY IF EXISTS users_delete ON public.users;
DROP POLICY IF EXISTS users_all ON public.users;
CREATE POLICY users_select ON public.users FOR SELECT USING (true);
CREATE POLICY users_insert ON public.users FOR INSERT WITH CHECK (true);
CREATE POLICY users_update ON public.users FOR UPDATE USING (true) WITH CHECK (true);
-- حذف کاربر فقط از فرماندهی؛ فعلاً برای سازگاری باز (بعداً محدود می‌شود)
CREATE POLICY users_delete ON public.users FOR DELETE USING (true);

-- MESSAGES
DROP POLICY IF EXISTS messages_select ON public.messages;
DROP POLICY IF EXISTS messages_insert ON public.messages;
DROP POLICY IF EXISTS messages_update ON public.messages;
DROP POLICY IF EXISTS messages_delete ON public.messages;
CREATE POLICY messages_select ON public.messages FOR SELECT USING (true);
CREATE POLICY messages_insert ON public.messages FOR INSERT WITH CHECK (true);
CREATE POLICY messages_update ON public.messages FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY messages_delete ON public.messages FOR DELETE USING (true);

-- INBOX
DROP POLICY IF EXISTS inbox_select ON public.inbox;
DROP POLICY IF EXISTS inbox_insert ON public.inbox;
DROP POLICY IF EXISTS inbox_update ON public.inbox;
DROP POLICY IF EXISTS inbox_delete ON public.inbox;
CREATE POLICY inbox_select ON public.inbox FOR SELECT USING (true);
CREATE POLICY inbox_insert ON public.inbox FOR INSERT WITH CHECK (true);
CREATE POLICY inbox_update ON public.inbox FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY inbox_delete ON public.inbox FOR DELETE USING (true);

-- SAVED
DROP POLICY IF EXISTS saved_select ON public.saved;
DROP POLICY IF EXISTS saved_insert ON public.saved;
DROP POLICY IF EXISTS saved_delete ON public.saved;
CREATE POLICY saved_select ON public.saved FOR SELECT USING (true);
CREATE POLICY saved_insert ON public.saved FOR INSERT WITH CHECK (true);
CREATE POLICY saved_delete ON public.saved FOR DELETE USING (true);

-- REPORTS
DROP POLICY IF EXISTS reports_select ON public.reports;
DROP POLICY IF EXISTS reports_insert ON public.reports;
CREATE POLICY reports_select ON public.reports FOR SELECT USING (true);
CREATE POLICY reports_insert ON public.reports FOR INSERT WITH CHECK (true);
