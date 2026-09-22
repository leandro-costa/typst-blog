## Why

O material de POO (Programação Orientada a Objetos) já existe, testado em sala, em
`D:\IFBA\20260IntPoo\unidade2\vibe\apostila-u3\2026-inf-poo` (VuePress/Markdown). Ele
precisa passar a viver no `typst-blog` para ganhar o mesmo pipeline de site + livro PDF
que os demais posts já têm, em vez de ficar isolado em outro repositório com outra
stack de build.

## What Changes

- Importar as aulas de POO (`src/posts/01_paradigmas.md` … `13_interface.md`, exceto
  `ementa.md` e `print.md`, que não são aulas) como novos posts em `posts/aulas/`.
- Importar os desafios correspondentes (`src/desafios/*.md`) como posts pareados em
  `posts/exercicios/`, usando o agrupamento `(group, type, number)` que o post-authoring
  já suporta — cada desafio compartilha o prefixo `aula-poo-NN` da sua aula.
- **Prefixo novo `aula-poo-NN`** (em vez de `aula-NN`): o blog já usa `aula-01` até
  `aula-10` para a série de tutoriais de Typst. As aulas de POO usam um prefixo de
  grupo próprio para não colidir com esses nomes de arquivo/slug existentes.
- Reescrever o conteúdo num tom **leve, bem-humorado e atraente para o público do
  ensino médio integrado** — sem os containers `::: tip/note/warning` do VuePress
  (piadas e analogias ficam no texto corrido, não em caixas destacadas), mas
  reaproveitando com moderação a metáfora "Deus Criador / Criaturas" da fonte
  (inspirada no monólogo *Um Sábado Qualquer*, de Carlos Ruas) como fio condutor
  leve, tecida na própria explicação técnica em vez de uma camada narrativa separada
  em 3 blocos. Ver `design.md` para o detalhamento (decisão revisada após a primeira
  aula ter ficado "didática demais").
- Diagramas PlantUML: em vez de gerar notebooks Jupyter/Callisto, reaproveitar os SVGs
  já pré-renderizados encontrados em
  `D:\IFBA\20260IntPoo\unidade2\vibe\apostila-u3\includes\code\<tema>\plantuml\*.svg`
  (fonte de uma conversão prévia para Typst, `main-nova.typ`) — copiados (SVG + `.pu`
  fonte) para o post, sem dependência de toolchain nova. Ver `design.md`.
- Converter os includes `@[code](./caminho.java)` da fonte (arquivos Java completos
  embutidos) em blocos ```` ```java ```` dentro de `#figure(..., kind: "code")`.
- Copiar as imagens referenciadas (`src/posts/img/*.png`, `src/desafios/img/**/*.png`)
  para dentro da árvore de assets do post correspondente.
- **BREAKING**: nenhuma — são posts novos, não há conteúdo existente sendo alterado.

## Capabilities

Esta mudança usa as convenções de autoria de posts já especificadas em
`post-authoring` (formato `meta`, agrupamento por `group`/`type`/`number`, figuras com
`kind`) sem alterar nenhum requisito existente — é conteúdo novo produzido dentro das
regras já vigentes. Não há capacidade nova nem modificada.

### New Capabilities
(nenhuma)

### Modified Capabilities
(nenhuma)

## Impact

- **Código**: nenhuma mudança em `scripts/` ou `templates/` — usa o pipeline existente
  (post-authoring, geração de site/livro, Callisto).
- **Conteúdo novo**: ~11 arquivos em `posts/aulas/` (`aula-poo-01-*.typ` … `aula-poo-13-*`,
  pulando 09/10 que não existem na fonte), até ~9 arquivos pareados em
  `posts/exercicios/`, notebooks `.ipynb` com diagramas PlantUML pré-executados, e
  imagens copiadas para os respectivos posts.
- **Toolchain de autoria**: gerar os notebooks exige rodar Jupyter localmente com
  kernel IJava + PlantUML (via `%maven`) uma vez por aula com diagrama — não é
  dependência de build/CI, só do processo de criação de conteúdo.
- **Dependências externas**: nenhuma nova dependência de build; `scripts/check-deps.ts`
  já valida notebooks com `%%plantuml` (exige `java`, opcionalmente `graphviz`).
