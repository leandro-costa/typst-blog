## 1. Spike de validação

- [x] 1.1 Validar num post de exemplo que o SVG gerado com `page(height: auto)` reproduz a tipografia fiel
- [x] 1.2 Validar que `#show heading`/`#show figure` geram `<a href="#sec-N">`/`<a href="#fig-N">` no SVG
- [x] 1.3 Validar o pós-processamento: injetar `id="sec-N"`/`id="fig-N"` e navegar via `<object>` + TOC
- [x] 1.4 Definir o esquema de numeração de figuras (`fig-N`) confirmado no spike

## 2. Gerador de SVG no build

- [x] 2.1 Criar `scripts/generate-svg.ts` que compila cada post para `dist/posts/<slug>.svg` com `page(height: auto)`
- [x] 2.2 Adicionar etapa no `scripts/build.ts` para chamar o gerador de SVG por post
- [x] 2.3 Garantir que a largura da página (margens) dos SVGs casa com o layout do post

## 3. Âncoras e reescrita de links no post-layout

- [x] 3.1 Aplicar `#show heading` no `post-layout` para envolver headings com `#link("#sec-"+n)`
- [x] 3.2 Aplicar `#show figure` para envolver figuras com `#link("#fig-"+n)`
- [x] 3.3 Aplicar `#show link` para reescrever `#link(<label>)`/`#ref(<label>)` em `#link("#<nome>")`

## 4. Pós-processamento do SVG

- [x] 4.1 Criar `scripts/process-svg.ts` que lê cada SVG e injeta `id="sec-N"`/`id="fig-N"` nos pontos das âncoras
- [x] 4.2 Integrar o pós-processamento ao build após a geração dos SVGs
- [x] 4.3 Garantir que os `id` injetados não conflitam com ids-hash existentes

## 5. Incorporação via object e TOC

- [x] 5.1 Alterar `templates/post.typ`/`site.typ` para embutir o corpo como `<object data="posts/<slug>.svg">`
- [x] 5.2 Atualizar `scripts/generate-site.ts` para o TOC apontar para `posts/<slug>.svg#sec-N`
- [x] 5.3 Ajustar CSS do `<object>` para largura 100% e proporção correta

## 6. Remoção de Prism e CSS do corpo

- [x] 6.1 Remover o tema Prism de `assets/css/style.css`
- [x] 6.2 Remover o JS e a gramática Typst do Prism de `assets/js/`
- [x] 6.3 Confirmar que a busca via `search-index.json` continua funcional

## 7. Validação final

- [x] 7.1 Rebuild completo e validação visual dos posts em Chromium/Firefox
- [x] 7.2 Verificar TOC com salto exato e citações internas funcionando
- [x] 7.3 Verificar modo leitura, sidebar colapsável e navegação prev/next intactos