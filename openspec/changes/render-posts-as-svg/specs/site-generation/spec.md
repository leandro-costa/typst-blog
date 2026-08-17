# Site Generation Specification (Delta)

## MODIFIED Requirements

### Requirement: Geração do site em Typst

O site SHALL ser gerado inteiramente pelo Typst via bundle export
(`--features bundle,html --format bundle`), sem geração manual de HTML no build. O
`site.typ` SHALL gerar a home e uma página por post usando `#document(...)`. A home SHALL
exibir hero, lista de post-cards com `title`, `date`, `author`, `excerpt` e `tags`, além
de um link para o PDF do livro. Cada página de post SHALL incluir nav/footer e o post
exibido como um `<object>` apontando para `posts/<slug>.svg`, com o corpo tipográfico
renderizado pelo SVG (não como HTML semântico). A saída SHALL ir para `dist/`.

#### Scenario: Build gera site completo
- **WHEN** o build executa `typst compile` sobre `site.typ`
- **THEN** `dist/index.html` e `dist/posts/<slug>.html` são gerados
- **AND** a home mostra cards com excerpt e tags, e link para `book.pdf`

#### Scenario: Post é incorporado como SVG
- **WHEN** o build gera uma página de post
- **THEN** a página embute o corpo do post como um `<object data="posts/<slug>.svg">`,
  acompanhado de `dist/posts/<slug>.svg`

#### Scenario: CSS e assets são copiados
- **WHEN** o build termina a compilação
- **THEN** os assets de `assets/` (incluindo CSS) são copiados para `dist/`