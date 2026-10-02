# Library Management System (BCA Final Project)

A library management system for a college library \u2014 book catalog, member registry, issue/return workflow with automatic fine calculation, and transaction history. The frontend is static (HTML/CSS/JS, hosted free on GitHub Pages); the data lives in a real, shared Postgres database via [Supabase](https://supabase.com), so every visitor sees the same catalog.

**Live demo:** https://YOUR-USERNAME.github.io/library-management-system/

## Features
- **Books:** add, delete, search by title/author/ISBN, live available-copies count.
- **Members:** add, delete, search by name or roll/staff number.
- **Issue / Return:** issue a book to a member with a due date; returning it automatically calculates a late fine (\u20b92/day).
- **History:** full log of every transaction, including fines charged.
- **Dashboard:** live counts of titles, total copies, books issued, overdue, and members.

## Architecture
```
Browser (index.html/style.css/app.js, hosted on GitHub Pages)
        |
        | REST calls via the Supabase JS client
        v
Supabase (hosted Postgres + auto-generated API)
```
No backend server to run or deploy yourself \u2014 Supabase provides the API layer directly from the database.

## Setup
1. **Create a Supabase project** at [supabase.com](https://supabase.com) (free, no card required).
2. **Run the schema**: open the SQL Editor in your project, paste in `supabase_schema.sql`, and run it. This creates the `books`, `members`, and `transactions` tables, sets up Row Level Security, and seeds a few demo rows.
3. **Get your credentials**: Project Settings \u2192 API \u2192 copy the Project URL and the `anon public` key.
4. **Fill in `config.js`** with those two values.
5. **Open `index.html`** locally to confirm it connects \u2014 you should see the seeded books appear.

## Deploy on GitHub Pages
1. Create a public GitHub repo named `library-management-system`.
2. Upload every file in this folder (`index.html`, `style.css`, `app.js`, `config.js`, `supabase_schema.sql`, this README) to the repo root.
3. Settings \u2192 Pages \u2192 Deploy from a branch \u2192 `main` / root \u2192 Save.
4. Your live link appears at `https://YOUR-USERNAME.github.io/library-management-system/`.

## Security note (read before using real data)
This demo's Row Level Security policies allow **anyone with the link** to add, edit, or delete data \u2014 intentionally, to keep the first version simple. That's fine for a CV demo, but not for a real library. To lock it down:
- Add Supabase Auth (email/password or magic link) for librarian login.
- Change the RLS policies in `supabase_schema.sql` from `using (true)` to `using (auth.uid() is not null)`, so only logged-in users can write.
- Keep `select` (read) policies open if you still want anyone to browse the catalog without logging in.

## Natural next steps for a fuller version
- Librarian login (see above) so only authorised staff can add/delete books and members.
- Barcode/ISBN scanning for faster book entry (same technique as the QR scanning in the robotics-lab-tracker project).
- Overdue-notice emails using Supabase Edge Functions.
- A printable fine receipt.

## Tech stack
HTML, CSS, vanilla JavaScript, Supabase (Postgres + REST API via `@supabase/supabase-js`). No framework, no server you have to run yourself.
