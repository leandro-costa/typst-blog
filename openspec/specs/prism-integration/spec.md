# Prism Integration

## Purpose

TBD - Integração do Prism.js para realce de sintaxe nos blocos de código do blog.

## Requirements

### Requirement: Carregamento do Prism.js via CDN
O site SHALL carregar o Prism.js core e o plugin de autoloader via CDN em todas as páginas que renderizam conteúdo com blocos de código.

#### Scenario: Carregamento dos scripts no layout
- **WHEN** uma página do site ou post é renderizada no navegador
- **THEN** os recursos JS do Prism.js e Prism Autoloader devem ser requisitados via CDN.

### Requirement: Suporte ao atributo data-lang do Typst
O sistema SHALL detectar linguagens definidas via `data-lang` no elemento `<code>` e aplicar o realce de sintaxe correspondente do Prism.js.

#### Scenario: Realce de bloco de código com data-lang
- **WHEN** o HTML gerado contém `<code data-lang="typ">` ou `<code data-lang="python">`
- **THEN** o Prism.js deve carregar a gramática da linguagem e realçar os tokens de sintaxe.

### Requirement: Tema visual inspirado no Codly
O sistema SHALL aplicar estilos CSS customizados aos blocos de código (`pre` e `code`) de modo a reproduzir a estética do pacote `codly` (cores de tokens, bordas, espaçamento e tipografia).

#### Scenario: Exibição visual de bloco de código estilizado
- **WHEN** um usuário visualiza um bloco de código em um post
- **THEN** o bloco deve exibir cores de tokens diferenciadas para palavras-chave, strings, comentários e funções compatíveis com a paleta do livro.