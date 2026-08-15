# Site Search Specification

## Purpose

Oferecer busca ao vivo no site, com o índice emitido pelo build e a estrutura HTML
gerada pelo Typst.

## Requirements

### Requirement: Busca ao vivo no site

O site SHALL oferecer busca ao vivo que filtra posts por título, tags e excerpt. A
estrutura HTML (campo de busca + container de resultados) SHALL ser emitida pelo Typst
na navbar; o build SHALL emitir `search-index.json`; um JS estático de assets SHALL
carregar o index e renderizar os resultados. A busca SHALL degradar graciosamente sem JS.

#### Scenario: Buscar por termo retorna posts
- **WHEN** o usuário digita um termo no campo de busca
- **THEN** os posts cujo título, tags ou excerpt correspondem são listados nos resultados

#### Scenario: Funciona sem JavaScript
- **WHEN** o JS está desabilitado
- **THEN** a página continua navegável (busca vira busca nativa do navegador)