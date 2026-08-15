## ADDED Requirements

### Requirement: Build e preview em TypeScript (Bun)

O projeto SHALL fornecer um build em TypeScript que roda em Bun, responsável por:
ler `posts/`, extrair metadados, gerar `site.typ` e `book.typ`, compilar ambos e copiar
assets para `dist/`. A config do blog SHALL ser lida de `typst.toml` (padrão do Typst),
com fallback para variáveis de ambiente. SHALL fornecer um `serve` de preview local de
`dist/`. A saída do build SHALL ser `dist/`. O projeto SHALL declarar as tarefas `build`
e `serve` em `package.json`.

#### Scenario: Build completo via Bun
- **WHEN** `bun run build` é executado com posts válidos
- **THEN** `site.typ` e `book.typ` são gerados
- **AND** `dist/` contém o site HTML, `book.pdf` e os assets

#### Scenario: Config via typst.toml
- **WHEN** `typst.toml` define título/subtítulo/autor de site e livro
- **THEN** o build usa esses valores ao gerar `site.typ` e `book.typ`
- **AND** uma variável de ambiente (ex.: `SITE_TITLE`) tem prioridade sobre o arquivo

#### Scenario: Preview local
- **WHEN** `bun run serve` é executado após o build
- **THEN** um servidor local serve `dist/` em uma porta configurável