# SatGPS - Frota PRO

Sistema de rastreamento de frota com painel admin + link público compartilhável.

## 📦 Arquivos

| Arquivo | Função |
|---|---|
| `index.html` | Painel da frota (login admin/1234, CRUD de veículos) |
| `rastreador.html` | Mapa individual do veículo (link público pro cliente) |
| `manifest.json` | PWA installável (SatGPS - Frota PRO) |
| `service-worker.js` | Cache offline |
| `setup_rls.sql` | SQL opcional para liberar INSERT/UPDATE/DELETE no Supabase |

## 🚀 Publicar no GitHub Pages

1. Suba todos os 5 arquivos no repositório https://github.com/negrete79/Satgps
2. Settings → Pages → Branch: main / Folder: / → Save
3. Em ~1 minuto estará em:
   - Painel: https://negrete79.github.io/Satgps/
   - Exemplo: https://negrete79.github.io/Satgps/rastreador.html?id=PALIO1

## ⚙️ Configuração do Supabase (IMPORTANTE)

Para o painel poder **adicionar/excluir veículos** automaticamente, rode o SQL `setup_rls.sql` no Supabase:

1. https://supabase.com/dashboard
2. Selecione o projeto
3. SQL Editor → New query
4. Cole o conteúdo de `setup_rls.sql`
5. Run

Isso libera INSERT/UPDATE/DELETE na tabela `rastreador` para a chave publicável.

## 🎯 Funcionalidades

### Painel (index.html)
- 🔐 Login admin / 1234 (salva em localStorage)
- 📊 Stats no topo: Total, Online (< 2 min), Bateria média
- ➕ Adicionar veículo (cria no Supabase com localização inicial)
- ✏️ Editar (não permite mudar ID)
- 🗑️ Excluir com dupla confirmação (digitar ID)
- 🔄 Atualização automática a cada 6 segundos
- 📋 Copiar link / 🔗 Abrir link / 📍 Ver mapa

### Rastreador (rastreador.html?id=ID)
- 🗺️ Mapa Leaflet satélite (Google) + rua (OpenStreetMap)
- 🚗 Marcador customizado de carro (estilo Tesla/99)
- 📍 Foca no veículo com zoom 17 na primeira carga
- 🎈 Botão flutuante "voltar ao carro" quando usuário arrasta mapa
- 📱 Bottom sheet arrastável com info do veículo
- 🔋 Bateria com barra colorida (verde/amarelo/vermelho)
- ⏱️ "Atualizado há X min" atualiza sozinho
- 🆘 Se ID não existe: botão "Criar localização inicial" (cria no Supabase)
- 🟢 Status online/offline baseado em updated_at (< 2 min)

### PWA
- ✅ Instalável no Android e iPhone
- ✅ Abre fullscreen standalone
- ✅ Funciona offline (cached)
- ✅ Ícone de satélite

## 🔗 Links importantes

- Painel admin: `https://negrete79.github.io/Satgps/`
- Link do cliente (compartilhar no WhatsApp):
  `https://negrete79.github.io/Satgps/rastreador.html?id=ID_DO_VEICULO`

## 👤 Créditos

Criado por Elias Costa • NEGRET'S
