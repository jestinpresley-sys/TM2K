-- T.M.2.K site database (Supabase / Postgres)
-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
-- Anyone can read mixes and shows. Only emails listed in public.admins can add, edit or delete.

create extension if not exists pgcrypto;

-- Mixes ---------------------------------------------------------------
create table if not exists public.mixes (
  id             uuid primary key default gen_random_uuid(),
  soundcloud_url text not null,
  track_id       text,                      -- SoundCloud numeric id, used by the embedded player
  title          text not null,
  tag            text,                      -- e.g. "Live set", "Series"
  released_on    date,
  blurb          text,
  artwork_url    text,
  plays          integer check (plays is null or plays >= 0),
  likes          integer check (likes is null or likes >= 0),
  featured       boolean not null default false,
  created_at     timestamptz not null default now()
);

-- Shows ---------------------------------------------------------------
create table if not exists public.shows (
  id            uuid primary key default gen_random_uuid(),
  show_date     date not null,
  day_unknown   boolean not null default false,  -- true: site shows the month only
  set_time      text,                            -- e.g. "11:15 PM"
  title         text not null,
  details       text,                            -- lineup, promoter, cause
  venue         text,
  address       text,
  ticket_url    text,
  recording_url text,
  created_at    timestamptz not null default now()
);

-- Who may edit ------------------------------------------------------------
create table if not exists public.admins (
  email text primary key
);

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.admins
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

revoke all on function public.is_admin() from public;
grant execute on function public.is_admin() to anon, authenticated;

-- Row level security ------------------------------------------------------
alter table public.mixes  enable row level security;
alter table public.shows  enable row level security;
alter table public.admins enable row level security;

drop policy if exists "mixes are public"     on public.mixes;
drop policy if exists "admins manage mixes"  on public.mixes;
drop policy if exists "shows are public"     on public.shows;
drop policy if exists "admins manage shows"  on public.shows;
drop policy if exists "admins see own row"   on public.admins;

create policy "mixes are public"    on public.mixes for select to anon, authenticated using (true);
create policy "admins manage mixes" on public.mixes for all    to authenticated using (public.is_admin()) with check (public.is_admin());

create policy "shows are public"    on public.shows for select to anon, authenticated using (true);
create policy "admins manage shows" on public.shows for all    to authenticated using (public.is_admin()) with check (public.is_admin());

-- An admin can see their own row (the admin page uses this to confirm access). Nobody can write here
-- through the API; add admins in the SQL editor.
create policy "admins see own row"  on public.admins for select to authenticated
  using (lower(email) = lower(coalesce(auth.jwt() ->> 'email', '')));

grant select on public.mixes, public.shows to anon, authenticated;
grant insert, update, delete on public.mixes, public.shows to authenticated;
grant select on public.admins to authenticated;
