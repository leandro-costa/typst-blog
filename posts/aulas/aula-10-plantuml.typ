#import "../../templates/post.typ": post-layout
#import "@preview/callisto:0.3.0"

#let meta = (
  title: "PlantUML no IJava: diagramas como código no notebook",
  date: "2026-09-22",
  tags: ("typst", "callisto", "plantuml", "ijava", "notebook"),
  excerpt: "A mágica %%plantuml renderiza diagramas localmente como image/png no kernel IJava, e o Callisto os exibe no blog e no livro.",
)

#let body = [

#let (render, Cell, In, Out) = callisto.config(
  nb: path("plantuml-demo.ipynb"),
)

Diagramas PlantUML escritos como texto dentro de células do Jupyter (kernel IJava) viram imagens geradas **localmente**, sem servidor externo e sem Graphviz (para diagramas de sequência). O segredo está no formato de saída: a mágica emite `image/png`, que o Callisto converte em imagem nativa do Typst — o mesmo caminho dos plots matplotlib.

== Dependência via `%maven`

A biblioteca PlantUML é carregada no kernel com versão pinada (reprodutibilidade). A célula abaixo faz isso:

#figure(
  In(1),
  caption: [Carregando o PlantUML via `%maven` com versão pinada.],
)

== A mágica `%%plantuml`

A mágica é registrada na API do IJava (`Kernel.getKernelInstance().getMagics().registerCellMagic`) e publica o diagrama com `Display.display(img)`, o que gera um `display_data` com mimetype `image/png`. Detalhe importante: células `%%` descartam o valor de retorno, por isso a publicação é explícita:

#figure(
  In(2),
  caption: [Implementação da mágica `%%plantuml` (trecho).],
)

O corpo aceita PlantUML com ou sem as tags `@startuml`/`@enduml` — quando ausentes, a mágica completa automaticamente. Falhas de renderização viram mensagem de erro legível na saída da célula.

== Diagrama sem tags

A célula abaixo foi escrita sem `@startuml`/`@enduml`:

#figure(
  Cell(4),
  caption: [Diagrama de sequência escrito de forma curta; a mágica completa as tags.],
)

== Diagrama com tags

E esta já traz as tags, usadas como estão:

#figure(
  Out(6),
  caption: [Diagrama de sequência com tags `@startuml` explícitas.],
)

== 100% local e offline

Os PNGs ficam salvos como outputs dentro do próprio `.ipynb` — o build nunca executa o kernel. O `scripts/check-deps.ts` verifica isso na etapa 0: exige `java` quando há `%%plantuml`, `graphviz` só para diagramas que o exigem, e aborta se alguma célula `%%plantuml` não tiver o `image/png` salvo. A fonte única continua sendo o notebook.

== Conclusão

Com a mágica `%%plantuml`, diagramas entram no mesmo fluxo dos posts: autor escreve texto no Jupyter, o notebook guarda a imagem gerada localmente, e o Callisto renderiza no site e no livro sem HTML intermediário.

]

#post-layout(meta, body)
