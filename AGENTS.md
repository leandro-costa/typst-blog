# Orientações ao Agente

## Regra principal: confirmar antes de agir

- **Nunca** mudar de estratégia ou aplicar uma solução sem antes confirmar com o usuário.
- Antes de iniciar qualquer tentativa e erro, **pesquisar primeiro na documentação oficial** (typst.app/docs, docs.rs, changelogs) e apresentar os achados ao usuário.
- Expor claramente a estratégia proposta e aguardar aprovação antes de implementar.
- Quando em dúvida sobre o caminho a seguir, parar e perguntar em vez de assumir.

## Reusabilidade de código

- **Evitar duplicação de código** sempre que possível. Maximizar a reutilização:
  extrair padrões comuns em arquivos/modulos compartilhados e reutilizá-los
  em todos os pontos que precisam do mesmo comportamento.
- Ao criar ou alterar código que servirá a mais de um destino de exportação
  (ex.: book PDF e SVG), centralizar os padrões em um único arquivo comum
  e fazer os destinos importarem dele.

## Contexto do projeto

- Repo: `typst-blog` — blog estático + livro PDF, tudo em Typst, build em TypeScript/Bun.
- Runtime: **Bun**. Typst 0.15.1.
- Changes OpenSpec em `openspec/changes/`; especificações em `openspec/specs/`.

## Achados técnicos importantes (validados)

- `target()` retorna **`"paged"`** para exportação PDF e SVG (não "svg"). Não é possível
  distinguir PDF de SVG via `target()`. Usar `--input` explícito do wrapper para isso.
- `svg_merged` é função da crate `typst-svg`, **não exposta no CLI 0.15.1**
  (nem `--format svg` multi-página, nem bundle `#document` SVG). `page(height: auto)`
  é necessário para gerar SVG único contínuo.