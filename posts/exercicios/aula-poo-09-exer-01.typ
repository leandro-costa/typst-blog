#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: O Grande Banquete da Metamorfose",
  date: "2026-07-21 08:30:00",
  tags: ("java", "polimorfismo", "heranca", "greenfoot", "exercicio"),
  excerpt: "No Greenfoot, um personagem só detecta maçãs com isTouching(Maca.class) — troque para isTouching(Fruta.class) e veja o polimorfismo comer qualquer fruta de uma vez.",
)

#let body = [

== Missão

Alimentos de vários tipos caem do céu, e seu personagem só consegue detectar *Maçãs* usando `isTouching(Maca.class)`. Será que dá pra detectar outras frutas também, sem escrever um `if` pra cada uma?

+ Crie uma superclasse `Alimento`.
+ Crie a hierarquia `Fruta` com pelo menos *3 subclasses* (ex.: `Maca`, `Banana`, `Uva`).
+ Crie um segundo conjunto `Vegetal` com pelo menos *3 subclasses* (ex.: `Cenoura`, `Brocolis`, `Tomate`).
+ No `act()` do `Personagem`, use `isTouching(Maca.class)` — com detecção por tipo específico, ele só captura *Maçãs*, mesmo quando `Banana` ou `Uva` colidem:

  ```java
  if (isTouching(Maca.class)) {
      removeTouching(Maca.class);
  }
  ```

+ Crie uma terceira hierarquia de sua escolha (ex.: `Doce`, `Carnes`, `Graos`).
+ Experimente: troque `isTouching(Maca.class)` por `isTouching(Fruta.class)` no `Personagem` — com polimorfismo, ele passa a detectar *qualquer fruta*.

== Regras do mundo

- Diferentes tipos de `Alimento` caem periodicamente no mundo.
- O personagem se move com as setas do teclado.
- Ao colidir com um alimento, o método `comer` é chamado.
- O personagem *só come frutas* — vegetais e outros alimentos não são capturados.
- A detecção de colisão usa `isTouching(Classe.class)` e `removeTouching(Classe.class)` no `act()`.

== Requisitos técnicos

- Superclasse `Alimento` com atributo `energia` (privado) e getter.
- Hierarquia `Fruta` com pelo menos 3 subclasses.
- Hierarquia `Vegetal` com pelo menos 3 subclasses.
- Uso de `isTouching(Maca.class)` no `act()` do `Personagem`, com detecção por tipo específico.
- Uma terceira hierarquia própria (ex.: `Doce` → `Bolo`, `Sorvete`, `Chocolate`).
- Experimento documentado em comentário: trocar `isTouching(Maca.class)` por `isTouching(Fruta.class)` e observar que todas as frutas passam a ser detectadas.
- Método `act()` no personagem com movimentação e detecção de colisão via `isTouching()`/`removeTouching()`.
- Uso de `Greenfoot.getRandomNumber()` para gerar alimentos aleatórios.

*Desafio extra (opcional):* um contador de energia que sobe conforme o personagem come frutas — e, quando a energia enche, ele muda de cor.

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Hierarquia `Alimento` → `Fruta` com 3 subclasses], [20],
    [Hierarquia `Vegetal` com 3 subclasses], [15],
    [Detecção com `isTouching(Maca.class)` no personagem], [25],
    [Terceira hierarquia própria], [15],
    [Movimentação e colisão no `act()`], [15],
    [Experimento de polimorfismo no `isTouching` documentado], [10],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

O segredo está no detector: com `isTouching(Maca.class)` você só pega maçãs, mas ao trocar para `isTouching(Fruta.class)`, um único método passa a abraçar todas as frutas. Se você está escrevendo `if (tipo == X)` pra decidir qual método chamar, está fazendo na mão o trabalho que o polimorfismo já faz de graça.

]

#post-layout(meta, body)
