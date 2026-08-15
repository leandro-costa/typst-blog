## ADDED Requirements

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

## MODIFIED Requirements

### Requirement: Formato do post autossuficiente

A `meta.date` SHALL aceitar `YYYY-MM-DD` ou `YYYY-MM-DD HH:MM:SS` (hora, minuto e segundo
opcionais), permitindo distinguir posts publicados no mesmo dia.

#### Scenario: Data com hora, minuto e segundo
- **WHEN** um post define `date: "2026-08-14 23:59:59"`
- **THEN** a ordenação respeita a hora e a exibição mostra `DD/MM/YYYY HH:MM`