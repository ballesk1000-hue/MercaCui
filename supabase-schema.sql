-- =====================================================
-- MERCACUI - BASE DE DATOS
-- =====================================================

create extension if not exists "pgcrypto";

-- TRABAJADORES
create table if not exists public.trabajadores (
    id uuid primary key default gen_random_uuid(),
    nombre text not null,
    documento text,
    cargo text,
    empresa text,
    ciudad text,
    fecha_registro timestamptz default now()
);

-- ENCUESTAS
create table if not exists public.encuestas (
    id uuid primary key default gen_random_uuid(),
    trabajador_id uuid references public.trabajadores(id)
        on delete set null,
    fecha timestamptz default now(),
    observaciones text
);

-- RESPUESTAS
create table if not exists public.respuestas_encuesta (
    id uuid primary key default gen_random_uuid(),
    encuesta_id uuid references public.encuestas(id)
        on delete cascade,
    pregunta text not null,
    respuesta text,
    fecha timestamptz default now()
);

-- PROPUESTAS
create table if not exists public.propuestas (
    id uuid primary key default gen_random_uuid(),
    titulo text not null,
    descripcion text,
    estado text default 'Pendiente',
    fecha_creacion timestamptz default now()
);

-- ACTIVIDADES
create table if not exists public.actividades (
    id uuid primary key default gen_random_uuid(),
    titulo text not null,
    descripcion text,
    fecha date,
    estado text default 'Pendiente',
    fecha_creacion timestamptz default now()
);

-- SEGURIDAD
alter table public.trabajadores enable row level security;
alter table public.encuestas enable row level security;
alter table public.respuestas_encuesta enable row level security;
alter table public.propuestas enable row level security;
alter table public.actividades enable row level security;

-- POLÍTICAS DE PRUEBA
create policy "lectura trabajadores"
on public.trabajadores
for select
to anon
using (true);

create policy "crear trabajadores"
on public.trabajadores
for insert
to anon
with check (true);

create policy "lectura encuestas"
on public.encuestas
for select
to anon
using (true);

create policy "crear encuestas"
on public.encuestas
for insert
to anon
with check (true);

create policy "lectura respuestas"
on public.respuestas_encuesta
for select
to anon
using (true);

create policy "crear respuestas"
on public.respuestas_encuesta
for insert
to anon
with check (true);

create policy "lectura propuestas"
on public.propuestas
for select
to anon
using (true);

create policy "crear propuestas"
on public.propuestas
for insert
to anon
with check (true);

create policy "lectura actividades"
on public.actividades
for select
to anon
using (true);

create policy "crear actividades"
on public.actividades
for insert
to anon
with check (true);
