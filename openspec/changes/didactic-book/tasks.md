# Tasks — Didactic Book

## 1. Fundação (depende de enhance-blog-site)

- [ ] 1.1 Confirmar que posts estão em subpastas por tipo e com `meta {type, group}` (da fundação)
- [ ] 1.2 Confirmar `refs.bib` compartilhado existente

## 2. Convenções de autoria

- [ ] 2.1 Documentar no `post-authoring` o uso de `#figure` (caption/kind) nos posts
- [ ] 2.2 Definir helper `#exercise()` com contador por capítulo e label auto-derivada de `meta.slug` (M1)
- [ ] 2.3 Adicionar validação no build: `meta.slug` deve coincidir com o nome do arquivo
- [ ] 2.4 Enriquecer posts existentes com `slug`, figuras/tabelas/código e exercícios de exemplo

## 3. Livro didático (book.typ)

- [ ] 3.1 Estruturar capítulos por grupo (aula = lição + exercícios) em `generate-book.ts`
- [ ] 3.2 Adicionar `#list-of-figures()` e `#list-of-tables()` após o sumário
- [ ] 3.3 Adicionar lista de código via `outline(target: figure.where(kind: "code"))`
- [ ] 3.4 Renderizar exercícios numerados no fim de cada capítulo
- [ ] 3.5 Criar capítulo Soluções/Gabarito no fim, concatenando `solutions` dos grupos
- [ ] 3.6 Criar apêndice de trabalhos (`type: trabalho`) no fim do livro
- [ ] 3.7 Adicionar `#bibliography("refs.bib")` e resolver citações `@chave`

## 4. Validação

- [ ] 4.1 Compilar `book.typ` e conferir capítulos por aula, listas e seção de Soluções
- [ ] 4.2 Conferir apêndice de trabalhos e referências no PDF
- [ ] 4.3 Rodar o loop de validação por post enriquecido (Tinymist isolado → build site+livro) e conferir a checagem `meta.slug == filename`