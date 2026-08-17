## Context

O blog em Typst exporta código HTML onde o compilador Typst emite elementos `<pre><code data-lang="...">...</code></pre>`. Atualmente, a estilização é apenas um bloco com fundo escuro sem realce de sintaxe adequado nem aparência estruturada similar ao `codly` usado no livro em PDF.

Para alinhar a identidade visual do livro e do blog, adotamos o Prism.js via CDN integrado com suporte a `data-lang` e um tema CSS customizado que emula a estrutura e as cores do `codly`.

## Goals / Non-Goals

**Goals:**
- Integrar Prism.js core e autoloader via CDN sem dependências pesadas de build.
- Permitir realce de sintaxe automático para todas as linguagens suportadas pelo Prism.js baseado no atributo `data-lang` nativo emitido pelo Typst.
- Estilizar blocos de código com tema CSS customizado que reproduz a estética do `codly`:
  - Fundo escuro harmonizado com o blog (`#1a1a1a` / `#18181b`).
  - Cabeçalho/badge ou indicação visual da linguagem.
  - Paleta de tokens (palavras-chave, strings, funções, operadores, comentários).
  - Tipografia monoespaçada consistente e cantos arredondados.

**Non-Goals:**
- Instalação e empacotamento local de Prism via npm bundler (manter arquitetura leve com CDN).
- Modificar o pipeline de geração de PDF (o PDF continua usando `codly` nativo no Typst).

## Decisions

### 1. Inclusão de Prism via CDN com Autoloader
- **Decisão**: Adicionar Prism.js Core + Autoloader Plugin via CDN no cabeçalho ou scripts do site gerado.
- **Alternativas consideradas**:
  - *Prism Bundle estático*: exigiria re-download ou build manual sempre que uma nova linguagem fosse usada.
  - *Highlight.js*: Prism foi escolhido por ser extensível, leve e melhor compatível com a personalização de tokens estilo Codly.

### 2. Mapeamento de `data-lang` para classes Prism
- **Decisão**: Incluir um pequeno script de inicialização que mapeia o atributo `data-lang` emitido pelo Typst para as classes `language-<lang>` esperadas pelo Prism antes do destaque, ou registrar um hook no Prism para ler `data-lang`.
- **Racional**: O Typst emite `<code data-lang="typ">`, enquanto o Prism busca por padrão `class="language-typ"`. Um hook/normalização garante suporte transparente a qualquer linguagem sem alterar a saída do Typst.

### 3. Tema CSS dedicado (`prism-codly.css` ou em `style.css`)
- **Decisão**: Estruturar as variáveis e regras CSS com o esquema de cores do Codly:
  - Background: `#1e1e2e` / `#18181b`
  - Keywords: `#c678dd` / `#8b41b1`
  - Strings: `#98c379` / `#198810`
  - Numbers/Constants: `#d19a66` / `#e5c07b`
  - Functions: `#61afef` / `#4b69c6`
  - Comments: `#5c6370`

## Risks / Trade-offs

- **[Dependência de CDN]** Falha de rede para carregar CDN → *Mitigação*: Os blocos continuam legíveis com a estilização base do CSS mesmo sem JS.
- **[Linguagens com nomes diferentes]** Ex: `typ` vs `typst` → *Mitigação*: Configurar aliases no Prism Autoloader para mapear `typ` para a gramática de Typst.
