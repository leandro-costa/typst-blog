#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: O Pacto do Banquete",
  date: "2026-08-11 08:30:00",
  tags: ("java", "interface", "polimorfismo", "greenfoot", "exercicio"),
  excerpt: "Bolo não é parente de Maçã, mas os dois assinam o contrato Comestivel — e o personagem come qualquer coisa que cumpra a promessa, não importa a linhagem.",
)

#let body = [

== Missão

No banquete, alimentos continuam caindo do céu. Até agora o personagem comia só o que pertencia à linhagem `Fruta` (herança), depois qualquer `Alimento` concreto (polimorfismo por classe abstrata). Agora, qualquer criatura de *qualquer linhagem* pode assinar o contrato `Comestivel` — e passar a ser comida pelo personagem. O `Bolo` não é da família `Fruta`; o `Sorvete` também não. São criaturas de outras árvores de herança que agora *se comportam como* comestíveis.

+ Crie a interface `Comestivel` com o método `void preparar()` (o jeito que cada comestível se prepara).
+ Faça a hierarquia `Fruta` assinar o contrato: `Maca`, `Banana`, `Uva` implementam `Comestivel`.
+ Faça a hierarquia `Vegetal` assinar o contrato: `Cenoura`, `Brocolis`, `Tomate` implementam `Comestivel`.
+ Crie uma hierarquia *totalmente independente* `Doce` (que *não herda* de `Alimento`): `Bolo`, `Sorvete`, `Chocolate` — mas todas implementam `Comestivel`.
+ No `act()` do `Personagem`, use `isTouching(Comestivel.class)` — o poder do contrato: detecta qualquer criatura que o assinou, *independente da linhagem*:

  ```java
  if (isTouching(Comestivel.class)) {
      Comestivel c = (Comestivel) getOneIntersectingObject(Comestivel.class);
      c.preparar(); // polimorfismo pelo contrato!
      removeTouching(Comestivel.class);
  }
  ```

+ *Experimento obrigatório:* crie uma criatura que *não assina* o contrato (ex.: `Pedra` ou `AlimentoEstragado`) e documente em comentário: ela *não* é detectada por `isTouching(Comestivel.class)` — o contrato é o que vale, não a aparência.

== Regras do mundo

- Diferentes tipos de criaturas comestíveis caem periodicamente no mundo.
- O personagem se move com as setas do teclado.
- Ao colidir com um comestível, chama `preparar()` — cada um se prepara do seu jeito.
- A detecção de colisão usa `isTouching(Comestivel.class)` — polimorfismo pela *interface*.
- As criaturas `Doce` (Bolo, Sorvete, Chocolate) pertencem a outra árvore de herança, provando que o contrato vale entre linhagens diferentes.

== Requisitos técnicos

- Interface `Comestivel` com o método abstrato `void preparar()`.
- Hierarquia `Fruta` com pelo menos 3 subclasses concretas que implementam `Comestivel`.
- Hierarquia `Vegetal` com pelo menos 3 subclasses concretas que implementam `Comestivel`.
- Hierarquia `Doce` *independente* (não herda de `Alimento`) com 3 subclasses que implementam `Comestivel`.
- Uso de `isTouching(Comestivel.class)` no `act()` do personagem.
- Chamada de `preparar()` na criatura coletada — cada uma imprime uma mensagem diferente.
- Experimento documentado: uma criatura sem contrato não é detectada.
- Método `act()` com movimentação e detecção de colisão.
- Uso de `Greenfoot.getRandomNumber()` para gerar criaturas aleatórias.

*Desafio extra (opcional):* crie um segundo contrato, `Coletavel` (com método `void coletar()`). Faça todas as criaturas comestíveis assinarem também esse contrato, e exiba um contador de itens coletados usando `isTouching(Coletavel.class)`.

== Arquivos de referência

Este exercício reaproveita a estrutura de mundo e personagem já usada nos exercícios anteriores de Greenfoot:

#figure(
  raw(read("code/aula-poo-11-exer-01/Comestivel.java"), lang: "java", block: true),
  caption: [Interface `Comestivel`.]
)

#figure(
  raw(read("code/aula-poo-11-exer-01/Alimento.java"), lang: "java", block: true),
  caption: [Classe abstrata `Alimento`, base para `Fruta` e `Vegetal`.]
)

#figure(
  raw(read("code/aula-poo-11-exer-01/Doce.java"), lang: "java", block: true),
  caption: [Hierarquia `Doce`, independente de `Alimento`, assinando `Comestivel`.]
)

#figure(
  raw(read("code/aula-poo-11-exer-01/Personagem.java"), lang: "java", block: true),
  caption: [`Personagem`, detectando comestíveis pelo contrato.]
)

#figure(
  raw(read("code/aula-poo-11-exer-01/MyWorld.java"), lang: "java", block: true),
  caption: [Mundo do jogo.]
)

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Interface `Comestivel` com método abstrato `preparar()`], [15],
    [Hierarquia `Fruta` assinando o contrato], [15],
    [Hierarquia `Vegetal` assinando o contrato], [15],
    [Hierarquia `Doce` independente (sem herdar de `Alimento`) assinando o contrato], [20],
    [Detecção com `isTouching(Comestivel.class)` no personagem], [20],
    [Movimentação e colisão no `act()`], [10],
    [Experimento: criatura sem contrato não é detectada (documentado)], [5],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

O contrato não pergunta de onde você veio — só exige que você cumpra o que prometeu. `isTouching(Comestivel.class)` não sabe nem se importa se a criatura é `Fruta`, `Vegetal` ou `Doce`: só pergunta "você assinou?". Se a resposta for sim, é banquete.

]

#post-layout(meta, body)
