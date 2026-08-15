## ADDED Requirements

### Requirement: Geração de index de busca, RSS e reading time

O build SHALL agrupar e ordenar posts por `(group, tipo, número)`, gerar
`dist/search-index.json` (título, slug, data, tags, excerpt, url), gerar `dist/rss.xml`
e estimar o reading time de cada post a partir do corpo.

#### Scenario: Index de busca emitido
- **WHEN** o build executa com posts válidos
- **THEN** `dist/search-index.json` é gerado com uma entrada por post

#### Scenario: Reading time calculado
- **WHEN** o build processa um post com corpo
- **THEN** o reading time estimado (palavras ÷ wpm) é exposto no card e na página do post

## MODIFIED Requirements

### Requirement: Build e preview em TypeScript (Bun)

A config do blog SHALL ser lida apenas de `typst.toml` (padrão do Typst), sem fallback
para variáveis de ambiente.

#### Scenario: Config apenas via typst.toml
- **WHEN** `typst.toml` define título/subtítulo/autor/url de site e livro
- **THEN** o build usa esses valores ao gerar `site.typ` e `book.typ`, sem ler variáveis de ambiente

#### Scenario: Live-reload no modo dev
- **WHEN** `bun run dev` está ativo e um arquivo monitorado (`posts`, `templates`, `assets`, `scripts`, `typst.toml`, `refs.bib`) muda
- **THEN** o build re-executa e o navegador recarrega a página automaticamente via WebSocket
- **AND** `bun run serve` (sem `--watch`) não dispara rebuild nem live-reload