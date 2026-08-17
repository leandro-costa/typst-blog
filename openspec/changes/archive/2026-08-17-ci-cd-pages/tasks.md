## 1. Workflow CI/CD

- [x] 1.1 Criar `.github/workflows/build.yml` na raiz do repositório (`typst-blog-v2`), com eventos `push: [main]` e `pull_request`.
- [x] 1.2 Definir `permissions: contents: read` no nível do job e `concurrency` group `pages-${{ github.workflow }}-${{ github.ref }}` com `cancel-in-progress: true`.
- [x] 1.3 Job `build`: `actions/checkout@v4`, `oven-sh/setup-bun@v2`, `typst-community/setup-typst@v4` com `version: 0.15.0`.
- [x] 1.4 Job `build`: executar `bun install` e `bun run build`.

## 2. Deploy em GitHub Pages

- [x] 2.1 Job `build`: ao concluir, usar `actions/upload-pages-artifact@v3` com `path: dist`.
- [x] 2.2 Job `deploy`: `needs: build`, `if: github.ref == 'refs/heads/main'`, `runs-on: ubuntu-latest`.
- [x] 2.3 Job `deploy`: permissões `pages: write` e `id-token: write`, `environment: github-pages` com `url` do deployment.
- [x] 2.4 Job `deploy`: usar `actions/deploy-pages@v4` e expor o `page_url`.

## 3. Configuração do repositório

- [x] 3.1 Adicionar `dist/` ao `.gitignore` (raiz do repo `typst-blog-v2`).
- [x] 3.2 Remover `dist/` do versionamento (`git rm -r --cached dist`) para não manter build versionado.
- [x] 3.3 Documentar no README que o GitHub Pages deve usar "Deploy from the GitHub Actions" (source "GitHub Actions") e que o build antigo de `dist/` não é mais navegado ao repo.