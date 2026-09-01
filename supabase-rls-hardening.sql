-- پدافند شبهات — سیاست RLS پیشنهادی (در SQL Editor سوپابیس اجرا شود)
-- قبل از اجرا از داده بکاپ بگیرید.

ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inbox ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.saved ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.commander_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;

-- posts: همه بخوانند؛ نوشتن فقط با anon محدود (فعلاً برای سازگاری سایت)
DROP POLICY IF EXISTS posts_select_all ON public.posts;
CREATE POLICY posts_select_all ON public.posts FOR SELECT USING (true);

DROP POLICY IF EXISTS posts_insert_auth ON public.posts;
CREATE POLICY posts_insert_auth ON public.posts FOR INSERT WITH CHECK (true);

-- بهتر است بعداً INSERT را فقط از service role / edge ببندید.

DROP POLICY IF EXISTS users_select_all ON public.users;
CREATE POLICY users_select_all ON public.users FOR SELECT USING (true);

DROP POLICY IF EXISTS users_update_own ON public.users;
-- بدون auth.uid واقعی، محدودیت سخت ممکن است سایت را بشکند.
-- پس از افزودن Supabase Auth، این را به auth.uid() محدود کنید.

-- نمونه سخت‌گیرانه برای آینده:
-- CREATE POLICY users_update_own ON public.users FOR UPDATE USING (auth.uid()::text = id::text);
