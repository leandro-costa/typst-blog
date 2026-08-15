## ADDED Requirements

### Requirement: Livro didático estruturado por aulas

O livro SHALL ser estruturado por aulas (grupos): um capítulo por grupo (`aula-01`),
composto pela lição e pelos exercícios do grupo, com o heading do capítulo sendo o título
da lição. O agrupamento SHALL ocorrer em `book.typ` (Typst). Os trabalhos SHALL ficar num
apêndice no fim do livro.

#### Scenario: Capítulo por aula
- **WHEN** o build compila o livro
- **THEN** cada grupo (ex.: `aula-01`) gera um capítulo com lição e exercícios, cujo
  heading é o título da lição

### Requirement: Listas de figuras, tabelas e código

O livro SHALL incluir, após o sumário, listas de figuras, de tabelas e de código,
derivadas dos `figure` (com `caption` e `kind`) usados nos posts.

#### Scenario: Listas no início do livro
- **WHEN** o livro é compilado e há figuras/tabelas/código nos posts
- **THEN** as listas respectivas aparecem antes dos capítulos

### Requirement: Seção de Soluções no fim

Cada capítulo SHALL incluir exercícios numerados. O livro SHALL ter uma seção de
Soluções no fim que renderiza os posts de `solucao` (fonte única, com `body` próprio),
associados aos exercícios pela convenção de nomenclatura (mesmo `group`/`number`). Nem
todo exercício precisa ter solução. As referências cruzadas exercício↔solução SHALL ser
montadas por `book.typ` a partir de ids derivados dos nomes dos arquivos (posts de
solução não contêm `@ref` no fonte).

#### Scenario: Seção de Soluções no fim do livro
- **WHEN** existem posts de `solucao` e exercícios
- **THEN** a seção de Soluções aparece no fim, renderizando os corpos das soluções e
  referenciando os exercícios dos capítulos
- **AND** os links "ver solução/voltar ao exercício" são montados por `book.typ`, sem `@ref`
  escrito nos posts

### Requirement: Referências no livro

O livro SHALL renderizar as referências de `refs.bib` via `#bibliography` (alvo PDF),
com citações `@chave` resolvidas no corpo.

#### Scenario: Referências resolvidas no PDF
- **WHEN** posts citam `@chave` de `refs.bib`
- **THEN** as referências aparecem no fim do livro