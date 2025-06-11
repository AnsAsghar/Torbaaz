-- Enable necessary extensions
create extension if not exists "uuid-ossp";

-- Create tables
create table public.admins (
  id uuid references auth.users(id) primary key,
  role text not null check (role in ('super_admin', 'admin')),
  created_at timestamptz default now()
);

create table public.restaurants (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  description text,
  address text,
  phone text,
  logo_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.menu_categories (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  icon_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.food_items (
  id uuid default uuid_generate_v4() primary key,
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  category_id uuid references public.menu_categories(id) on delete cascade,
  name text not null,
  description text,
  price decimal(10,2) not null,
  image_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.deals (
  id uuid default uuid_generate_v4() primary key,
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  title text not null,
  description text,
  price decimal(10,2) not null,
  image_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.ai_txt_uploads (
  id uuid default uuid_generate_v4() primary key,
  uploaded_by uuid references auth.users(id),
  file_url text not null,
  uploaded_at timestamptz default now()
);

-- Create updated_at triggers
create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger handle_restaurants_updated_at
  before update on public.restaurants
  for each row
  execute function public.handle_updated_at();

create trigger handle_menu_categories_updated_at
  before update on public.menu_categories
  for each row
  execute function public.handle_updated_at();

create trigger handle_food_items_updated_at
  before update on public.food_items
  for each row
  execute function public.handle_updated_at();

create trigger handle_deals_updated_at
  before update on public.deals
  for each row
  execute function public.handle_updated_at();

-- RLS Policies
-- Enable RLS on all tables
alter table public.admins enable row level security;
alter table public.restaurants enable row level security;
alter table public.menu_categories enable row level security;
alter table public.food_items enable row level security;
alter table public.deals enable row level security;
alter table public.ai_txt_uploads enable row level security;

-- Function to check if user is admin
create or replace function public.is_admin(user_id uuid)
returns boolean as $$
begin
  return exists (
    select 1
    from public.admins
    where id = user_id
  );
end;
$$ language plpgsql security definer;

-- Admins table policies
create policy "Users can insert their own admin record"
  on public.admins for insert
  with check (auth.uid() = id);

create policy "Users can view their own admin record"
  on public.admins for select
  using (auth.uid() = id);

create policy "Users can update their own admin record"
  on public.admins for update
  using (auth.uid() = id)
  with check (auth.uid() = id);

create policy "Users can delete their own admin record"
  on public.admins for delete
  using (auth.uid() = id);

-- Restaurant policies (admin only)
create policy "Admins can select restaurants"
  on public.restaurants for select
  using (public.is_admin(auth.uid()));

create policy "Admins can insert restaurants"
  on public.restaurants for insert
  with check (public.is_admin(auth.uid()));

create policy "Admins can update restaurants"
  on public.restaurants for update
  using (public.is_admin(auth.uid()));

create policy "Admins can delete restaurants"
  on public.restaurants for delete
  using (public.is_admin(auth.uid()));

-- Menu categories policies (admin only)
create policy "Admins can select menu categories"
  on public.menu_categories for select
  using (public.is_admin(auth.uid()));

create policy "Admins can insert menu categories"
  on public.menu_categories for insert
  with check (public.is_admin(auth.uid()));

create policy "Admins can update menu categories"
  on public.menu_categories for update
  using (public.is_admin(auth.uid()));

create policy "Admins can delete menu categories"
  on public.menu_categories for delete
  using (public.is_admin(auth.uid()));

-- Food items policies (admin only)
create policy "Admins can select food items"
  on public.food_items for select
  using (public.is_admin(auth.uid()));

create policy "Admins can insert food items"
  on public.food_items for insert
  with check (public.is_admin(auth.uid()));

create policy "Admins can update food items"
  on public.food_items for update
  using (public.is_admin(auth.uid()));

create policy "Admins can delete food items"
  on public.food_items for delete
  using (public.is_admin(auth.uid()));

-- Deals policies (admin only)
create policy "Admins can select deals"
  on public.deals for select
  using (public.is_admin(auth.uid()));

create policy "Admins can insert deals"
  on public.deals for insert
  with check (public.is_admin(auth.uid()));

create policy "Admins can update deals"
  on public.deals for update
  using (public.is_admin(auth.uid()));

create policy "Admins can delete deals"
  on public.deals for delete
  using (public.is_admin(auth.uid()));

-- AI txt uploads policies (admin only)
create policy "Admins can select AI txt uploads"
  on public.ai_txt_uploads for select
  using (public.is_admin(auth.uid()));

create policy "Admins can insert AI txt uploads"
  on public.ai_txt_uploads for insert
  with check (public.is_admin(auth.uid()));

create policy "Admins can update AI txt uploads"
  on public.ai_txt_uploads for update
  using (public.is_admin(auth.uid()));

create policy "Admins can delete AI txt uploads"
  on public.ai_txt_uploads for delete
  using (public.is_admin(auth.uid()));

-- Public access policies
create policy "Public can view restaurants"
  on public.restaurants for select
  using (true);

create policy "Public can view menu categories"
  on public.menu_categories for select
  using (true);

create policy "Public can view food items"
  on public.food_items for select
  using (true);

create policy "Public can view deals"
  on public.deals for select
  using (true);

-- Create storage bucket
-- Note: Run this in Supabase dashboard or via API
-- insert into storage.buckets (id, name, public) values ('public', 'public', true);

-- Create storage policies
-- Note: Run this in Supabase dashboard or via API
/*
create policy "Public Access"
  on storage.objects for select
  using ( bucket_id = 'public' );

create policy "Admin Insert"
  on storage.objects for insert
  with check (
    bucket_id = 'public' 
    and public.is_admin(auth.uid())
  );

create policy "Admin Update"
  on storage.objects for update
  using (
    bucket_id = 'public'
    and public.is_admin(auth.uid())
  );

create policy "Admin Delete"
  on storage.objects for delete
  using (
    bucket_id = 'public'
    and public.is_admin(auth.uid())
  );
*/ 