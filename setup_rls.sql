/* ============================================================
   SatGPS - Configuração RLS do Supabase (OPCIONAL)
   ============================================================
   
   ⚠️ RODE ESTE SQL NO SUPABASE SE:
   - Adicionar veículo não funcionar (HTTP 401/403)
   - "Criar localização inicial" no rastreador.html falhar
   
   Como rodar:
   1. Acesse https://supabase.com/dashboard
   2. Selecione seu projeto
   3. Menu lateral → SQL Editor → New query
   4. Cole todo este código → Run
   ============================================================ */

-- 1. Garante que a tabela rastreador existe
CREATE TABLE IF NOT EXISTS public.rastreador (
  device_id text PRIMARY KEY,
  lat double precision NOT NULL,
  lng double precision NOT NULL,
  battery integer DEFAULT 0,
  updated_at timestamptz DEFAULT now()
);

-- 2. Habilita RLS
ALTER TABLE public.rastreador ENABLE ROW LEVEL SECURITY;

-- 3. Permite SELECT público (dashboard e rastreador.html leem)
DROP POLICY IF EXISTS "select_rastreador" ON public.rastreador;
CREATE POLICY "select_rastreador"
  ON public.rastreador FOR SELECT
  TO anon, authenticated
  USING (true);

-- 4. Permite INSERT público (painel adiciona veículo)
DROP POLICY IF EXISTS "insert_rastreador" ON public.rastreador;
CREATE POLICY "insert_rastreador"
  ON public.rastreador FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- 5. Permite UPDATE público (rastreador no carro envia posição)
DROP POLICY IF EXISTS "update_rastreador" ON public.rastreador;
CREATE POLICY "update_rastreador"
  ON public.rastreador FOR UPDATE
  TO anon, authenticated
  USING (true) WITH CHECK (true);

-- 6. Permite DELETE público (painel exclui veículo)
DROP POLICY IF EXISTS "delete_rastreador" ON public.rastreador;
CREATE POLICY "delete_rastreador"
  ON public.rastreador FOR DELETE
  TO anon, authenticated
  USING (true);

-- 7. Cria entradas iniciais se ainda não existirem (opcional)
INSERT INTO public.rastreador (device_id, lat, lng, battery, updated_at) VALUES
  ('PALIO1', -24.120, -48.345, 0, now()),
  ('PALIO2', -24.120, -48.345, 0, now()),
  ('MOTO', -24.120, -48.345, 0, now())
ON CONFLICT (device_id) DO NOTHING;

-- PRONTO! Agora o painel pode adicionar/excluir veículos
-- e o rastreador.html pode criar localização inicial automaticamente.
