## Context

O site é um project site do GitHub Pages servido em `/typst-blog/`. Todo link/asset interno é
emitido como caminho absoluto de raiz (`/assets/...`, `/index.html`, `/posts/...`, `/tags/...`,
`/categorias/...`, `/book.pdf`, `/rss.xml`, `/search-index.json`), que resolve contra o domínio
raiz e quebra em produção. O `typst.toml` já tem `site.url` (placeholder `https://example.org`),
usado apenas pelo RSS. O build é TypeScript (Bun) que gera `site.typ` e o compila com o bundle
export do Typst; templates em Typst; assets estáticos copiados para `dist/`.

Fluxo de geração atual:
```
typst.toml → build.ts → generate-site.ts → site.typ → (Typst) → dist/*.html
                       → static-outputs.ts → dist/search-index.json, rss.xml
                       → copyAssets → dist/assets/* (inclui search.js)
```

## Goals / Non-Goals

**Goals:**
- Todos os links e assets internos passam a respeitar um base path configurável.
- Build local (`serve`) continua idêntico: sem prefixo (raiz).
- RSS e busca usam a mesma fonte de verdade do base path.
- Fonte de verdade única: `site.url` no `typst.toml`.

**Non-Goals:**
- Migrar para user site/domínio próprio (não é necessário se o base path resolver).
- Reestruturar o layout ou a geração do site.
- Mudanças no livro PDF (`book.typ`).
- Autoria de posts.

## Decisions

### 1. Fonte de verdade: derivar o base path de `site.url`
O `site.url` passa de placeholder para `https://leandro-costa.github.io/typst-blog`. O build
deriva o base path fazendo parse da URL (`new URL(url).pathname`), normalizando para terminar
sem `/` (ex.: `/typst-blog`, ou `""` para raiz). O mesmo valor alimenta RSS (URL inteira) e o
HTML (path).
- **Alternativa rejeitada:** campo dedicado `site.base`. Duplicaria o mesmo fato em dois lugares,
  com risco de divergência. Derivar de `site.url` garante uma única fonte de verdade.

### 2. Prefixo nos links gerados pelo Typst (HTML)
`generate-site.ts` emite `#let base = "<base-path>"` no topo de `site.typ` e passa `base: base`
para cada `#site-layout(...)`. Em `templates/site.typ`, `site-layout` recebe `base` (default `""`)
e o repassa a `head`, `nav` e `footer`, que concatenam `base + "/..."` em todos os `href`/`src`.
Os links de tags/posts/`book.pdf` já emitidos no próprio `generate-site.ts` são prefixados
diretamente no TypeScript.

### 3. Prefixo nas saídas estáticas (search-index + RSS)
`static-outputs.ts`: o `url` de cada entrada do `search-index.json` passa a ser
`base + "/posts/<slug>.html"`. O RSS continua usando `site.url` completo como base (já inclui o
subcaminho), sem mudança funcional.

### 4. Prefixo no `search.js` (asset estático)
O `search.js` é um arquivo estático sem injeção no build. Ele deriva o base path em runtime a
partir do próprio caminho do script: `document.currentScript.src` termina em
`<base>/assets/js/search.js`, então remove o sufixo `/assets/js/search.js` para obter `<base>`
(e `""` quando o site está na raiz). Usa esse valor para `fetch(base + "/search-index.json")`.
Os `item.url` vindos do índice já vêm prefixados, então os resultados apontam certo.

## Risks / Trade-offs

- **Base path duplicado em dois pontos de concatenação** (Typst e TS) → Mitigação: derivar sempre
  do mesmo `site.url` via um único helper `deriveBasePath` em `scripts/lib.ts`.
- **`search.js` depende de `document.currentScript`** → Mitigação: é um padrão suportado em todos
  os navegadores modernos; fallback natural quando o site está na raiz (base vazio).
- **Concatenar caminhos pode gerar `/` duplo** (ex.: base `""` + `/index.html`) → Mitigação:
  helper de junção que normaliza `/`; testar build local (base vazio) e produção (base `/typst-blog`).
- **`site.url` placeholder esquecido** → Mitigação: validar no build que `site.url` não é o
  placeholder `https://example.org`.

## Migration Plan

1. Aplicar o design; `typst.toml` passa a ter a URL real.
2. Verificar localmente: `bun run build` + `bun run serve` → links na raiz funcionam.
3. Push para `main` → GitHub Actions deploya → validar em `/typst-blog/` que CSS, JS, posts,
   tags, categorias, `book.pdf`, RSS e busca carregam.
4. Rollback: reverter para caminhos de raiz (alteração contida em 4 arquivos + config).

## Open Questions

- Nenhuma pendente; a decisão de derivar de `site.url` está fechada.