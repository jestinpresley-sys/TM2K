# T.M.2.K

Website for **T.M.2.K (Thatman2Know)**, Cam Carver, a St. Louis bass and dubstep DJ.

- `index.html`: the public site. Mixes with SoundCloud players, Upcoming and Past shows, bio and booking.
- `admin/`: the editor Cam uses to add mixes and show dates from his phone.
- `config.js`: the database connection, shared by both pages.
- `supabase/`: the database setup (`schema.sql`) and the content the site launched with (`seed.sql`).

The site reads mixes and shows from a free Supabase database. Until `config.js` is filled in, or if the database can't be reached, it shows the built-in content in `index.html`, so the site never goes blank.

## One-time setup (about 10 minutes)

### 1. Create the database

1. Sign up at [supabase.com](https://supabase.com) and create a project (the free plan is enough). Pick a region near St. Louis, such as US East (Ohio).
2. Open **SQL Editor** → **New query**, paste all of `supabase/schema.sql`, and click **Run**.
3. Open `supabase/seed.sql`. Check the two emails at the bottom: they decide who can edit. Then paste the whole file into a new query and **Run** it. This loads the current mixes and shows.

### 2. Connect the site

1. In Supabase, go to **Project Settings → API**.
2. Copy the **Project URL** and the **anon public** key into `config.js`, then commit and push.

The anon key is designed to be public. The database rules in `schema.sql` let anyone read, and only emails listed in the `admins` table can add, edit or delete.

### 3. Give Cam a login

1. In Supabase, go to **Authentication → Users → Add user → Create new user**. Enter Cam's email (the one in the `admins` table) and a password, and tick **Auto Confirm User**.
2. Go to **Authentication → Sign In / Providers** and turn off **Allow new users to sign up**, so nobody else can create an account.
3. Go to **Authentication → URL Configuration** and set **Site URL** to `https://thatman2know.com/admin/`. The "Email me a link" sign-in sends people there.

Cam signs in at **https://thatman2know.com/admin/**. Saving it to his home screen makes it feel like an app.

## Using the admin page

- **Shows**: tap **Add show**, enter the date and event name, then the venue, set time, details and ticket link if known. Shows move from Upcoming to Past on their own after the date.
- **Mixes**: tap **Add mix**, paste the SoundCloud link, and tap **Fill in details**. Title, description, cover and player fill in from SoundCloud. Plays and likes are optional and typed in by hand. Ticking **Feature** puts that mix in the big slot at the top.

Changes show up on the site immediately; no redeploy needed.

## Adding another editor

Run this in the SQL Editor, then create their user as in step 3:

```sql
insert into public.admins (email) values ('their@email.com');
```

## Hosting

GitHub Pages, from the `main` branch root. No build step. Link previews (iMessage, Instagram, Discord) use `og.jpg`.

Site by Presley Designs.
