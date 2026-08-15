## Why

O blog é um site estático (HTML) + livro PDF gerado localmente por build em Bun/Typst, mas o `dist/` não possui deploy automatizado: precisa rodar o build na mão ("works on my machine") e não há validação via CI antes de merge. Publicar em GitHub Pages automaticamente dá publição confiável e feedback imediato em PRs.

## What Changes

- Adiciona workflow GitHub Actions `build.yml` com dois triggers:
  - `push` na `main`: build + deploy do site em GitHub Pages.
  - `pull_request`: build apenas (validação).
- Build roda `bun install` + `bun run build`, que gera `dist/` (site HTML + `book.pdf` + assets + `search-index.json` + `rss.xml`).
- Deploy usa a action oficial `actions/deploy-pages@v4` via artefato (`actions/upload-pages-artifact@v3`), com Pages source "GitHub Actions".
- Adiciona `dist/` ao `.gitignore` — o artefato de deploy é sempre publica partir de build fresco do CI (não se versiona `dist/`).
- Ambiente `github-pages` com permissões `pages: write` e `id-token: write`.

## Capabilities

### New Capabilities
- `ci-cd`: Automação de build e deploy via GitHub Actions — build em push para `main` e PRs, deploy em Pages somente na `main`.

### Modified Capabilities
_(nenhum requirement de spec existente é alterado)_

## Impact

- Repo: `.github/workflows/build.yml` (novo).
- Build: `package.json` (`bun install`/`bun run build`) e requirements de ambiente — Bun e Typst **0.15.0** (features `bundle,html`).
- CI/CD: GitHub Actions + GitHub Pages; sem `dist/` versionado no git.
- `typst-blog-v2/` passa a ser a raiz do repo; paths de build relativos a essa raiz.