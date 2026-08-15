# Tasks — Enhance Blog Site

## 1. Modelo de conteúdo tipado (fundação)

- [x] 1.1 Reestruturar `posts/` em subpastas por tipo: `aulas/`, `exercicios/`, `solucoes/`, `trabalhos/`
- [x] 1.2 Migrar os posts existentes para a nova nomenclatura com prefixo de grupo (ex.: `aula-01-poo`)
- [x] 1.3 Atualizar `parse-posts.ts` para varrer subpastas recursivamente e extrair `type` (subpasta) e `group`/`number` (do nome)
- [x] 1.4 Expor `type` e `group` na `meta` de cada post
- [x] 1.5 Ordenar posts por `(group, tipo-prioridade, número)`
- [x] 1.6 Criar `refs.bib` na raiz (compartilhado com o livro)

## 2. Navegação e layout

- [x] 2.1 Adicionar helper `post-nav` no `templates/site.typ` (anterior/próximo pela ordem de grupo)
- [x] 2.2 Emitir links prev/next na página de cada post via `generate-site.ts`
- [x] 2.3 Adicionar sidebar estática (`<aside>`): sobre, tags, recentes, busca, link do livro — com parâmetro `sidebar` em `site-layout`
- [x] 2.4 Montar o conteúdo da sidebar no build e passá-lo ao template
- [x] 2.5 Adicionar posts relacionados (mesmo grupo ou tags compartilhadas) no rodapé da página de post
- [x] 2.6 Atualizar `assets/css/style.css` para layout de 2 colunas (main + sidebar) e cards

## 3. Tags estáticas

- [x] 3.1 Calcular o conjunto de tags e o mapa tag→posts no build
- [x] 3.2 Emitir `#document` por tag em `/tags/<tag>.html` com cards filtrados
- [x] 3.3 Renderizar a nuvem de tags na sidebar apontando para essas páginas

## 4. Busca

- [x] 4.1 Emitir `dist/search-index.json` no build (título, slug, data, tags, excerpt, url)
- [x] 4.2 Adicionar estrutura HTML de busca (input + container) via `html.elem` no template
- [x] 4.3 Criar `assets/js/search.js` que carrega o index e filtra título/tags/excerpt
- [x] 4.4 Garantir degradação graciosa sem JS

## 5. Referências

- [x] 5.1 Spike: validar suporte de `#bibliography`/`@cite` no target html do Typst 0.15
- [x] 5.2 Renderizar a página de Referências no site (nativo ou fallback via build)

## 6. RSS e reading time

- [x] 6.1 Gerar `dist/rss.xml` (Atom) a partir dos metadados, ordenado por `meta.date`
- [x] 6.2 Estimar reading time do corpo (strip de markup → palavras ÷ wpm) e expor no card/página
- [x] 6.3 Adicionar link do feed na navbar

## 7. Validação

- [x] 7.1 `bun run build` com posts em subpastas e conferir site, tags, rss, index e nav
- [x] 7.2 Conferir prev/next, sidebar, tags estáticas, busca e relacionados no `serve`
- [x] 7.3 Confirmar que o preview paged (Tinymist) segue tipografado sem HTML-only