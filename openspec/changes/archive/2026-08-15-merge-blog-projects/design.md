# Design — Merge Blog Projects

## Context

Dois protótipos de blog em Typst coexistem em `typst-blog/` (Python) e `typst-blog-js/`
(Deno/Bun). O Python é completo: `build.py` lê `posts/AAAA-MM-DD-slug.typ`, gera
`main.typ` e compila com `typst compile --features bundle,html --format bundle` para
produzir o HTML do site inteiro via export `bundle` do Typst. O JS é mais ambicioso:
metadados ricos por post (`title, date, author, slug, tags, excerpt`), templates com
layout de site (nav, hero, post-cards, tags) e livro PDF (capa, sumário, A5), além de
utilidades cross-runtime (Deno/Bun/Node). Porém `build.ts` importa `generate-site.ts`,
que **não existe**, então a geração do site nunca funcionou.

Este design consolida os dois num único projeto: renderização 100% em Typst (bundle
export para o site + compile para o livro PDF), build em TypeScript (Bun), layout
rico herdado do JS, e preview por arquivo no VS Code (Tinymist) igual ao fluxo do Python.

## Goals / Non-Goals

**Goals:**
- Fonte única de verdade por post, que renderiza sozinha no preview e alimenta site + livro.
- Site HTML inteiro gerado pelo Typst (bundle export), sem geração manual de HTML.
- Livro PDF em A4 gerado da mesma fonte dos posts.
- Build em TypeScript rodando em Bun.
- Layout do site (hero, cards, tags, nav/footer) e moldura do artigo consistentes com o
  preview e o PDF.
- Saída consolidada em `dist/`.

**Non-Goals:**
- Não gerar HTML por strings no TypeScript (a renderização fica no Typst).
- Não manter compatibilidade com os dois projetos antigos (serão substituídos).
- Não implementar CI/deploy no primeiro momento (pode ser follow-up).
- Não dar suporte a mais de um autor/tema no escopo inicial.

## Decisions

### 1. Renderização do site: bundle export do Typst (não HTML manual)
O site é gerado por `typst compile --features bundle,html --format bundle site.typ`.
`site.typ` usa `#document("pagina.html", ...)` para cada página (home + posts), como no
projeto Python. O `generate-site.ts` do JS deixa de existir.
**Alternativa considerada**: gerar HTML manualmente em TS (intenção original do JS).
Descartada: renderização do Typst garante fidelidade de fórmulas/código e fonte única.

### 2. Post autossuficiente via `#show`
Cada `posts/*.typ` define `#let meta = (...)`, o corpo como **texto solto**, e usa
`#show: rest => post-layout(meta, rest)`. Isso embrulha o conteúdo do arquivo.
- Abrindo direto no VS Code (Tinymist): `post-layout` estiliza o artigo → preview fiel
  (sem a moldura de página do site).
- Importado por `site.typ`/`book.typ` (`#import "posts/x.typ" as x`): o módulo emite o
  post renderizado; `site.typ` coloca `#x` na página e lê `x.meta` para cards/tags.
**Alternativa considerada**: corpo em `#let body = [...]`. Descartada: exige chamar o
template manualmente e dificulta preview completo igual ao site.

### 3. Slugs e datas
O slug é derivado do nome do arquivo (`AAAA-MM-DD-slug.typ`, convenção do Python), usado
para URL e identificador do post. A **data exibida e usada na ordenação vem de
`meta.date`** (fonte de verdade, decisão do usuário). O `build.ts` ordena por
`meta.date` e usa o prefixo do nome apenas para gerar o slug/identificador.

### 3b. Estratégia de preview no VS Code
O preview ao vivo do Tinymist renderiza em alvo `paged` (tipografado), não HTML — por
isso os `html.elem` são ignorados no preview ("elem was ignored during paged export").
- `.vscode/settings.json` define `tinymist.typstExtraArgs: ["--features", "html"]`,
  `tinymist.exportTarget: "paged"`, `tinymist.formatterMode: "typstfmt"`.
- `site.typ` gera um guard de preview: `#let is-preview = "x-preview" in sys.inputs`.
  Se ativo, renderiza uma **página tipografada com tudo** (título, lista de posts e cada
  post na íntegra, sem `html.elem` e sem `#document`), compatível com o preview paged.
  No build real o branch `else` gera o bundle HTML multi-página.
- O preview de um **post individual** funciona pelo design autossuficiente (corpo solto +
  `#show`), renderizando o artigo tipografado direto no arquivo do post.

### 4. Templates em três camadas
- `templates/post.typ` — `post-layout(meta, rest)`: moldura do artigo (título, data,
  autor, tags, corpo formatado). Usado no preview, no site e no livro.
- `templates/site.typ` — layout de página (nav, hero, footer) e helpers para a home
  (post-cards com excerpt/tags, link do PDF).
- `templates/book.typ` — capa, sumário, paginação A4, capítulos via `book-post`.
**Decisão**: o `post-layout` cuida do conteúdo; a moldura de página (nav/footer) fica só
no site. É isso que permite "preview = artigo estilizado, sem moldura".

### 5. Build em TypeScript (Bun)
`build.ts`:
1. Lê a config de `typst.toml` (título/subtítulo/autor de site e livro), com fallback
   para variáveis de ambiente (`SITE_TITLE`, `BOOK_TITLE`, etc.).
2. Lê `posts/*.typ`, extrai `meta` + corpo (reutiliza a lógica de `parse-posts.ts`).
3. Gera `site.typ` (importa cada post, monta home + páginas via `#document`).
4. Compila `site.typ` → bundle → `dist/`.
5. Gera `book.typ` (importa a mesma fonte) e compila → `dist/book.pdf` (A4).
6. Copia `assets/` → `dist/`.
`serve.ts` serve `dist/` para preview local. `lib.ts` é Bun-only (APIs nativas do Bun +
built-ins do Node) e traz `parseToml`/`loadConfig` para ler o `typst.toml`.

### 6. Saída em `dist/`
Consolidada: `dist/index.html`, `dist/posts/*.html`, `dist/book.pdf`, `dist/assets/`.

## Risks / Trade-offs

- [Bundle export é experimental (Typst v0.15+)] → Manter `typst --version` e pinar a
  versão em `package.json`/README; revisar changelog ao atualizar.
- [Preview não mostra a moldura completa (nav/footer)] → Aceito de forma explícita; o
  artigo em si é idêntico. Documentar no README, como o projeto Python faz.
- [`#show` em módulo importado emite conteúdo] → `site.typ`/`book.typ` usam esse output
  como o post renderizado; não há dupla renderização.
- [Parsing de meta por string é frágil] → Reusar/fortalecer o parser do `parse-posts.ts`;
  posts inválidos são ignorados com aviso (como hoje).

## Migration Plan

- Remover `typst-blog/` e `typst-blog-js/`; criar o novo projeto em `typst-blog-v2/`.
- Migrar os posts existentes para o novo formato (`meta` + corpo solto + `#show`).
- Validar com `bun run build` e preview no VS Code (Tinymist).

## Open Questions

- ~~Nome da pasta raiz do novo projeto~~ → decidido: `typst-blog-v2`.
- ~~Se `meta.date` ou o prefixo do nome do arquivo é a fonte de verdade da data~~ →
  decidido: `meta.date` (prefixo do nome só para slug/identificador).