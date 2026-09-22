#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: O Banquete das Profecias",
  date: "2026-07-28 13:30:00",
  tags: ("java", "classe-abstrata", "heranca", "greenfoot", "exercicio"),
  excerpt: "Alimento vira classe abstrata com preparar() como método abstrato — e o personagem detecta qualquer alimento concreto via isTouching(Alimento.class).",
)

#let body = [

== Missão

No mundo do banquete, alimentos genéricos não existem — sempre são de um tipo específico. `Alimento` é só uma *promessa*: o molde abstrato que diz "todo alimento sabe se preparar". Quem cumpre essa promessa são as classes concretas: `Maca`, `Banana`, `Cenoura`, `Bolo`, etc.

O personagem só deve capturar alimentos que sabem se preparar de verdade — implementando `preparar()` cada um à sua maneira.

+ Torne `Alimento` uma *classe abstrata*, com um método abstrato `public abstract void preparar()`.
+ Crie a hierarquia `Fruta` (concreta) com pelo menos *3 subclasses* (ex.: `Maca`, `Banana`, `Uva`).
+ Crie a hierarquia `Vegetal` com pelo menos *3 subclasses* (ex.: `Cenoura`, `Brocolis`, `Tomate`).
+ No `act()` do `Personagem`, use `isTouching(Alimento.class)` — como `Alimento` é abstrata, só objetos de subclasses concretas existem de verdade, mas o polimorfismo garante que todas são detectadas:

  ```java
  if (isTouching(Alimento.class)) {
      Alimento a = (Alimento) getOneIntersectingObject(Alimento.class);
      a.preparar(); // polimorfismo!
      removeTouching(Alimento.class);
  }
  ```

+ Crie uma terceira hierarquia de sua escolha (ex.: `Doce` → `Bolo`, `Sorvete`, `Chocolate`).
+ *Experimento obrigatório:* documente em comentário que `new Alimento()` não compila — a promessa não pode ser instanciada.

== Regras do mundo

- Diferentes tipos de `Alimento` caem periodicamente no mundo.
- O personagem se move com as setas do teclado.
- Ao colidir com um `Alimento`, chama `preparar()` + `comer()` — cada alimento se prepara do seu jeito.
- `Alimento` é abstrata: ninguém pode dar `new Alimento()`.
- A detecção de colisão usa `isTouching(Alimento.class)` — a superclasse abstrata como tipo polimórfico.

== Requisitos técnicos

- Classe `Alimento` declarada `abstract`, com atributo `energia` (privado) e getter.
- Método abstrato `public abstract void preparar()` em `Alimento`.
- Hierarquia `Fruta` com pelo menos 3 subclasses concretas.
- Hierarquia `Vegetal` com pelo menos 3 subclasses concretas.
- Uso de `isTouching(Alimento.class)` no `act()` do personagem.
- Uma terceira hierarquia própria.
- Experimento documentado: tentativa de `new Alimento()` comentada, mostrando que não compila.
- Chamada de `preparar()` no alimento coletado — cada subclasse imprime uma mensagem diferente.
- Método `act()` com movimentação e detecção de colisão.
- Uso de `Greenfoot.getRandomNumber()` para gerar alimentos aleatórios.

*Desafio extra (opcional):* crie `AlimentoEstragado`, também abstrata (mostrando que uma subclasse de abstrata pode continuar abstrata), e `FrutaPodre extends AlimentoEstragado`, que não pode ser comida — o personagem perde energia ao encostar nela.

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Classe `Alimento` abstrata com `abstract preparar()`], [20],
    [Hierarquia `Fruta` com 3 subclasses concretas], [15],
    [Hierarquia `Vegetal` com 3 subclasses concretas], [15],
    [Detecção com `isTouching(Alimento.class)` no personagem], [20],
    [Terceira hierarquia própria], [10],
    [Movimentação e colisão no `act()`], [10],
    [Experimento: `new Alimento()` comentado como erro de compilação], [10],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

A promessa não pode nascer — mas pode ser referenciada. `isTouching(Alimento.class)` detecta qualquer subclasse concreta, porque o polimorfismo não se importa se a classe é abstrata. A única coisa que muda é que você não pode dar `new` nela.

]

#post-layout(meta, body)
