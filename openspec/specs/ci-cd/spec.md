# ci-cd Specification

## Purpose

TBD

## Requirements

### Requirement: Workflow trigger em push para main
O workflow de CI/CD SHALL ser disparado em `push` para a branch `main`, executando build e deploy.

#### Scenario: Push na main
- **WHEN** houver um `push` para a branch `main`
- **THEN** o workflow executa o build do site e publica a saída em GitHub Pages

#### Scenario: Push em outra branch
- **WHEN** houver um `push` para uma branch diferente de `main`
- **THEN** o workflow não é disparado

### Requirement: Workflow disparado em pull request
O workflow SHALL ser disparado para `pull_request`, executando apenas a etapa de build (validação).

#### Scenario: Pull request aberta
- **WHEN** uma pull request é aberta ou atualizada contra `main`
- **THEN** o workflow executa o build e valida que o site e o livro compilam sem erro

#### Scenario: PR sem deploy
- **WHEN** uma pull request dispara o workflow
- **THEN** nenhuma publicação é feita em GitHub Pages

### Requirement: Build de site estático e livro PDF
O workflow SHALL rodar o build do projeto — `bun install` seguido de `bun run build` — gerando `dist/` completo (HTML do site, `book.pdf`, assets, `search-index.json` e `rss.xml`).

#### Scenario: Build de sucesso
- **WHEN** o build é executado com Bun e Typst 0.15.0 instalados
- **THEN** o passo `bun run build` completa e produz `dist/` com todos os artefatos

#### Scenario: Erro de compilação
- **WHEN** o build falha (ex.: erro de Typst ou Typo)
- **THEN** o workflow falha e o deploy não acontece

### Requirement: Deploy em GitHub Pages na main
O workflow SHALL publicar `dist/` em GitHub Pages usando as actions `actions/upload-pages-artifact@v3` e `actions/deploy-pages@v4`, apenas no job disparado por `push` na `main`.

#### Scenario: Deploy bem-sucedido na main
- **WHEN** o job de build conclui em `main`
- **THEN** o artefato `dist/` é enviado e o `actions/deploy-pages` publica o site em GitHub Pages

#### Scenario: Permissões de Pages
- **WHEN** o job de deploy roda
- **THEN** ele possui permissões `pages: write` e `id-token: write` e usa o ambiente `github-pages`

### Requirement: dist não versionado
O diretório `dist/` SHALL estar no `.gitignore` e não ser rastreado pelo git; o artefato publicado SHALL sempre vir do build do CI.

#### Scenario: Alterar fonte e rebuildar
- **WHEN** código-fonte é alterado e mergeado na `main`
- **THEN** o CI rebuilda `dist/` a partir do build e publica o resultado fresco

#### Scenario: dist ausente no versionamento
- **WHEN** `dist/` está listado em `.gitignore`
- **THEN** ele não aparece em commits e não é carregado no repositório
