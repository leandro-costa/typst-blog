#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: Objetos, Referência, Comparação e toString",
  date: "2026-03-31 14:00:00",
  tags: ("java", "objeto", "referencia", "equals", "tostring", "exercicio"),
  excerpt: "Criar a classe Guerreiro com identidade, ataque, toString e um critério de igualdade próprio — e provar no BlueJ a diferença entre == e equals.",
)

#let body = [

== Missão

O universo está lotado de criaturas, e chegou a hora de dar identidade a elas: um jeito de reconhecer quem é quem, comparar e deixar cada uma se apresentar.

+ Crie a classe `Guerreiro` com atributos próprios: nome, vida, força e clã (uma `String` que identifica o grupo do guerreiro).
+ Implemente um construtor que garanta que todo guerreiro nasça com identidade completa.
+ Implemente `atacar(Guerreiro alvo)` — o alvo perde vida igual à força do atacante.
+ Dê voz ao guerreiro: sobrescreva `toString()` no formato `"[Clã] NomeGuerreiro - Vida: X | Força: Y"`.
+ Defina o critério de igualdade: dois guerreiros são *iguais* se tiverem o *mesmo nome* e pertencerem ao *mesmo clã*.
+ No BlueJ, crie pelo menos *4 guerreiros* (dois do mesmo clã com mesmo nome, dois diferentes) e demonstre a diferença entre `==` e `equals()`, o `toString()` funcionando, e um guerreiro atacando outro.

== Requisitos técnicos

- Classe `Guerreiro` com atributos: `String nome`, `int vida`, `int forca`, `String cla`.
- Construtor que recebe todos os atributos.
- Método `void atacar(Guerreiro alvo)` — exibe mensagem e aplica dano.
- Método `@Override public String toString()` — retorna representação formatada.
- Método `public boolean equals(Guerreiro outro)` — compara por nome *e* clã.
- Teste no BlueJ demonstrando `==` vs `equals()` com guerreiros idênticos e diferentes.
- Teste no BlueJ demonstrando o `toString()`.

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Classe com atributos e construtor], [15],
    [Método `atacar` funcional], [15],
    [`toString()` com formato correto], [20],
    [`equals()` comparando nome e clã], [25],
    [Testes no BlueJ (`==` vs `equals`)], [15],
    [Teste de `toString` e `atacar` no BlueJ], [10],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

O `equals` é a pergunta que você faz para saber se dois objetos são equivalentes — mas quem define o critério é você. Escolha bem o que torna dois guerreiros "iguais" no seu programa.

]

#post-layout(meta, body)
