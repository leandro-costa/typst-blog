## Why

O site publicado em GitHub Pages (`https://leandro-costa.github.io/typst-blog/`) vive em
um **subcaminho**, mas todos os links gerados são **caminhos absolutos de raiz**
(`/assets/...`, `/index.html`, `/posts/...`, `/book.pdf`, `/rss.xml`). Eles resolvem contra
a raiz do domínio (`https://leandro-costa.github.io/...`), ignorando o `/typst-blog/`, então
o CSS, o JS de busca e os links internos retornam 404 em produção.

## What Changes

- Introduzir um **base path** configurável que prefixa todos os links internos e assets.
- `templates/site.typ`: prefixar CSS, JS, marca, categorias, `book.pdf` e `rss.xml`.
- `generate-site.ts`: prefixar links de `tags/*`, `posts/*` e `book.pdf` emitidos no `site.typ`.
- `static-outputs.ts`: prefixar `url` do `search-index.json` (RSS já usa a URL inteira).
- `assets/js/search.js`: prefixar `fetch("/search-index.json")` (caminhos já vêm do índice).
- `typst.toml`: preencher `site.url` real (`https://leandro-costa.github.io/typst-blog`),
  usado como fonte de verdade para derivar o base path.
- Build local permanece idêntico: sem prefixo quando o site roda na raiz (`serve`).

## Capabilities

### New Capabilities
- `site-base-path`: centraliza a resolução do prefixo de caminho (base path) a partir da
  configuração, aplicada a todos os links e assets do site estático.

### Modified Capabilities
- `site-generation`: os links e assets do site passam a usar o base path em vez de caminhos
  absolutos de raiz.
- `site-search`: o `search.js` e o `search-index.json` passam a referenciar o índice e as
  URLs com o base path.
- `build-tooling`: a configuração passa a expor e derivar o base path, e as saídas estáticas
  (RSS/index) passam a usar o prefixo.

## Impact

- `templates/site.typ`
- `scripts/generate-site.ts`
- `scripts/static-outputs.ts`
- `assets/js/search.js`
- `typst.toml` (`site.url` de `https://example.org` para a URL real)
- Saída gerada: `dist/*.html`, `dist/assets/*`, `dist/search-index.json`, `dist/rss.xml`
- Não afeta o livro PDF (`book.typ`) nem a autoria de posts.