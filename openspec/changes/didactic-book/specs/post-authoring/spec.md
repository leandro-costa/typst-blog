## ADDED Requirements

### Requirement: Convenções de autoria para o livro didático

Os posts SHALL usar `#figure` com `caption` e `kind` (`image`, `table`, `code`) para
alimentar as listas do livro. Uma **solução SHALL ser um post com `body`** próprio
(`solucoes/aula-01-solu-01.typ`), fonte única de verdade — não um bloco capturado dentro
de outro post. A relação exercício↔solução SHALL ser derivada da convenção de
nomenclatura (mesmo `group` e `number`, ex.: `aula-01-exer-01` ↔ `aula-01-solu-01`), e nem
todo exercício precisa ter solução. Exercícios SHALL ser marcados com um helper
`#exercise()` que gera a própria label e o número a partir de `meta.slug` (id do filename,
ex.: `aula-01-exer-01` → `ex-aula-01-1`), com um contador local por capítulo; o preview
isolado numera igual ao livro. O post SHALL declarar `slug` na `meta`, e o build SHALL
validar que `meta.slug` coincide com o nome do arquivo. Citações SHALL usar `@chave` de
`refs.bib`.

#### Scenario: Figura alimenta a lista
- **WHEN** um post usa `#figure(caption: ..., kind: "code")`
- **THEN** a entrada aparece na lista de código do livro

#### Scenario: Solução como post com corpo
- **WHEN** um post `solucoes/aula-01-solu-01.typ` define `body`
- **THEN** o conteúdo é a fonte única e aparece na seção de Soluções do livro (sem
  duplicação e sem bloco `#let solutions` capturado)

#### Scenario: Relação exercício↔solução pela nomenclatura
- **WHEN** `aula-01-exer-01` e `aula-01-solu-01` existem
- **THEN** `book.typ` associa a solução ao exercício pelo mesmo `group`/`number`
- **AND** se não há `solu` correspondente, o exercício segue sem solução

#### Scenario: Exercício auto-rotulado e referenciável
- **WHEN** um post usa `#exercise()` (id de `meta.slug`, ex.: `aula-01-exer-01`)
- **THEN** o exercício recebe uma label local (ex.: `ex-aula-01-1`) e um número por capítulo
- **AND** o preview isolado numera igual ao livro, e o build valida que `meta.slug` coincide
  com o nome do arquivo