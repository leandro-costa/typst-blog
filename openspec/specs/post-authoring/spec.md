# Post Authoring Specification

## Purpose

Definir o formato dos arquivos de post, que devem ser autossuficientes e reutilizáveis
pelo site e pelo livro.

## Requirements

### Requirement: Formato do post autossuficiente

Cada post em `posts/*.typ` SHALL definir metadados via `#let meta = (...)`, o corpo em
`#let body = [...]` e a renderização com `#post-layout(meta, body)`. A `meta` SHALL
suportar `title`, `date`, `slug`, `author`, `tags` (lista) e `excerpt`. A `meta.date`
SHALL aceitar `YYYY-MM-DD` ou `YYYY-MM-DD HH:MM:SS` (hora, minuto e segundo opcionais).
O arquivo SHALL renderizar sozinho, produzindo o artigo estilizado quando compilado
diretamente.

#### Scenario: Post renderiza sozinho no preview
- **WHEN** um arquivo `posts/x.typ` com `meta` e corpo em `#let body` é compilado diretamente (ex.: Tinymist)
- **THEN** o artigo é renderizado estilizado com título, data, autor, tags e corpo formatado
- **AND** não há nav/footer de página (moldura do site)

#### Scenario: Post é importado por site e livro
- **WHEN** `site.typ` ou `book.typ` importa `posts/x.typ` como módulo
- **THEN** o módulo emite o post renderizado sem dupla renderização
- **AND** `meta` é acessível para montar cards, tags e capítulos

#### Scenario: Post inválido é ignorado
- **WHEN** um arquivo em `posts/` não define `meta` válida
- **THEN** o build o ignora com um aviso e continua com os demais

#### Scenario: Data com hora, minuto e segundo
- **WHEN** um post define `date: "2026-08-14 23:59:59"`
- **THEN** a ordenação respeita a hora e a exibição mostra `DD/MM/YYYY HH:MM`

### Requirement: Modelo de conteúdo tipado e agrupado

A pasta `posts/` SHALL ser organizada em subpastas por tipo (`aulas/`, `exercicios/`,
`solucoes/`, `trabalhos/`). Cada arquivo SHALL usar um nome com prefixo de grupo, como
`aula-01-poo`, `aula-01-exer-01`, `aula-01-solu-01`, de modo que itens do mesmo assunto
fiquem juntos. O build SHALL extrair `group` (prefixo), `type` (subpasta) e `number` do
caminho/nome, e a `meta` de cada post SHALL expor `type` e `group`.

#### Scenario: Post em subpasta com prefixo de grupo
- **WHEN** um arquivo `posts/exercicios/aula-01-exer-01.typ` existe
- **THEN** o build o classifica como `type: "exercicio"`, `group: "aula-01"`, `number: 1`

#### Scenario: Agrupamento por nome preserva o assunto
- **WHEN** posts de `aulas/`, `exercicios/` e `solucoes/` compartilham o prefixo `aula-01`
- **THEN** eles são ordenados juntos por `(group, tipo, número)`

#### Scenario: Post associa referência do refs.bib
- **WHEN** um post cita `@chave` existente em `refs.bib`
- **THEN** a citação resolve para a referência compartilhada (site e livro)

### Requirement: Figuras estruturadas com legendas em sintaxe Typst

Toda imagem, diagrama, tabela e bloco de código presente nos posts SHALL ser envelopado usando a sintaxe nativa de figura do Typst (`#figure(...)`), acompanhado obrigatoriamente de uma legenda (`caption: [...]`) e o respectivo parâmetro `kind` (ex.: `"image"`, `"table"`, `"code"`).

#### Scenario: Imagem ou diagrama envelopado em figura com caption
- **WHEN** um post inclui uma imagem ou diagrama
- **THEN** o elemento é declarado via `#figure(image(...), caption: [...], kind: "image")`

#### Scenario: Tabela ou código envelopado em figura com caption
- **WHEN** um post inclui uma tabela ou bloco de código
- **THEN** o elemento é declarado via `#figure(table(...), caption: [...], kind: "table")` ou `#figure(```...```, caption: [...], kind: "code")`

### Requirement: Execução ao vivo de código via Callisto (modo export)

Um post MAY declarar blocos de código Java como executáveis de verdade, em vez de só
ilustrativos, combinando o modo *export* do Callisto (`kernel:` + `#stage-notebook()`)
com uma regra de show que intercepta uma linguagem dedicada (convenção: `java-x`) e
chama `execute(it)`. O notebook gerado (`nb: path("<slug>.ipynb")`) SHALL viver ao
lado do `.typ` e ser sincronizado automaticamente pelo build
(`scripts/callisto-export.ts`) sempre que o `.typ` for mais recente que o `.ipynb`.

#### Scenario: Bloco de código marcado como executável
- **WHEN** um post define `#show raw.where(lang: "java-x"): it => execute(it)` e usa
  `raw(read(...), lang: "java-x", block: true)` ou um bloco ` ```java-x ` inline
  dentro de `#figure(...)`
- **THEN** o build exporta esse trecho para o notebook, executa via `jupyter
  nbconvert --execute` (kernel IJava) e a figura renderiza o código real seguido da
  saída real capturada — não um texto digitado à mão simulando a saída

#### Scenario: Trecho que não deve executar (ex.: quebraria o kernel)
- **WHEN** um trecho de código é só ilustrativo, referencia símbolos indefinidos, ou
  seu efeito colateral (crash, estado externo) não deve contaminar as células
  seguintes
- **THEN** o bloco usa uma linguagem comum (ex.: `java`), não `java-x`, permanecendo
  estático e fora da regra de show

#### Scenario: Erro intencional (ex.: demonstrar uma exceção real)
- **WHEN** um bloco `java-x` é escrito para lançar uma exceção de propósito
  pedagógico
- **THEN** o `nbconvert` do build SHALL rodar com `--allow-errors`, para que o kernel
  sobreviva ao erro e as células seguintes do mesmo notebook continuem executando
  normalmente
- **AND** o build SHALL continuar falhando (`ex.success == false`) apenas para falhas
  de infraestrutura (kernel ausente, timeout), não para erros de célula

#### Scenario: `typst eval` do modo export precisa do `--root` do projeto
- **WHEN** `scripts/callisto-export.ts` roda `typst eval --input
  callisto-export=true --in <doc>.typ "query(<notebook>).first().value"` para um
  post que importa outro arquivo por caminho relativo (ex.:
  `#import "../../templates/post.typ"`)
- **THEN** o comando SHALL incluir `--root .`, senão falha com "path would escape
  the project root" para qualquer post fora da raiz do projeto

#### Scenario: Alinhamento de saída que não passa pelo `codly`
- **WHEN** a saída de uma célula não é um elemento `raw` (ex.: o bloco de erro do
  Callisto, que já vem estilizado via `text()`/`highlight()`, não via `raw()`)
- **THEN** ela NÃO herda o alinhamento à esquerda que o `codly` aplica a blocos de
  código — fica sujeita ao `align(center)` padrão do `#figure(...)`
- **AND** a correção SHALL ser feita chamando `execute(...)` diretamente nesse ponto
  específico (fora da regra de show global) e envolvendo o resultado em
  `align(left, ...)`
- **AND** qualquer nova regra `#show raw.where(lang: ...)` adicionada ao redor do
  mecanismo de execução do Callisto (mesmo mirando uma linguagem diferente, como
  `"ansi"`) MUST NOT ser usada como correção — na prática ela quebra a renderização
  da célula inteira (execução some, vira placeholder vazio), porque colide com as
  regras de show internas que o próprio Callisto usa para desenhar o traceback