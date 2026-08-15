## ADDED Requirements

### Requirement: Formato do post autossuficiente

Cada post em `posts/*.typ` SHALL definir metadados via `#let meta = (...)` e o corpo como
texto solto, envolvido por `#show: rest => post-layout(meta, rest)`. A `meta` SHALL
suportar `title`, `date`, `slug`, `author`, `tags` (lista) e `excerpt`. O arquivo SHALL
renderizar sozinho, produzindo o artigo estilizado quando compilado diretamente.

#### Scenario: Post renderiza sozinho no preview
- **WHEN** um arquivo `posts/x.typ` com `meta` e corpo solto é compilado diretamente (ex.: Tinymist)
- **THEN** o artigo é renderizado estilizado com título, data, autor, tags e corpo formatado
- **AND** não há nav/footer de página (moldura do site)

#### Scenario: Post é importado por site e livro
- **WHEN** `site.typ` ou `book.typ` importa `posts/x.typ` como módulo
- **THEN** o módulo emite o post renderizado sem dupla renderização
- **AND** `meta` é acessível para montar cards, tags e capítulos

#### Scenario: Post inválido é ignorado
- **WHEN** um arquivo em `posts/` não define `meta` válida
- **THEN** o build o ignora com um aviso e continua com os demais