#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: Paradigmas de Programação",
  date: "2026-02-12 07:40:00",
  tags: ("java", "paradigmas", "poo", "exercicio"),
  excerpt: "Sua primeira missão como criador de universos digitais: colocar dois guerreiros pra brigar, primeiro no Caos (C), depois na Ordem (Java).",
)

#let body = [

== Missão

Chegou sua vez de sujar as mãos. Prove que você entende tanto o Caos (estruturado) quanto a Ordem (orientado a objetos) implementando o mesmo sisteminha nos dois estilos: dois guerreiros, um combate, vencedor(es) declarado(s).

+ No paradigma estruturado, crie uma `struct` para representar um *Guerreiro* com `nome`, `vida` e `forca`. Crie funções separadas para `atacar` (reduz a vida do inimigo pela força do atacante) e `exibirStatus`.
+ No paradigma orientado a objetos, crie uma classe `Guerreiro` em Java com os mesmos atributos e métodos — mas agora declarados dentro da classe.
  + No `main`, crie dois guerreiros e faça um atacar o outro. Exiba o status antes e depois do ataque.

== Requisitos técnicos

- Versão em C com `struct` e funções separadas.
- Versão em Java com classe e métodos integrados.
- Dois objetos/instâncias de guerreiro em cada versão.
- Um guerreiro ataca o outro (a vida do alvo diminui).
- Exibição do status antes e depois do ataque.

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Struct e funções corretas em C], [20],
    [Classe Java com atributos e métodos], [30],
    [Criação de dois guerreiros], [15],
    [Lógica de ataque implementada], [20],
    [Exibição de status funcional], [15],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

Repare como, em Java, o guerreiro sabe atacar sozinho — o método é dele, mora com ele. Em C, alguém de fora precisa pegar os dados na mão e dizer à função o que fazer. Parece sutil agora, mas essa diferença vai guiar o curso inteiro.

]

#post-layout(meta, body)
