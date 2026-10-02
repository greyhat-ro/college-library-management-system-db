-- Run this once in Supabase: Project -> SQL Editor -> New query -> paste -> Run

create table if not exists books (
  id bigint generated always as identity primary key,
  title text not null,
  author text not null,
  isbn text,
  category text,
  total_copies int not null default 1,
  created_at timestamptz default now()
);

create table if not exists members (
  id bigint generated always as identity primary key,
  name text not null,
  roll_no text not null,
  type text not null default 'Student',
  email text,
  created_at timestamptz default now()
);

create table if not exists transactions (
  id bigint generated always as identity primary key,
  book_id bigint references books(id) on delete restrict,
  member_id bigint references members(id) on delete restrict,
  issued_date date not null default current_date,
  due_date date not null,
  returned_date date,
  fine numeric default 0
);

-- Row Level Security: required by Supabase before any client (even with the
-- anon key) can read or write. This demo version opens read/write to anyone,
-- which is fine for a CV demo but NOT for a real deployment with real data
-- -- see the README for how to restrict this to logged-in users later.
alter table books enable row level security;
alter table members enable row level security;
alter table transactions enable row level security;

create policy "public read books" on books for select using (true);
create policy "public write books" on books for insert with check (true);
create policy "public delete books" on books for delete using (true);

create policy "public read members" on members for select using (true);
create policy "public write members" on members for insert with check (true);
create policy "public delete members" on members for delete using (true);

create policy "public read transactions" on transactions for select using (true);
create policy "public write transactions" on transactions for insert with check (true);
create policy "public update transactions" on transactions for update using (true);

-- Demo seed data (optional -- delete this block if you'd rather start empty)
insert into books (title, author, isbn, category, total_copies) values
  ('Introduction to Algorithms', 'Cormen et al.', '9780262033848', 'Computer Science', 4),
  ('Database System Concepts', 'Silberschatz', '9780073523323', 'Computer Science', 3),
  ('Clean Code', 'Robert C. Martin', '9780132350884', 'Software Engineering', 2);

insert into members (name, roll_no, type, email) values
  ('Priya Sharma', 'BCA2301', 'Student', 'priya@example.com'),
  ('Rahul Nair', 'BCA2314', 'Student', 'rahul@example.com');
