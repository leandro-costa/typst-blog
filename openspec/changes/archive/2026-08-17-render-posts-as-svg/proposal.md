## Why

O site hoje renderiza cada post como HTML semântico (bundle `html`), cuja aparência diverge do preview/PDF do Typst. O autor quer que cada post exiba a **exata aparência tipográfica do preview** no site. Testes mostraram que o SVG exportado pelo Typst (com `page(height: auto)`) reproduz fielmente a tipografia, mas não carrega âncoras navegáveis nem IDs estáveis por padrão.

## What Changes

- Gerar, no build, um arquivo **SVG por post** usando `page(height: auto)` para capturar o post inteiro num único fluxo contínuo.
- Exibir o SVG no `post-layout` via `<object data="posts/<slug>.svg">`, mantendo o shell HTML (nav, sidebar, TOC, footer, busca).
- Fazer o `post-layout` envolver cada heading e figura com âncoras estáveis (`#link("#sec-N")`, `#link("#fig-N")`) via `#show`, para que o SVG exporte `href` com nomes controláveis.
- Reescrever links internos `#link(<label>)` / `#ref(<label>)` para `#link("#<nome>")` via `#show link`, preservando citações internas no SVG.
- Adicionar um **pós-processamento no build** que lê o SVG e injeta `id="sec-N"` / `id="fig-N"` nos pontos das âncoras geradas, tornando-as navegáveis dentro do `<object>`.
- Fazer o TOC do post apontar para `posts/<slug>.svg#sec-N`, com numeração baseada na ordem do `parseToc`.
- **BREAKING**: Remover Prism e o CSS de realce de código do post (o SVG carrega as cores nativas do codly); o texto do post deixa de ser selecionável/SEO indexável no corpo (mantém-se a busca via `search-index.json`).

## Capabilities

### New Capabilities
- `svg-post-rendering`: Capacidade de gerar, pós-processar e exibir cada post como um SVG fiel à tipografia do Typst, com âncoras navegáveis para TOC e citações internas, embutido via `<object>`.

### Modified Capabilities
- `site-generation`: O `post-layout` passa a incorporar o SVG do post via `<object>` (em vez de renderizar o corpo como HTML), com âncoras estáveis e TOC apontando para o SVG. O build passa a gerar e pós-processar os SVGs.

## Impact

- `scripts/`: novo gerador de SVG (`generate-svg.ts`) e pós-processamento dos SVGs (injeção de `id`).
- `scripts/build.ts`: nova etapa para compilar e pós-processar SVGs por post.
- `templates/post.typ` e `templates/site.typ`: ramo `html` passa a embutir o `<object>` do SVG; ramo paged permanece.
- `scripts/generate-site.ts`: TOC passa a apontar para `posts/<slug>.svg#sec-N`.
- `assets/css/style.css`: remoção do tema Prism (não mais necessário).
- `assets/js/`: remoção do Prism e da gramática Typst (não mais aplicados ao corpo HTML).
- `dist/posts/*.svg`: novos artefatos de saída por post.
- Busca (`search-index.json`) e RSS permanecem inalterados (não leem o SVG).