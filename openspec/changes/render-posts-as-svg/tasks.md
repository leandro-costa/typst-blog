## 1. Spike de validação

- [ ] 1.1 Validar num post de exemplo que o SVG gerado com `page(height: auto)` reproduz a tipografia fiel
- [ ] 1.2 Validar que `#show heading`/`#show figure` geram `<a href="#sec-N">`/`<a href="#fig-N">` no SVG
- [ ] 1.3 Validar o pós-processamento: injetar `id="sec-N"`/`id="fig-N"` e navegar via `<object>` + TOC
- [ ] 1.4 Definir o esquema de numeração de figuras (`fig-N`) confirmado no spike

## 2. Gerador de SVG no build

- [ ] 2.1 Criar `scripts/generate-svg.ts` que compila cada post para `dist/posts/<slug>.svg` com `page(height: auto)`
- [ ] 2.2 Adicionar etapa no `scripts/build.ts` para chamar o gerador de SVG por post
- [ ] 2.3 Garantir que a largura da página (margens) dos SVGs casa com o layout do post

## 3. Âncoras e reescrita de links no post-layout

- [ ] 3.1 Aplicar `#show heading` no `post-layout` para envolver headings com `#link("#sec-"+n)`
- [ ] 3.2 Aplicar `#show figure` para envolver figuras com `#link("#fig-"+n)`
- [ ] 3.3 Aplicar `#show link` para reescrever `#link(<label>)`/`#ref(<label>)` em `#link("#<nome>")`

## 4. Pós-processamento do SVG

- [ ] 4.1 Criar `scripts/process-svg.ts` que lê cada SVG e injeta `id="sec-N"`/`id="fig-N"` nos pontos das âncoras
- [ ] 4.2 Integrar o pós-processamento ao build após a geração dos SVGs
- [ ] 4.3 Garantir que os `id` injetados não conflitam com ids-hash existentes

## 5. Incorporação via object e TOC

- [ ] 5.1 Alterar `templates/post.typ`/`site.typ` para embutir o corpo como `<object data="posts/<slug>.svg">`
- [ ] 5.2 Atualizar `scripts/generate-site.ts` para o TOC apontar para `posts/<slug>.svg#sec-N`
- [ ] 5.3 Ajustar CSS do `<object>` para largura 100% e proporção correta

## 6. Remoção de Prism e CSS do corpo

- [ ] 6.1 Remover o tema Prism de `assets/css/style.css`
- [ ] 6.2 Remover o JS e a gramática Typst do Prism de `assets/js/`
- [ ] 6.3 Confirmar que a busca via `search-index.json` continua funcional

## 7. Validação final

- [ ] 7.1 Rebuild completo e validação visual dos posts em Chromium/Firefox
- [ ] 7.2 Verificar TOC com salto exato e citações internas funcionando
- [ ] 7.3 Verificar modo leitura, sidebar colapsável e navegação prev/next intactos