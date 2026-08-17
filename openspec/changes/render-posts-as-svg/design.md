## Context

O blog gera cada post como HTML semântico (`typst compile --features bundle,html`), cuja tipografia diverge do preview/PDF. Testes empíricos com o Typst export SVG (`test.svg`) confirmaram:

- O texto vira **glifos individuais** (`<use xlink:href="#gHEX">`), não `<text>` legível.
- Os `id` gerados são **hashes instáveis** (`gHEX`), não os labels definidos.
- `#link(<label>)` (target do tipo label) gera um `<a>` **sem `href`** — quebrado no SVG.
- `#link("#string")` (target string) gera **`<a href="#string" xlink:href="#string">`** — âncora estável e controlável.
- Envolver headings com `#show heading: it => link("#sec-"+n)[#it]` gera `<a href="#sec-N">` **logo após** os glifos do heading, servindo de marcador de posição confiável para pós-processamento.
- `page(height: auto)` produz um único SVG contínuo (altura = conteúdo), adequado para posts longos.

## Goals / Non-Goals

**Goals:**
- Reproduzir no site a **exata aparência tipográfica** do preview/PDF de cada post.
- Manter TOC com **salto exato** para seções (numeração baseada na ordem do `parseToc`).
- Manter **citações internas** (`#link`, `#ref` entre seções/figuras) funcionais dentro do SVG.
- Manter busca (via `search-index.json`) e navegação do site (nav, sidebar, footer) intactas.
- Remover Prism e CSS de realce do corpo do post (o SVG carrega as cores do codly).

**Non-Goals:**
- Não indexar o texto do corpo do post para SEO (aceito: texto vira imagem no SVG).
- Não tornar o texto do post selecionável.
- Não alterar o pipeline do livro PDF (book.typ permanece).
- Não modificar a change `add-plantuml-ijava-magic` (esta é independente).

## Decisions

### 1. Gerar SVG por post com `page(height: auto)`
Cada post é compilado para um único SVG contínuo. A largura é a da página (ex.: A4/margens do post), a altura é automática. Isso captura o post inteiro num arquivo, fiel ao fluxo tipográfico do Typst.
- *Alternativa:* múltiplas páginas por SVG. Rejeitada: exige empilhar N SVGs e fica fragmentado.

### 2. Embutir via `<object>` no `post-layout`
`<object data="posts/<slug>.svg" type="image/svg+xml">` permite navegação por âncoras internas (diferente de `<img>`, que é opaco). O shell HTML (nav/sidebar/TOC/footer) permanece em volta.

### 3. Âncoras estáveis via `#show heading` e `#show figure`
O `post-layout` aplica:
```typ
#show heading: it => { let n = <num do heading>; link("#sec-" + n)[#it] }
#show figure:  it => { let n = <num da figura>;  link("#fig-" + n)[#it] }
```
Isso faz o Typst exportar `<a href="#sec-N">`/`<a href="#fig-N">` com nomes controláveis.

### 4. Reescrever links internos via `#show link`
```typ
#show link: it => if type(it.target) == label { link("#" + it.target.name) } else { it }
```
Converte `#link(<label>)`/`#ref(<label>)` em `#link("#nome")`, que gera `href` funcional. Preserva citações internas no SVG.

### 5. Pós-processamento do SVG no build
Um script lê cada SVG, encontra os `<a href="#sec-N">`/`<a href="#fig-N">` e injeta `id="sec-N"`/`id="fig-N"` no elemento correspondente, tornando-os alvos navegáveis dentro do `<object>`. É determinístico (baseado nos `href` já gerados), não precisa ler glifos nem adivinhar posições.

### 6. TOC aponta para `posts/<slug>.svg#sec-N`
O TOC (gerado em `generate-site.ts`) usa `href="posts/<slug>.svg#sec-N"`. A numeração `sec-N` segue a **ordem do `parseToc`** (índice da lista de headings), casando com a ordem em que os `<a>` aparecem no SVG.

## Risks / Trade-offs

- [Texto do corpo não selecionável / não indexado para SEO] → Aceito (Non-Goal); busca via `search-index.json` continua.
- [Hashes instáveis dos `<g>` não são usados] → Mitigado: usamos nomes estáveis `sec-N`/`fig-N` via `#show`, não os hashes.
- [A numeração `sec-N` do TOC precisa casar com a ordem dos `<a>` no SVG] → Mitigado: ambos derivam da mesma ordem de headings; validar no teste com post de exemplo.
- [Figuras/refs `#ref(<fig>)` podem não ter contagem confiável] → Validar contagem de figuras por post no spike antes de fixar o esquema `fig-N`.
- [SVG de post muito longo fica alto] → Aceito (usuário confirmou posts longos); `height: auto` não corta nada.
- [`<object>` pode ter diferenças de escala/zoom entre navegadores] → Controlar via CSS (`width: 100%`, altura proporcional) e testar em Chromium/Firefox.

## Migration Plan

1. Spike: validar num post de exemplo que o SVG gerado, o pós-processamento (injeção de `id`) e o `<object>` + TOC navegam corretamente.
2. Implementar gerador de SVG e pós-processamento no build.
3. Alterar `post-layout` (âncoras, `<object>`) e TOC.
4. Remover Prism/CSS do corpo.
5. Rebuild e validação visual.

## Open Questions

- Esquema exato de numeração de figuras (`fig-N`): contagem por post ou global? A definir no spike.
- Como garantir alinhamento de rolagem do `<object>` com o scroll da página (anchor scroll dentro de object embutido).