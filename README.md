# Typst Blog

Blog estático + livro PDF, **tudo renderizado em Typst**, com build em TypeScript
(roda em **Bun**).

## Estrutura

```
typst-blog-v2/
├── posts/               ← um arquivo .typ por post (meta + corpo solto)
├── templates/
│   ├── post.typ         ← moldura do artigo (preview + site + livro)
│   ├── site.typ         ← layout da página (nav, hero, footer, cards)
│   └── book.typ         ← capa, sumário, livro em A4
├── scripts/             ← build/serve em TypeScript
├── assets/              ← CSS, imagens, fontes
├── site.typ             ← GERADO pelo build (não editar)
├── book.typ             ← GERADO pelo build (não editar)
└── dist/                ← saída do build (HTML + book.pdf + assets)
```

## Requisitos

- **Typst v0.15+** (para o export `bundle` experimental)
- **Bun** (para o build)

```
typst --version   # precisa ser 0.15+
bun --version
```

## Como escrever um post

Crie `posts/AAAA-MM-DD-slug.typ`. A data exibida e a ordenação vêm de `meta.date`;
o `slug` da URL vem do nome do arquivo.

```typ
#import "../templates/post.typ": post-layout

#let meta = (
  title:  "Título do post",
  date:   "2026-08-15",
  author: "Seu Nome",
  tags:   ("typst", "blog"),
  excerpt:"Resumo que aparece no card da home",
)

// Envolve todo o conteúdo abaixo na moldura do artigo
#show: rest => post-layout(meta, rest)

= #meta.title

Parágrafos, fórmulas, código... o que quiser em Typst.
```

## Build e preview local

```bash
bun run build
bun run serve        # sirve dist/ em http://localhost:8080
```

A saída fica em `dist/`:

- `dist/index.html` — home com hero e cards (excerpt + tags)
- `dist/posts/*.html` — página de cada post
- `dist/book.pdf` — livro em A4 (capa, sumário, capítulos)
- `dist/assets/` — CSS e demais assets

## Configuração (`typst.toml`)

O build lê os metadados de `typst.toml` (padrão do Typst). Variáveis de ambiente
têm prioridade sobre o arquivo (ex.: `SITE_TITLE="..." bun run build`).

```toml
[site]
title = "Typst Blog"
subtitle = "Blog + livro, tudo em Typst"

[book]
title = "Posts em Livro"
subtitle = "Coletânea de posts"
author = "Autor"
```

## Preview no VS Code (Tinymist)

O preview ao vivo do Tinymist renderiza em modo `paged` (tipografado), não HTML.
Por isso, cada arquivo mostra uma versão tipografada — sem `html.elem` no preview:

1. **Post individual**: abra `posts/x.typ`. O `#show` renderiza o **artigo estilizado**
   (título, data, autor, tags, corpo) tipografado, igual ao livro/PDF. É o modo principal
   para escrever.
2. **Bundle (`site.typ`)**: o guard `x-preview` (input passado pelo VS Code/Tinymist)
   renderiza uma **página tipografada com tudo** — título, lista de posts e cada post na
   íntegra — para você conferir todo o conteúdo no preview. O `build` gera o site final
   em HTML multi-página.

O `.vscode/settings.json` configura `tinymist.typstExtraArgs: ["--features", "html"]` e
`tinymist.exportTarget: "paged"` (alinhado ao modo de preview).

## Publicando

### GitHub Pages (automático)

O repositório usa um workflow GitHub Actions (`.github/workflows/build.yml`) que faz o
build em `push` para `main` e em pull requests (validação). Somente na `main` ele faz o
deploy em GitHub Pages via as actions oficiais `actions/upload-pages-artifact` +
`actions/deploy-pages`.

- No GitHub, em **Settings → Pages**, escolha **Source = "GitHub Actions"** (deploy
  "from the GitHub Actions"). Sem isso, o `actions/deploy-pages` falha.
- `dist/` **não é versionado** no repositório: o site publicado é sempre um build fresco
  gerado pelo CI, não o conteúdo navegado antigo.

### Alternativas estáticas

`dist/` é um site estático puro, então também serve para Netlify, Vercel ou qualquer
servidor estático. Os links usam caminhos absolutos (`/index.html`, `/assets/...`,
`/book.pdf`), então publicam melhor em domínio próprio ou raiz.

## Nota sobre estabilidade

O export `bundle` do Typst ainda é **experimental** (v0.15+). Para um blog pessoal é
uma boa pedida; apenas confira o changelog do Typst ao atualizar a versão.