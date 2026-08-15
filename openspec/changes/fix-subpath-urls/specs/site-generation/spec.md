## MODIFIED Requirements

### Requirement: Geração do site em Typst

O site SHALL ser gerado inteiramente pelo Typst via bundle export
(`--features bundle,html --format bundle`), sem geração manual de HTML no build. O
`site.typ` SHALL gerar a home e uma página por post usando `#document(...)`. A home SHALL
exibir hero, lista de post-cards com `title`, `date`, `author`, `excerpt` e `tags`, além
de um link para o PDF do livro. Cada página de post SHALL incluir nav/footer e o post
renderizado a partir do módulo importado. A saída SHALL ir para `dist/`. Os links internos
e assets (CSS, JS, posts, tags, categorias, `book.pdf`, `rss.xml`, marca) SHALL usar o base
path configurado em vez de caminhos absolutos de raiz.

#### Scenario: Build gera site completo
- **WHEN** o build executa `typst compile` sobre `site.typ`
- **THEN** `dist/index.html` e `dist/posts/<slug>.html` são gerados
- **AND** a home mostra cards com excerpt e tags, e link para `book.pdf`

#### Scenario: CSS e assets usam o base path
- **WHEN** o build termina a compilação com base path `/typst-blog`
- **THEN** os assets de `assets/` (incluindo CSS) são copiados para `dist/`
- **AND** os `href`/`src` no HTML apontam para `/typst-blog/assets/...`

#### Scenario: Links internos usam o base path
- **WHEN** o site é compilado com base path `/typst-blog`
- **THEN** os links de posts, tags, categorias, `book.pdf` e `rss.xml` são prefixados com `/typst-blog`