#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: Modelagem de um Aparelho de DVD",
  date: "2026-05-26 13:00:00",
  tags: ("java", "encapsulamento", "construtor", "exercicio"),
  excerpt: "Modelar um aparelho de DVD com estado interno protegido: volume, filme inserido e regras rígidas sobre quando cada operação é permitida.",
)

#let body = [

== Missão

Modele um `AparelhoDVD` usando o que você já sabe de construtores e encapsulamento. Um DVD real não deixa você apertar "play" sem filme, nem tocar áudio com o aparelho desligado — o seu objeto também não deve deixar.

== Especificação

Ao ser criado, o aparelho de DVD está inicialmente *desligado*. Seu volume varia de 1 a 5, começando em 2. É possível inserir um filme, que tem nome, categoria e duração.

O aparelho pode: ligar e desligar; aumentar e diminuir o volume; inserir filme; remover filme; dar play e stop.

== Regras obrigatórias

- Só é possível realizar qualquer operação se o aparelho estiver *ligado*.
- Só é possível dar *play* se existir algum filme inserido.
- Só é possível dar *stop* se o aparelho estiver em *play*.
- Ao dar play, deve aparecer o nome e a duração do filme em exibição.

Pense em como o encapsulamento te ajuda aqui: o estado interno (ligado/desligado, tocando/parado, filme inserido) precisa ficar protegido, e cada método precisa checar as regras antes de agir — exatamente como fizemos com o `setSaldo` que rejeita valores inválidos.

]

#post-layout(meta, body)
