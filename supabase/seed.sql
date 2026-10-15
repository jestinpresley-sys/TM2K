-- Starting content: what was on the site at launch. Run once, after schema.sql.

insert into public.mixes (soundcloud_url, track_id, title, tag, released_on, blurb, artwork_url, plays, likes, featured) values
('https://soundcloud.com/user-298775178/who-tf-is-tm2k', '2253650108', 'WHO TF IS T.M.2.K?', 'Livestream mix', '2026-01-25',
 'Cut from a livestream: familiar tunes run through his own Ableton edits. The one to start with.',
 'https://i1.sndcdn.com/artworks-sUAEyanOrXFPUalh-UKJWsw-t500x500.jpg', 3666, 197, true),
('https://soundcloud.com/user-298775178/road-to-headbanger-paradise', '2123642814', 'Opening Set for Wonky Willa & Twopercent', 'Live set', '2025-07-25',
 'His opening set for Wonky Willa and Twopercent. A whole journey, start to finish.',
 'https://i1.sndcdn.com/artworks-iRz9F6ByRyCSYOH3-kxd80w-t500x500.jpg', 417, 38, false),
('https://soundcloud.com/user-298775178/for-my-feral-friends-pt-2', '2017615557', 'For My Feral Friends Pt. 2', 'Series', '2025-01-25',
 'Flips and doubles, heavy tunes and fun ones. His first recorded mix on Rekordbox.',
 'https://i1.sndcdn.com/artworks-nUz1KoNpQHTWv2Qz-Ne7gOg-t500x500.jpg', 137, null, false),
('https://soundcloud.com/user-298775178/for-my-feral-friends', '1935563318', 'For My Feral Friends Pt. 1', 'Series', '2024-10-15',
 'Bass house into dubstep flips with hip-hop, built from what his friends love.',
 'https://i1.sndcdn.com/artworks-JzO6WcUIjRWzy0Nh-awh6Og-t500x500.jpg', 169, null, false);

insert into public.shows (show_date, day_unknown, set_time, title, details, venue, address, ticket_url, recording_url) values
('2026-07-14', false, null, 'Twitch Tuesdays', 'Special guest on the Psychonauts Collective livestream', 'Twitch · Live', null, null, null),
('2026-05-01', false, '11:15 PM', 'First One''s Free: Party for Potential', 'Downright Events × Mississippi Underground. A night for a good cause.', 'Mississippi Underground', '1441 N 2nd St', null, null),
('2026-04-11', false, null, 'Bass Playground', 'The first one. With Sadiize, Lunar Riot, Gingersnap × Larious, Ms. Chiff and Hayes.', 'The Crack Fox', '1114 Olive St', null, null),
('2025-08-16', false, null, 'Gene Farris (Chicago)', 'Front room, Downright Entertainment × Party Diva', 'Mississippi Underground', '1441 N 2nd St', null, null),
('2025-07-01', true, null, 'Headbangers Paradise', 'Support for Wonky Willa & Twopercent with B&W STL.', 'Red Flag', null, null, 'https://soundcloud.com/user-298775178/road-to-headbanger-paradise');

-- Who can sign in to /admin and edit. Replace with Cam's email (and yours).
insert into public.admins (email) values
  ('djthatman2know@gmail.com'),
  ('presleyjestin@gmail.com')
on conflict do nothing;

-- Added 2026-10-15: F1F set recording.
insert into public.mixes (soundcloud_url, track_id, title, tag, released_on, blurb, artwork_url, plays, featured) values
('https://soundcloud.com/user-298775178/f1f-mississippi-underground', '2419222914', 'F1F @ Mississippi Underground', 'Live set', '2026-10-14',
 'His set from Mississippi Underground''s charity show for mental health awareness. If you or someone you know is struggling, there''s always an open ear.',
 'https://i1.sndcdn.com/artworks-jkEESpmVIlbkjypB-goA0aw-t500x500.jpg', 9, false);
update public.shows set recording_url = 'https://soundcloud.com/user-298775178/f1f-mississippi-underground'
 where show_date = '2026-05-01' and title like 'First One%';
