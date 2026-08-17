# Build Tooling Specification

## Purpose

Fornecer automação em TypeScript (Bun) para gerar os artefatos (site e livro), lendo a
config do `typst.toml`, e servir o site localmente em preview.

## Requirements

### Requirement: Build e preview em TypeScript (Bun)

O projeto SHALL fornecer um build em TypeScript que roda em Bun, responsável por:
ler `posts/`, extrair metadados, gerar `site.typ` e `book.typ`, compilar ambos e copiar
assets para `dist/`. A config do blog SHALL ser lida de `typst.toml` (padrão do Typst),
sem fallback para variáveis de ambiente. SHALL fornecer um `serve` de preview local de
`dist/`. A saída do build SHALL ser `dist/`. O projeto SHALL declarar as tarefas `build`
e `serve` em `package.json`. O build SHALL derivar o base path de `site.url` e passá-lo a
todas as partes que emitem links (site, busca e saídas estáticas).

#### Scenario: Build completo via Bun
- **WHEN** `bun run build` é executado com posts válidos
- **THEN** `site.typ` e `book.typ` são gerados
- **AND** `dist/` contém o site HTML, `book.pdf` e os assets

#### Scenario: Config via typst.toml
- **WHEN** `typst.toml` define título/subtítulo/autor/url de site e livro
- **THEN** o build usa esses valores ao gerar `site.typ` e `book.typ`
- **AND** o base path é derivado de `site.url` e aplicado aos links

#### Scenario: Live-reload no modo dev
- **WHEN** `bun run dev` está ativo e um arquivo monitorado (`posts`, `templates`, `assets`, `scripts`, `typst.toml`, `refs.bib`) muda
- **THEN** o build re-executa e o navegador recarrega a página automaticamente via WebSocket
- **AND** `bun run serve` (sem `--watch`) não dispara rebuild nem live-reload

#### Scenario: Preview local
- **WHEN** `bun run serve` é executado após o build
- **THEN** um servidor local serve `dist/` em uma porta configurável

#### Scenario: Preview local sem prefixo
- **WHEN** o build local é executado com `SITE_BASE=""` (raiz)
- **THEN** os links permanecem na raiz (base path vazio) e o site funciona no `serve` em `/`

### Requirement: Geração de index de busca, RSS e reading time

O build SHALL agrupar e ordenar posts por `(group, tipo, número)`, gerar
`dist/search-index.json` (título, slug, data, tags, excerpt, url), gerar `dist/rss.xml`
e estimar o reading time de cada post a partir do corpo. As URLs emitidas no
`search-index.json` SHALL usar o base path configurado. O RSS SHALL usar `site.url`
como URL absoluta de base (já incluindo o subcaminho).

#### Scenario: Index de busca emitido
- **WHEN** o build executa com posts válidos e base path `/typst-blog`
- **THEN** `dist/search-index.json` é gerado com uma entrada por post
- **AND** a `url` de cada entrada é `/typst-blog/posts/<slug>.html`

#### Scenario: Reading time calculado
- **WHEN** o build processa um post com corpo
- **THEN** o reading time estimado (palavras ÷ wpm) é exposto no card e na página do post

### Requirement: Verificação das dependências PlantUML no build
O script de build MUST verificar a presença das dependências da feature PlantUML (`java` para o kernel IJava e `graphviz` quando o notebook usa diagramas que o exigem) antes da compilação, abortando com mensagem de erro clara quando ausentes.

#### Scenario: Dependência ausente
- **WHEN** o build executa e `java` ou `graphviz` (necessário) não estão disponíveis
- **THEN** o build aborta com uma mensagem identificando qual dependência instalar

#### Scenario: Dependências presentes
- **WHEN** o build executa e `java` e `graphviz` estão disponíveis
- **THEN** o build prossegue normalmente