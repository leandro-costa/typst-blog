# Site Base Path Specification

## Purpose

Derivar um base path a partir de `site.url` e propagá-lo a todas as partes do site que
emitem links e assets, garantindo que o site funcione sob um subcaminho do domínio.

## Requirements

### Requirement: Base path configurável

O site SHALL derivar um base path a partir de `site.url` no `typst.toml`. O base path SHALL
ser o caminho (path) da URL (ex.: `https://leandro-costa.github.io/typst-blog` → `/typst-blog`).
Quando a URL não tiver caminho (ex.: domínio raiz ou localhost), o base path SHALL ser vazio.
O build SHALL injetar esse base path em todas as partes que emitem links e assets do site
(HTML via `site.typ`, `search-index.json`, `search.js` e RSS).

#### Scenario: URL com subcaminho deriva base path não vazio
- **WHEN** `site.url` é `https://leandro-costa.github.io/typst-blog`
- **THEN** o base path derivado é `/typst-blog`

#### Scenario: URL de raiz deriva base path vazio
- **WHEN** `site.url` é `https://example.com` (sem caminho)
- **THEN** o base path derivado é vazio e os links permanecem na raiz

#### Scenario: Base path propagado para o site
- **WHEN** o build gera o site com base path `/typst-blog`
- **THEN** todos os links e assets internos são prefixados com `/typst-blog`
