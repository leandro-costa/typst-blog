#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: Corrida de Animais (Greenfoot)",
  date: "2026-07-14 08:30:00",
  tags: ("java", "heranca", "greenfoot", "exercicio"),
  excerpt: "Um joguinho de corrida no Greenfoot para ver herança em ação: uma classe base Corredor, e Tartaruga, Gato e Lebre sobrescrevendo a velocidade.",
)

#let body = [

== Missão

Um jogo de corrida simples pra ver herança funcionando de verdade, dentro do Greenfoot. Objetivos de aprendizado: entender herança entre classes, praticar sobrescrita de atributos em subclasses, e diferenciar classe base de classe derivada.

== Estrutura do projeto

#figure(
  table(
    columns: 3,
    [*Classe*], [*O que é*], [*O que faz*],
    [`Corredor`], [Classe base (pai)], [Define o atributo `velocidade` e o movimento no método `act()`],
    [`CorredorTartaruga`], [Subclasse de `Corredor`], [Sobrescreve a velocidade para *1* (lenta) — cor verde],
    [`CorredorGato`], [Subclasse de `Corredor`], [Sobrescreve a velocidade para *3* (média) — cor laranja],
    [`CorredorLebre`], [Subclasse de `Corredor`], [Sobrescreve a velocidade para *5* (rápida) — cor azul],
    [`MundoCorrida`], [Mundo do jogo], [Cria a pista, posiciona os corredores e detecta o vencedor],
  ),
  caption: [Classes do projeto e suas responsabilidades.]
)

== O que estudar em cada classe

=== Corredor.java (classe base)

- `protected int velocidade` — atributo visível para as subclasses.
- `act()` — método que move o corredor para a direita.
- `getTipo()` — retorna o nome do corredor.

#figure(
  raw(read("code/aula-poo-07-exer-01/Corredor.java"), lang: "java", block: true),
  caption: [Classe base `Corredor`.]
)

=== Subclasses (Tartaruga, Gato, Lebre)

- Cada uma chama `super()` no construtor.
- Cada uma *sobrescreve* `this.velocidade` com um valor diferente.
- Cada uma tem sua própria cor e formato (círculo).

#figure(
  raw(read("code/aula-poo-07-exer-01/CorredorGato.java"), lang: "java", block: true),
  caption: [Subclasse `CorredorGato`, sobrescrevendo a velocidade herdada.]
)

=== MundoCorrida.java

- Cria a pista com faixas e linha de chegada.
- Posiciona cada corredor em sua faixa.
- Detecta qual corredor cruzou a linha de chegada primeiro.

#figure(
  raw(read("code/aula-poo-07-exer-01/Chegada.java"), lang: "java", block: true),
  caption: [Lógica de detecção da linha de chegada.]
)

== Cenário

#figure(
  image("img/aula-poo-07-exer-01/Mundo.png"),
  caption: [O mundo da corrida no Greenfoot.],
)

#figure(
  image("img/aula-poo-07-exer-01/Tree.png"),
  caption: [Árvore de classes: `Corredor` e suas subclasses.],
)

]

#post-layout(meta, body)
