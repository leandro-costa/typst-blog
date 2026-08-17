#import "../../templates/post.typ": post-layout
#import "@preview/callisto:0.3.0"

#let meta = (
  title: "Callisto: renderizando notebooks Jupyter",
  date: "2026-08-19",
  
  tags: ("typst", "callisto", "jupyter", "notebook"),
  excerpt: "Como usar o pacote Callisto para inserir células de notebooks Jupyter em um documento Typst.",
)

#let body = [

#let (render, Cell, In, Out) = callisto.config(
  nb: path("example.ipynb"),
)

O [*Callisto*](https://github.com/sijow/callisto) é um pacote Typst que renderiza notebooks Jupyter dentro do seu documento. Em vez de capturar telas ou copiar código manualmente, as células são convertidas diretamente: markdown vira conteúdo formatado, código vira um bloco `raw` e a saída vira imagem ou texto.

== Configuração

O primeiro passo é importar o pacote:

#figure(
  ```typ
  #import "@preview/callisto:0.3.0"
  ```,
  caption: [Importando o pacote Callisto.]
)

Como é mais conveniente configurar o Callisto para trabalhar com um notebook específico, usamos `callisto.config`. O notebook de exemplo está no arquivo `example.ipynb`, e a linha abaixo "carrega" as funções `render`, `Cell`, `In` e `Out` ligadas a ele:

#figure(
  ```typ
  #let (render, Cell, In, Out) = callisto.config(
    nb: path("example.ipynb"),
  )
  ```,
  caption: [Configurando as funções do Callisto para um notebook.]
)

A partir daqui, este próprio documento faz a configuração, então podemos demonstrar o resultado real de cada recurso.

== Renderizando o notebook inteiro

Para incluir o notebook completo como conteúdo, basta chamar `#render()`. Veja o resultado real do nosso `example.ipynb`:

#figure(
  render(),
  caption: [Renderizando todas as células do notebook de exemplo.],
)

O conteúdo é convertido para Typst, então pode ser estilizado com `show`/`set`. Aqui o mesmo notebook é renderizado com um tema de células diferente (`theme: "neat"`):

#figure(
  render(theme: "neat"),
  caption: [Renderizando o notebook com o tema "neat".],
)

== Usando o notebook como capítulo

Para usar o notebook como uma seção de um documento maior, podemos controlar o nível dos cabeçalhos vindos do Markdown com o campo `h1-level`:

#figure(
  ```typ
  = Resultados
  Algum texto.

  // Cabeçalhos de nível 1 viram subseções
  #render(cmarker: (h1-level: 2))
  ```,
  caption: [Deslocando o nível dos cabeçalhos Markdown.]
)

Com `h1-level: -1`, um único `H1` do notebook pode virar o título do documento.

== Renderizando células específicas

Além do notebook inteiro, podemos renderizar uma única célula pelo índice. A célula `1` do notebook faz o cálculo `2 + 2`:

#figure(
  render(1),
  caption: [Renderizando a célula de índice 1 (o cálculo `2 + 2`).],
)

As células também podem ter um *label* na primeira linha do código (`#| label: nome`). O notebook define os labels `calc`, `plot1`, `plot2`, `plot3` e `type-error`. Podemos renderizar uma célula diretamente pelo seu label:

#figure(
  render("plot1"),
  caption: [Renderizando a célula de label "plot1" (um gráfico gerado por matplotlib).],
)

E também podemos combinar vários seletores — por exemplo, renderizar duas células pelos labels:

#figure(
  grid(
    columns: 2,
    render("plot2"),
    render("plot3"),
  ),
  caption: [Renderizando as células de label "plot2" e "plot3" lado a lado.],
)

== Tipos de saída

O Callisto lida com diferentes tipos de saída do Jupyter. O notebook tem células que produzem erro, dados em JSON e até markup Typst:

#figure(
  render("type-error"),
  caption: [Renderizando uma célula que gera erro (TypeError).],
)

#figure(
  render("json-result"),
  caption: [Renderizando uma célula que retorna um objeto JSON.],
)

#figure(
  render("typst-markup"),
  caption: [Renderizando uma célula que produz markup Typst.],
)

== Renderizando entrada e saída separadamente

As funções `In` e `Out` renderizam apenas a entrada ou a saída de uma célula, enquanto `Cell` renderiza ambas. O código a seguir:

#figure(
  In("calc"),
  caption: [Renderizando apenas a entrada da célula "calc".],
)

produz a seguinte figura:

#figure(
  Out("calc"),
  caption: [Renderizando apenas a saída da célula "calc".],
)

A diferença é que `#render` renderiza "qualquer coisa que corresponda" à especificação, enquanto `#Cell` exige exatamente uma célula — gerando erro se encontrar zero ou várias.

== Temas

Por padrão, as células usam o tema `"notebook"`. Podemos trocar para `"neat"` ou `"plain"`. Compare a mesma célula renderizada com o tema padrão e com o tema `"neat"`:

#figure(
  Cell("calc"),
  caption: [Célula "calc" com o tema padrão "notebook".],
)

#figure(
  Cell("calc", theme: "neat"),
  caption: [A mesma célula "calc" com o tema "neat".],
)

Podemos também estender um tema existente para customizar o comportamento. O exemplo abaixo faz as células `raw` serem avaliadas como markup Typst:

#figure(
  ```typ
  #render(
    theme: callisto.themes.notebook + (
      raw-cell: (cell, ..args) => eval(cell.source, mode: "markup"),
    ),
  )
  ```,
  caption: [Estendendo o tema notebook.]
)

== Conclusão

O Callisto integra notebooks Jupyter ao Typst de forma fluida, convertendo células em conteúdo tipográfico nativo. Com `render`, `In`, `Out` e `Cell`, você controla exatamente o que entra no documento, e os temas permitem ajustar a aparência. A fonte única é o notebook `.ipynb`.

]

#post-layout(meta, body)