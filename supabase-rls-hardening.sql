-- پدافند شبهات — RLS سخت‌تر (با احتیاط اجرا شود)
-- هدف: جلوگیری از حذف/تغییر آزاد جداول حساس با anon key

ALTER TABLE IF EXISTS public.settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.commander_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.backups ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.inbox ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.saved ENABLE ROW LEVEL SECURITY;

-- settings: فقط خواندن عمومی نده؛ برای سازگاری موقت select بسته
DROP POLICY IF EXISTS settings_all ON public.settings;
DROP POLICY IF EXISTS settings_select ON public.settings;
CREATE POLICY settings_deny_all ON public.settings FOR ALL USING (false) WITH CHECK (false);

-- commander_log: insert از کلاینت محدود
DROP POLICY IF EXISTS commander_log_all ON public.commander_log;
CREATE POLICY commander_log_insert ON public.commander_log FOR INSERT WITH CHECK (true);
CREATE POLICY commander_log_select ON public.commander_log FOR SELECT USING (true);
-- جلوگیری از delete عمومی
DROP POLICY IF EXISTS commander_log_delete ON public.commander_log;
CREATE POLICY commander_log_no_delete ON public.commander_log FOR DELETE USING (false);

-- backups: بدون دسترسی عمومی
DROP POLICY IF EXISTS backups_all ON public.backups;
CREATE POLICY backups_deny ON public.backups FOR ALL USING (false) WITH CHECK (false);

-- posts: خواندن عمومی، درج عمومی (سایت)، حذف فقط false تا از worker/service role استفاده شود
DROP POLICY IF EXISTS posts_select_all ON public.posts;
CREATE POLICY posts_select_all ON public.posts FOR SELECT USING (true);
DROP POLICY IF EXISTS posts_insert_auth ON public.posts;
CREATE POLICY posts_insert_public ON public.posts FOR INSERT WITH CHECK (true);
DROP POLICY IF EXISTS posts_delete_public ON public.posts;
CREATE POLICY posts_no_delete ON public.posts FOR DELETE USING (false);
DROP POLICY IF EXISTS posts_update_public ON public.posts;
CREATE POLICY posts_no_update ON public.posts FOR UPDATE USING (false);

-- توجه: با posts_no_delete/update، حذف مطلب از فرماندهی با anon ممکن نیست تا service_role اضافه شود.
-- اگر فرماندهی باید حذف کند، یا service_role در Worker بگذارید یا policy را بعداً با JWT ادمین باز کنید.
