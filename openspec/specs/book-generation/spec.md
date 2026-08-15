# Book Generation Specification

## Purpose

Gerar um livro em PDF (A4) a partir da mesma fonte dos posts usados no site.

## Requirements

### Requirement: Geração do livro PDF em A4

O livro SHALL ser gerado a partir da mesma fonte dos posts via `book.typ` e compilado
para PDF em papel A4. O livro SHALL incluir capa, sumário com os posts e cada post como
capítulo. O PDF SHALL ser gravado em `dist/book.pdf`.

#### Scenario: Livro compila em A4 com capa e sumário
- **WHEN** o build compila `book.typ`
- **THEN** `dist/book.pdf` é gerado em papel A4
- **AND** o PDF contém capa, sumário listando os posts e o conteúdo de cada post