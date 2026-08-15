## 1. Fonte de verdade do base path

- [x] 1.1 Adicionar helper `deriveBasePath(url)` (e `joinBasePath`) em `scripts/lib.ts` que deriva o path de uma URL (`new URL(url).pathname`) e normaliza para não terminar em `/` (raiz → `""`).
- [x] 1.2 Preencher `typst.toml` com `site.url = "https://leandro-costa.github.io/typst-blog"` (remover placeholder `https://example.org`).
- [x] 1.3 Adicionar validação no build que `site.url` não seja o placeholder `https://example.org`.

## 2. Prefixo no HTML (Typst)

- [x] 2.1 Em `templates/site.typ`, expor `base` via `sys.inputs.at("base", default: "")` (injetado pelo build via `--input base=...`), sem repasse por parâmetro.
- [x] 2.2 Prefixar com `base` os `href`/`src` em `templates/site.typ` (CSS, JS, marca `/index.html`, categorias, `/book.pdf`, `/rss.xml`).
- [x] 2.3 Em `generate-site.ts`, emitir `#let base = "<derived>"` no topo de `site.typ`.
- [x] 2.4 Prefixar com `base` os links de `tags/*`, `posts/*` e `/book.pdf` gerados diretamente em `generate-site.ts`.

## 3. Prefixo nas saídas estáticas

- [x] 3.1 Em `static-outputs.ts`, prefixar `url` de cada entrada do `search-index.json` com o base path.

## 4. Prefixo no search.js

- [x] 4.1 Em `assets/js/search.js`, derivar o base path em runtime a partir de `document.currentScript.src` (removendo o sufixo `/assets/js/search.js`) e usá-lo no `fetch` do índice.

## 5. Verificação

- [x] 5.1 Rodar `bun run build` localmente e conferir que os links ficam na raiz (base vazio) e o site funciona no `serve`.
- [x] 5.2 Simular produção: build com `site.url` real e conferir que os caminhos em `dist/*.html`, `search-index.json` e `search.js` estão prefixados com `/typst-blog`.
- [x] 5.3 Validar `openspec validate` da mudança e, após deploy via CI, conferir CSS/JS/posts/tags/categorias/book.pdf/RSS/busca em produção.