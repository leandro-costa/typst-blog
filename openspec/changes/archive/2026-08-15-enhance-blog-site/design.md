# Design — Enhance Blog Site

## Context

O projeto renderiza tudo em Typst (bundle export para o site, compile para o livro PDF),
com build em TS/Bun. Hoje o site é home + páginas por post, ordenadas por `meta.date`. Os
posts vivem achatados em `posts/` (`AAAA-MM-DD-slug.typ`). Este change introduz um modelo
de conteúdo tipado/agrupado por aula e as funcionalidades de site (nav, tags, busca,
sidebar, relacionados, reading time, RSS, referências). O livro (`didactic-book`) depende
desta fundação.

## Goals / Non-Goals

**Goals:**
- Modelo de conteúdo tipado: subpastas `aulas|exercicios|solucoes|trabalhos`, nomenclatura
  com grupo (`aula-01-poo`), ordenação por `(grupo, tipo, número)`.
- `refs.bib` como fonte única de referências para site e livro.
- Site com: prev/next, tags estáticas, busca ao vivo, sidebar, posts relacionados, reading
  time, página de Referências e RSS.
- Busca e RSS sem quebrar o princípio "HTML estrutural do Typst" (JS é só progressive
  enhancement; dados/feed vêm do build).

**Non-Goals:**
- Filtro de tags ao vivo por JS (será páginas estáticas).
- Recursos do livro didático (listas de figuras/tabelas/código, exercícios+gabarito,
  apêndice de trabalhos) — ficam no change `didactic-book`.
- Full-text do corpo na busca (escopo: título + tags + excerpt).
- Migração/reescrita de conteúdo dos posts existentes (segue como follow-up ou no apply).

## Decisions

### 1. Modelo de conteúdo tipado (fundação)
- `posts/` com subpastas por tipo: `aulas/`, `exercicios/`, `solucoes/`, `trabalhos/`.
- Nome do arquivo: prefixo de grupo `<grupo>-<seq>-<slug>.typ`, ex.: `aula-01-poo`,
  `aula-01-exer-01`. O **build** extrai do nome: `group` (ex.: `aula-01`), `type`
  (da subpasta), `number` (opcional).
- `meta` (dentro do arquivo) mantém `title, date, slug, author, tags, excerpt` e passa a
  expor `type` (derivado da subpasta) e `group` (derivado do prefixo).
- Ordenação do site: `(group asc, tipo-prioridade [aula < exercicio < solucao < trabalho],
  número asc)`. O blog "cronológico" migra para o RSS (que usa `meta.date`).
- `parse-posts.ts` passa a varrer recursivamente `posts/`, inferir tipo pela subpasta e
  extrair grupo/número do nome.

### 2. Referências compartilhadas
- `refs.bib` na raiz, usado por site e livro.
- Livro: `#bibliography("refs.bib")` nativo (PDF) — confiável.
- Site: tenta `#bibliography` no export HTML (risco aceito). Se o export HTML não
  renderizar bem, fallback: build lê o `.bib` e emite uma página `Referências` estática,
  e citações no corpo viram links simples. **Spike**: validar suporte de
  `#bibliography`/`@cite` no target html do Typst 0.15.

### 3. Tags como páginas estáticas
- Build calcula o conjunto de tags e, por tag, a lista de posts.
- `generate-site.ts` emite um `#document` por tag em `/tags/<tag>.html` com os cards
  filtrados + link de volta.
- Sidebar mostra nuvem de tags apontando para essas páginas. Sem JS de filtro.

### 4. Busca via JS de assets
- Build emite `dist/search-index.json` (`{title, slug, date, tags, excerpt, url}` por post).
- `assets/js/search.js` lê o index, escuta `<input id="search">` e renderiza em
  `<div id="search-results">`.
- Estrutura HTML (input + container) emitida pelo Typst via `html.elem`; o JS é
  progressive enhancement (sem JS, o site continua funcional).
- Escopo inicial de busca: título + tags + excerpt.

### 5. Navegação prev/next, relacionados, reading time, sidebar
- `generate-site.ts` calcula prev/next pela ordem de grupo e emite links em cada página de
  post (helper `post-nav` no template).
- Posts relacionados: mesmos posts do mesmo `group`, ou que compartilham ≥1 tag, excluindo
  o atual; emitidos no rodapé da página de post.
- Reading time: build estima a partir do corpo (strip de markup Typst → nº palavras ÷ wpm)
  e expõe no card e na página do post.
- Sidebar estática (`<aside>`): sobre, nuvem de tags, posts recentes (top N), caixa de
  busca e link do livro. `site-layout` ganha parâmetro `sidebar`; o build monta o conteúdo
  da sidebar e passa para o template. No preview paged, a sidebar e a busca são omitidas
  (são HTML-only).

### 6. RSS
- Build gera `dist/rss.xml` (Atom) a partir dos metadados (`title, date, slug, excerpt,
  url`), ordenado por `meta.date` desc — é aqui que vive o "cronológico".
- Link do feed na navbar/header.

### 7. Preview (Tinymist, paged)
- O branch `is-preview` continua tipografado (título + lista + posts). Elementos HTML-only
  (sidebar, busca, nav prev/next) não aparecem no preview paged; ficam só no bundle.

## Risks / Trade-offs

- [`#bibliography` no export HTML é limitado/experimental] → Spike de validação na 0.15;
  fallback de página de Referências via build.
- [Busca usa título/tags/excerpt, não full-text] → Escopo inicial claro; full-text exige
  strip confiável do markup Typst (follow-up).
- [Busca/JS dobra o princípio "100% Typst"] → Aceito de forma explícita: estrutura HTML
  continua do Typst; JS é progressive enhancement; dados vêm do build TS.
- [Modelo de conteúdo é BREAKING] → `parse-posts`/`generate-site` e a estrutura de `posts/`
  mudam; posts existentes precisam migrar para subpastas/nomenclatura nova.
- [Ordenação por grupo substitui a cronológica no site] → Cronologia preservada no RSS.