# Merge Blog Projects

## Why

Dois protótipos de blog em Typst evoluíram em paralelo e se dividem os pontos fortes:
`typst-blog` (Python) é completo e usa o bundle export do Typst para renderizar o site
inteiro em HTML, mas tem post simples e layout básico; `typst-blog-js` (Deno/Bun) tem
layout rico (nav, hero, post-cards, tags), gera PDF de livro e metadados ricos por post,
mas está incompleto (`generate-site.ts` não existe) e a geração do site nunca foi ligada.
Queremos um único projeto que junte o melhor dos dois.

## What Changes

- Cria um novo projeto unificado que renderiza **tudo em Typst** (site HTML via bundle
  export + livro PDF), com ferramenta de build em **TypeScript (Bun)**.
- **BREAKING**: Substitui os dois projetos existentes (`typst-blog/` e `typst-blog-js/`)
  por uma única estrutura nova.
- Layout do site herdado do projeto JS: nav, hero, post-cards com excerpt, tags, botão de
  download do livro PDF, footer.
- Livro em **A4** (capa, sumário, capítulos), gerado a partir da mesma fonte dos posts.
- Post autossuficiente (corpo como texto solto capturado por `#show`), de modo que o
  preview do Tinymist no VS Code mostra o **artigo estilizado** igual ao site e ao PDF
  (sem a moldura de página do site).
- Preview ao vivo no VS Code (Tinymist) por arquivo de post, no mesmo fluxo do projeto
  Python.
- Saída de build em `dist/`.

## Capabilities

### New Capabilities
- `post-authoring`: formato do arquivo de post (metadados ricos + corpo via `#show`),
  que renderiza sozinho no preview e é importado pelo site e pelo livro.
- `site-generation`: geração do site HTML inteiramente em Typst via bundle export
  (home com hero/cards/tags, páginas de post, nav/footer), a partir de `site.typ`.
- `book-generation`: geração do livro PDF em A4 (capa, sumário, capítulos) a partir dos
  mesmos posts, via `book.typ`.
- `build-tooling`: build em TypeScript (Bun) que lê `typst.toml`, lê posts, gera
  `site.typ` e `book.typ`, compila ambos e copia assets para `dist/`.

### Modified Capabilities
<!-- Nenhuma spec existente é modificada. -->

## Impact

- Remove/reorganiza `typst-blog/` e `typst-blog-js/` num novo projeto unificado.
- Depende do Typst v0.15+ (bundle export experimental) e do runtime Bun.
- Scripts: `build.ts` (gera e compila site + livro), `serve.ts` (preview local).
- Templates: `post.typ`, `site.typ`, `book.typ`.
- Estrutura de saída: `dist/` (HTML do site + `book.pdf` + assets).