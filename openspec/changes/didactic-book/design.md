# Design — Didactic Book

## Context

O livro é compilado de `book.typ` para PDF A4. Hoje: capa, rosto, sumário e capítulos
(um por post). A fundação do `enhance-blog-site` introduz subpastas por tipo
(`aulas|exercicios|solucoes|trabalhos`), nomenclatura com grupo (`aula-01-*`), `meta
{type, group}` e `refs.bib` compartilhado. Este design transforma o livro num material
didático estruturado por aulas.

## Goals / Non-Goals

**Goals:**
- Estrutura por aulas: um capítulo por grupo (`aula-01`), composto pela lição + exercícios.
- Listas de figuras, tabelas e código no início do livro.
- Exercícios numerados por capítulo; gabarito num capítulo separado no fim.
- Apêndice com os trabalhos.
- Referências via `#bibliography` nativo (PDF) a partir do mesmo `refs.bib`.
- Convenções de autoria (`#figure`, `solutions` capturado) em `post-authoring`.

**Non-Goals:**
- Busca/navegação interativa (é do site).
- Full-text ou features de site.

## Decisions

### 1. Estrutura por aulas (capítulo por grupo)
- `generate-book.ts` agrupa posts por `group` (ex.: `aula-01`). Cada grupo vira um
  **capítulo**. A ordem dos capítulos segue a ordenação de grupo.
- Dentro do capítulo: a **lição** (`type: aula`) primeiro, depois os **exercícios**
  (`type: exercicio`).
- `trabalhos` (`type: trabalho`) não entram nos capítulos — vão para o **apêndice**.

### 2. Listas de figuras, tabelas e código
- No início (após o sumário), o `book.typ` emite:
  - `#list-of-figures()` e `#list-of-tables()` (nativos).
  - Lista de código: `#outline(target: figure.where(kind: "code"), title: "Lista de Código")`.
- Requer que os posts usem `#figure` com `caption` e `kind` apropriado (`"image"`,
  `"table"`, `"code"`). Convenção documentada em `post-authoring`.

### 3. Estrutura por aulas e agrupamento em Typst
- O **agrupamento acontece em `book.typ` (Typst)**, não no build TS. `generate-book.ts`
  emite os posts planos (com `meta {type, group, number}`); `book.typ` agrupa por `group`.
- Um **capítulo por grupo** que tenha lição (`type: aula`). O **heading do capítulo é o
  título da lição** (dele sai a numeração de capítulo, ex.: "2").
- Dentro do capítulo: a lição (`lesson.body`) e depois os exercícios (`exercicio` posts).
  Exercícios numerados por capítulo.

### 3a. Soluções como posts (fonte única) + seção dedicada
- **Solução é um post com `body`** (`solucoes/aula-01-solu-01.typ`), não um `#let solutions`
  dentro de outro post — fonte única de verdade, mesma moldura dos demais posts.
- O **corpo das soluções aparece no fim do livro**, numa **seção dedicada "Soluções"**
  (não dentro do capítulo). `book.typ` agrupa os posts de `solucao` e renderiza nessa seção.
- **Relação exercício↔solução pela convenção de nomenclatura**: `aula-01-exer-01` ↔
  `aula-01-solu-01` (mesmo `group` e `number`).
- **Nem todo exercício tem solução** — a seção lista apenas as soluções que existem.

### 3b. Numeração/labels no post (M1) + validação do build
- O **post se auto-rotula**: `#exercise()` gera a label e o número a partir de `meta.slug`
  (ex.: `label("ex-" + slug)`) e de um contador local por capítulo. No preview isolado o
  exercício numera igual ao livro.
- O post declara `slug` na `meta` (id do filename). O **build valida** que `meta.slug`
  bate com o nome do arquivo (avisa se divergir), mantendo o filename como fonte canônica
  sem risco de drift.
- Posts de solução **não contêm `@ref`**; as referências cruzadas exercício↔solução são
  montadas por `book.typ` na seção de Soluções usando o id derivado (`ex-aula-01-1`).

### 4. Apêndice de trabalhos
- Após o gabarito, um apêndice reúne os `trabalhos` (um por grupo que os possua),
  renderizados com a mesma moldura de post.

### 5. Referências
- `#bibliography("refs.bib")` no fim do livro (alvo PDF — confiável).
- Citações `@chave` no corpo dos posts resolvem via `refs.bib`. (O site lida com o mesmo
  arquivo separadamente, no `enhance-blog-site`.)

### 6. Templates
- `templates/book.typ` ganha helpers: capítulo de aula, bloco de exercício, capítulo de
  soluções, apêndice de trabalhos e as listas.
- `generate-book.ts` passa a receber os posts já agrupados por `group`/`type` (da fundação).

### 7. Preview de post (Tinymist)
- O arquivo de post continua renderizando sozinho; `#figure` e exercícios aparecem
  tipografados. `solutions` é um valor capturado, não renderizado no preview do post.

### 8. Loop de validação (enriquecer posts sem quebrar alvos)
Todo enriquecimento de post (`#figure`, `#exercise()`, `solutions`, `@chave`) SHALL passar
pelo triângulo de compilação, para não quebrar nenhum alvo:

```
               ┌──────────────┐
               │  post.typ    │
               └──────┬───────┘
       ┌──────────────┼──────────────┐
       ▼              ▼              ▼
   Tinymist       site (bundle)   book (PDF)
  (isolado)       (target html)   (target paged)
```

Roteiro por post:
1. `typst compile <post>` isolado — conferir tipografia (figuras, exercício numerado).
2. `bun run build` — conferir o site (target html, figura renderiza sem quebrar bundle) e o
   livro (target paged: capítulo, listas, seção de Soluções, refs).
3. Conferir a checagem `meta.slug == filename` no build (decisão 3b).

## Risks / Trade-offs

- [Reordenar soluções para o fim] → Mitigado capturando `solutions` como valor e emitindo
  depois; cada post continua fonte única.
- [Listas exigem `#figure` consistente] → Convenção em `post-authoring`; posts antigos
  precisam enriquecimento.
- [Numeração de exercícios por capítulo] → Contador local por capítulo; requer cuidado no
  gabarito para casar "2.3".
- [Dependência da fundação do site] → `didactic-book` assume `enhance-blog-site` aplicado
  (subpastas, group/type, refs.bib).