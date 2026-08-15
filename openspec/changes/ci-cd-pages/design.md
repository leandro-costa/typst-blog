## Context

O projeto é um blog estático (HTML) + livro PDF, tudo renderizado em Typst, com build em TypeScript rodando em Bun (`bun run build` → `scripts/build.ts` gera `dist/` completo). Hoje o build é local e o `dist/` está versionado no git. Este change automatiza build + deploy em GitHub Pages via GI/CD.

`typst-blog-v2/` passa a ser a raiz do repositório; qualidades: Bun + Typst **0.15.0** (features `bundle,html`).

## Goals / Non-Goals

**Goals:**
- Workflow único que faz build em `push` para `main` e PRs.
- Deploy em GitHub Pages apenas na `main`, via actions oficiais.
- Publicar sempre build fresco; `dist/` fora do versionamento.

**Non-Goals:**
- Não usar branch `gh-pages` (deploy via API de Pages — Pages source "GitHub Actions").
- Sem cache de dependências avançado (pode virar follow-up).
- Sem notificações de falha ou badges (fora do escopo).
- Não altera a semântica do build em si (só o orquestra no CI).

## Decisions

O workflow será um arquivo único `.github/workflows/build.yml` com um job `build` (sempre) e um job `deploy` (só na main).

**Decisão 1 — Deploy via actions oficiais** (`actions/upload-pages-artifact@v3` + `actions/deploy-pages@v4`).
- **Por quê:** é a via mantida pelo GitHub (Pages actions), sem depender de token de terceiros, e suporta Pages source = "GitHub Actions". Zero secrets adicionais (usa `id-token` + `pages: write`).
- **Alternativas:** `peaceiris/actions-gh-pages` → cria branch `gh-pages` real (abordagem B, descartada para opção A); push manual → frágil.

**—— Concurrency cancel-in-progress**, com chave por ref, para evitar deploys concorrentes encavalados.

**Setup de ferramentas:**
- `oven-sh/setup-bun@v2` (lang Bun para o build).
- `typst-community/setup-typst@v4` com `version: 0.15.0` (features `bundle,html` exigem 0.15+).

**Trigger:**
- `push: [main]` → ambas as etapas.
- `pull_request` → só `build`.
- O deploy é condicionado por `if: github.ref == 'refs/heads/main'` e `needs: build`.

## Risks / Trade-offs

- [Pages source precisa estar configurado como "GitHub Actions" no repositório] → covered na etapa de configuração do Pages (uma vez via settings); sem isso o `deploy-pages` falha.
- [Tipst 0.15 é experimental (`bundle,html`)] → fixado no workflow via `setup-typst` pin, e o build é validado em PRs antes da merge.
- [Deploy concorrente em pushes rápidos] → mitigado com `concurrency` cancelando execuções suplandadas.
- [sem `dist/` versionado, o checkout precisa do valor completo para build] → `actions/checkout@v4` com checkout padrão (completo) no job de build.