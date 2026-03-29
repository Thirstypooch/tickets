-- ============================================
-- TICKETS: Events/Ticketing Database Schema
-- Run this in Supabase SQL Editor
-- ============================================

create extension if not exists "uuid-ossp";

-- Profiles (extends Supabase auth.users)
create table public.profiles (
  id uuid references auth.users(id) on delete cascade primary key,
  display_name text,
  avatar_url text,
  bio text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Auto-create profile on signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, display_name, avatar_url)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1)),
    coalesce(new.raw_user_meta_data->>'avatar_url', '')
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Bookings (ticket reservations with event snapshot)
create table public.bookings (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  tm_event_id text not null,
  quantity integer not null check (quantity > 0),
  unit_price numeric(10,2) not null check (unit_price >= 0),
  total_price numeric(10,2) generated always as (quantity * unit_price) stored,
  status text not null default 'confirmed'
    check (status in ('confirmed', 'pending', 'completed', 'cancelled')),
  -- Event snapshot (denormalized from Ticketmaster at booking time)
  event_name text not null,
  event_date text not null,
  event_venue_name text not null,
  event_city text not null,
  event_image text not null,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index idx_bookings_user_id on public.bookings(user_id);
create index idx_bookings_tm_event_id on public.bookings(tm_event_id);
create index idx_bookings_status on public.bookings(status);
create index idx_bookings_event_date on public.bookings(event_date);

-- Reviews (one per user per event)
create table public.reviews (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  tm_event_id text not null,
  rating integer not null check (rating >= 1 and rating <= 5),
  comment text not null default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique(user_id, tm_event_id)
);

create index idx_reviews_tm_event_id on public.reviews(tm_event_id);
create index idx_reviews_user_id on public.reviews(user_id);

-- Favorites
create table public.favorites (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  tm_event_id text not null,
  created_at timestamptz default now(),
  unique(user_id, tm_event_id)
);

create index idx_favorites_user_id on public.favorites(user_id);

-- ============================================
-- ROW LEVEL SECURITY
-- ============================================

alter table public.profiles enable row level security;
alter table public.bookings enable row level security;
alter table public.reviews enable row level security;
alter table public.favorites enable row level security;

-- Profiles
create policy "Profiles are viewable by everyone"
  on public.profiles for select using (true);
create policy "Users can update own profile"
  on public.profiles for update using (auth.uid() = id);

-- Bookings
create policy "Users can view own bookings"
  on public.bookings for select using (auth.uid() = user_id);
create policy "Users can create own bookings"
  on public.bookings for insert with check (auth.uid() = user_id);
create policy "Users can update own bookings"
  on public.bookings for update using (auth.uid() = user_id);

-- Reviews
create policy "Reviews are viewable by everyone"
  on public.reviews for select using (true);
create policy "Users can create own reviews"
  on public.reviews for insert with check (auth.uid() = user_id);
create policy "Users can update own reviews"
  on public.reviews for update using (auth.uid() = user_id);
create policy "Users can delete own reviews"
  on public.reviews for delete using (auth.uid() = user_id);

-- Favorites
create policy "Users can view own favorites"
  on public.favorites for select using (auth.uid() = user_id);
create policy "Users can create own favorites"
  on public.favorites for insert with check (auth.uid() = user_id);
create policy "Users can delete own favorites"
  on public.favorites for delete using (auth.uid() = user_id);

-- ============================================
-- TRIGGERS
-- ============================================

create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger set_profiles_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

create trigger set_bookings_updated_at
  before update on public.bookings
  for each row execute function public.set_updated_at();

create trigger set_reviews_updated_at
  before update on public.reviews
  for each row execute function public.set_updated_at();
