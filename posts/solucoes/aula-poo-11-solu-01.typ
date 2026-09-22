#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: O Pacto do Banquete",
  date: "2026-08-12",
  tags: ("java", "interface", "polimorfismo", "greenfoot", "poo", "solucao"),
  excerpt: "Completando o cenário: Comestivel, Alimento e Doce já vinham prontos no enunciado — faltava só criar as frutas, os vegetais e uma Pedra que não assina o pacto.",
)

#let body = [

== O que já vinha pronto

O enunciado desta aula já trazia a interface `Comestivel`, a classe abstrata `Alimento` (que implementa `Comestivel` e já faz o alimento cair e sumir no chão), a classe `Doce` (uma segunda hierarquia, *independente* de `Alimento`) e o `Personagem`, detectando pelo contrato:

#figure(
  raw(read("code/aula-poo-11-solu-01/Comestivel.java"), lang: "java", block: true),
  caption: [Interface `Comestivel`, dada no enunciado. Repare: o contrato aqui é `int preparo()`, não `void preparar()` como o texto da aula sugeria — segui o contrato real do código.]
)

#figure(
  raw(read("code/aula-poo-11-solu-01/Alimento.java"), lang: "java", block: true),
  caption: [`Alimento`, dada no enunciado: abstrata, implementa `Comestivel` e já cuida de cair e desaparecer.]
)

#figure(
  raw(read("code/aula-poo-11-solu-01/Doce.java"), lang: "java", block: true),
  caption: [`Doce`, dada no enunciado — segunda hierarquia, sem relação nenhuma com `Alimento`.]
)

#figure(
  raw(read("code/aula-poo-11-solu-01/Personagem.java"), lang: "java", block: true),
  caption: [`Personagem`, dado no enunciado, já detectando `isTouching(Comestivel.class)`.]
)

O `MyWorld` original já citava classes como `Banana`, `Maca`, `Abobora` e `Bolo` que nunca chegaram a ser criadas — era o pedaço que faltava completar.

== O que faltava: as classes concretas

`Maca`, `Banana` e `Uva` assinam o pacto via `Alimento` (que já implementa `Comestivel`):

#figure(
  raw(read("code/aula-poo-11-solu-01/Maca.java"), lang: "java", block: true),
  caption: [`Maca`, estendendo `Alimento`.]
)

`Abobora`, `Cenoura` e `Tomate` seguem o mesmo molde, representando o lado "vegetal":

#figure(
  raw(read("code/aula-poo-11-solu-01/Abobora.java"), lang: "java", block: true),
  caption: [`Abobora`, também via `Alimento`.]
)

E a hierarquia `Doce` — `Bolo`, `Sorvete`, `Chocolate` — nem precisa reimplementar `preparo()`: como `Doce` já implementa `Comestivel` sozinha, as subclasses só cuidam da própria aparência:

#figure(
  raw(read("code/aula-poo-11-solu-01/Bolo.java"), lang: "java", block: true),
  caption: [`Bolo`, estendendo `Doce` — nenhuma linhagem com `Alimento`.]
)

== O experimento: quem não assina o pacto

#figure(
  raw(read("code/aula-poo-11-solu-01/Pedra.java"), lang: "java", block: true),
  caption: [`Pedra`: cai junto com os alimentos, mas não implementa `Comestivel` — nunca é detectada.]
)

== Completando o mundo

O `MyWorld` original já vinha com a estrutura de spawn — só ampliei o `switch` pra incluir as novas classes e a `Pedra`:

#figure(
  raw(read("code/aula-poo-11-solu-01/MyWorld.java"), lang: "java", block: true),
  caption: [`MyWorld`, com o `switch` de spawn ampliado (marcado no comentário) para 10 tipos possíveis, incluindo a `Pedra`.]
)

== Pontos-chave

- `Maca` e `Bolo` não têm *nenhum* ancestral em comum além de `Object` — uma vem de `Alimento`, a outra de `Doce`. Mesmo assim, `isTouching(Comestivel.class)` detecta as duas, porque as duas implementam a mesma interface. É exatamente o que a aula chama de "pacto entre linhagens diferentes".
- `Pedra` cai, ocupa espaço, o `Personagem` pode até encostar nela — mas `isTouching(Comestivel.class)` nunca a detecta, porque ela nunca assinou o contrato. A linhagem dela (`Actor` puro) não importa: o que importa é não ter `implements Comestivel`.
- `Doce.preparo()` chama `Greenfoot.stop()` e devolve `-1` — um "efeito colateral" nada óbvio que já vinha no código dado. `Bolo`, `Sorvete` e `Chocolate` herdam esse comportamento sem precisar escrever nada a mais, porque não sobrescrevem `preparo()`. Vale conferir esse detalhe antes de jogar: comer doce demais para o jogo!

]

#post-layout(meta, body)
