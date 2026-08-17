# SVG Post Rendering Specification

## Purpose

Renderizar cada post do site como um SVG fiel à tipografia do Typst (via
`page(height: auto)`), embutido num `<object>`, com âncoras estáveis para TOC e
citações internas.

## Requirements

### Requirement: Geração de SVG por post

O build SHALL gerar um arquivo SVG por post usando `page(height: auto)` para capturar o
post inteiro num único fluxo contínuo, a partir dos mesmos arquivos de post usados no
livro e no site. Cada SVG SHALL ir para `dist/posts/<slug>.svg`.

#### Scenario: Build gera SVG do post
- **WHEN** o build executa a compilação de um post
- **THEN** `dist/posts/<slug>.svg` é gerado capturando o post inteiro num único fluxo

### Requirement: Incorporação via object

O `post-layout` SHALL exibir o corpo do post como um `<object data="posts/<slug>.svg">`,
mantendo nav, sidebar, TOC, footer e busca como HTML ao redor.

#### Scenario: Post é exibido como object SVG
- **WHEN** o site é compilado para HTML
- **THEN** o corpo do post é um `<object>` apontando para o SVG, com o shell HTML ao redor

### Requirement: Âncoras estáveis para headings e figuras

O `post-layout` SHALL envolver cada heading e figura do post com âncoras estáveis
(`#link("#sec-N")` para headings, `#link("#fig-N")` para figuras), de modo que o SVG
exporte `<a href="#sec-N">`/`<a href="#fig-N">` com nomes controláveis. A numeração
`sec-N` SHALL seguir a ordem dos headings como derivada do `parseToc`.

#### Scenario: Heading gera âncora estável no SVG
- **WHEN** um post com headings é compilado para SVG
- **THEN** o SVG contém `<a href="#sec-N">` para cada heading, com `N` na ordem do TOC

#### Scenario: Figura gera âncora estável no SVG
- **WHEN** um post com figuras é compilado para SVG
- **THEN** o SVG contém `<a href="#fig-N">` para cada figura

### Requirement: Reescrever links internos

O `post-layout` SHALL reescrever links internos de citação (`#link(<label>)` e
`#ref(<label>)`) para âncoras por string (`#link("#<nome>")`), preservando as citações
entre seções e figuras como `href` funcionais no SVG.

#### Scenario: Citação interna vira href funcional
- **WHEN** o post contém `#link(<sec-2>)` ou `#ref(<fig-1>)`
- **THEN** o SVG exporta um `<a href="#<nome>">` que navega para a âncora correspondente

### Requirement: Pós-processamento injeta ids navegáveis

O build SHALL pós-processar cada SVG, encontrando os `<a href="#sec-N">`/`<a href="#fig-N">`
gerados e injetando `id="sec-N"`/`id="fig-N"` no elemento correspondente, tornando-os alvos
navegáveis dentro do `<object>`.

#### Scenario: Ids injetados nos headings
- **WHEN** o build pós-processa o SVG de um post com headings
- **THEN** cada heading vira um alvo `id="sec-N"` correspondente à âncora `#sec-N`

#### Scenario: Ids injetados nas figuras
- **WHEN** o build pós-processa o SVG de um post com figuras
- **THEN** cada figura vira um alvo `id="fig-N"` correspondente à âncora `#fig-N`

### Requirement: TOC navega dentro do SVG

O TOC do post SHALL apontar para `posts/<slug>.svg#sec-N`, permitindo salto exato para a
seção dentro do `<object>`, usando a numeração derivada da ordem do `parseToc`.

#### Scenario: TOC salta para seção no SVG
- **WHEN** o usuário clica num item do TOC de um post
- **THEN** a página navega para `posts/<slug>.svg#sec-N` e o `<object>` rola até a seção

### Requirement: Remoção do realce Prism do corpo

O corpo do post SHALL não aplicar o tema Prism nem o JS de realce de código do corpo
HTML, pois as cores do código (codly) são embutidas no SVG. A busca via `search-index.json`
SHALL permanecer funcional.

#### Scenario: Prism não é aplicado ao corpo
- **WHEN** o site é compilado
- **THEN** o corpo do post não carrega o CSS/JS do Prism, e a busca continua funcionando