# Didactic Book

## Why

O livro atual é um PDF A4 simples (capa, sumário, capítulos a partir dos posts). O usuário
quer transformá-lo num **livro didático**: com listas de figuras/tabelas/código, exercícios
por capítulo com gabarito no fim, seção de trabalhos em apêndice e referências. Este change
depende da **fundação de conteúdo** criada no `enhance-blog-site` (subpastas por tipo,
nomenclatura por grupo, `meta {type, group}`, `refs.bib` compartilhado).

## What Changes

- O livro passa a ser estruturado por **aulas** (grupos): um capítulo por aula, cujo
  heading é o título da lição. O agrupamento é feito em `book.typ` (Typst).
- **Listas** no início do livro: figuras, tabelas e código (`list-of-figures`,
  `list-of-tables`, `outline(target: figure.where(kind: "code"))`).
- **Exercícios** numerados em cada capítulo (aula); **soluções** em uma seção dedicada
  "Soluções" no fim do livro, a partir de posts de `solucao` (fonte única, com `body`),
  associados aos exercícios pela convenção de nomenclatura.
- **Apêndice de trabalhos**: cada `trabalho` vira um apêndice.
- **Referências** via `#bibliography("refs.bib")` nativo no PDF (mesmo `refs.bib` do site).
- Convenções de autoria: posts passam a usar `#figure` (com caption/kind) e `#exercise()`
  (auto-rotulado pelo filename).

## Capabilities

### New Capabilities
<!-- Nenhuma capability nova de especificação; reforços ficam nas existentes. -->

### Modified Capabilities
- `book-generation`: livro didático — estrutura por aulas, listas de figuras/tabelas/código,
  exercícios por capítulo, gabarito no fim, apêndice de trabalhos, referências.
- `post-authoring`: convenções de autoria para o livro — uso de `#figure` (caption/kind),
  exercícios `#exercise()` auto-rotulados, soluções como posts (`body` próprio) e citações
  `refs.bib`.

## Impact

- `templates/book.typ`: capa/rosto/sumário + listas + capítulos por aula + exercícios +
  gabarito + apêndice + referências.
- `scripts/generate-book.ts`: monta a estrutura por grupo/tipo (aulas como capítulos,
  soluções no fim, trabalhos em apêndice).
- `posts/`: migração (já na fundação) + enriquecimento com `#figure`, `exercises` e
  `solutions` por post.
- `refs.bib`: compartilhado com o site (mesmo arquivo).
- Depende de: `enhance-blog-site` (modelo de conteúdo, refs.bib).