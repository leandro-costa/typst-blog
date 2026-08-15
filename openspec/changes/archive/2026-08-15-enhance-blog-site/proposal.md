# Enhance Blog Site

## Why

O site hoje é um blog cronológico simples (home com cards + páginas por post). O usuário
quer transformá-lo numa **plataforma de aula/curso** (POO) com navegação entre postagens,
filtro por tags, busca, sidebar, RSS e posts relacionados — e também criar a **fundação de
conteúdo** (subpastas por tipo, nomenclatura agrupada por aula, referências compartilhadas)
que o livro didático (`didactic-book`) vai consumir. Sem essa base, site e livro não têm
como organizar aulas, exercícios, soluções e trabalhos coerentemente.

## What Changes

- **BREAKING**: Substitui o modelo "um post cronológico" por um **modelo de conteúdo
  tipado**:
  - `posts/` ganha subpastas por tipo: `aulas/`, `exercicios/`, `solucoes/`, `trabalhos/`.
  - Nomenclatura com prefixo de grupo: `aula-01-poo`, `aula-01-exer-01`,
    `aula-01-solu-01` — o build extrai `{ grupo, tipo, número }` do nome e ordena por
    `(grupo, prioridade-do-tipo, número)`, agrupando o mesmo assunto.
  - `meta` ganha `type` (derivado da subpasta) e `group` (do prefixo do nome).
- **BREAKING**: `refs.bib` passa a ser **fonte única** de referências, usada por site e
  livro. O site gera uma página `Referências` (tentativa de `#bibliography` nativo no
  export HTML; risco aceito).
- Navegação **anterior/próximo** entre postagens, baseada na ordem de grupo.
- **Tags como páginas estáticas**: `/tags/<tag>.html` por tag + nuvem de tags na sidebar.
- **Busca** ao vivo via JS de assets (o build emite um `search-index.json`).
- **Sidebar** estática (sobre, tags, posts recentes, busca, link do livro).
- **Posts relacionados** (por grupo/tags compartilhadas) em cada página de post.
- **Reading time** estimado pelo build a partir do corpo.
- **RSS** (`/rss.xml` ou `feed.xml`) gerado pelo build a partir dos metadados.

## Capabilities

### New Capabilities
- `site-search`: busca ao vivo no site — index JSON emitido pelo build + um JS estático de
  assets que filtra título/tags/excerpt e renderiza resultados.

### Modified Capabilities
- `post-authoring`: modelo de conteúdo — subpastas por tipo, nomenclatura por grupo,
  `meta {type, group}`, convenção de citação/referências (`refs.bib`).
- `site-generation`: navegação prev/next, sidebar, tags estáticas, posts relacionados,
  reading time, página de Referências, RSS.
- `build-tooling`: build agrupa/ordena por grupo e tipo, emite `search-index.json`,
  `rss.xml` e estima reading time.

## Impact

- `scripts/`: `parse-posts.ts` (lê subpastas, extrai type/group), `generate-site.ts`
  (novas páginas: tags, referências; nav/sidebar/relacionados), novo emissor de RSS e de
  index de busca.
- `templates/site.typ`: sidebar, post-nav, tag cloud, related, resultados de busca (estrutura).
- `assets/js/`: busca (progressive enhancement); `assets/css/`: layout 2 colunas, cards.
- `refs.bib` na raiz (compartilhado com o livro).
- `posts/*`: migração para subpastas + nomenclatura; enriquecimento com `refs.bib`.
- O livro didático (`didactic-book`) depende desta fundação de conteúdo.