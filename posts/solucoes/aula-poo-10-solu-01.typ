#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: O Banquete das Profecias",
  date: "2026-07-29",
  tags: ("java", "classe-abstrata", "heranca", "greenfoot", "poo", "solucao"),
  excerpt: "Alimento vira abstrata com preparar() como método abstrato — ninguém consegue dar new Alimento(), mas isTouching(Alimento.class) continua detectando qualquer subclasse concreta.",
)

#let body = [

== Abordagem

Mesma estrutura da aula de polimorfismo (`Fruta`, `Vegetal` e uma terceira hierarquia, `Doce`), mas agora `Alimento` é `abstract` e cada subclasse concreta implementa `preparar()` do seu jeito. O `Personagem` detecta pelo tipo abstrato — o polimorfismo não se importa se a classe é abstrata.

#figure(
  raw(read("code/aula-poo-10-solu-01/Alimento.java"), lang: "java", block: true),
  caption: [`Alimento` abstrata, com `preparar()` sem implementação e o experimento comentado.]
)

#figure(
  raw(read("code/aula-poo-10-solu-01/Fruta.java"), lang: "java", block: true),
  caption: [`Fruta`, também abstrata — base para as frutas concretas.]
)

#figure(
  raw(read("code/aula-poo-10-solu-01/Maca.java"), lang: "java", block: true),
  caption: [`Maca` implementa `preparar()` — assim como `Banana` e `Uva`, cada uma com sua própria mensagem.]
)

#figure(
  raw(read("code/aula-poo-10-solu-01/Vegetal.java"), lang: "java", block: true),
  caption: [`Vegetal`, base para `Cenoura`, `Brocolis` e `Tomate`.]
)

#figure(
  raw(read("code/aula-poo-10-solu-01/Cenoura.java"), lang: "java", block: true),
  caption: [`Cenoura`, implementando seu próprio `preparar()`.]
)

#figure(
  raw(read("code/aula-poo-10-solu-01/Doce.java"), lang: "java", block: true),
  caption: [`Doce`, a terceira hierarquia, também abstrata.]
)

#figure(
  raw(read("code/aula-poo-10-solu-01/Bolo.java"), lang: "java", block: true),
  caption: [`Bolo`, `Sorvete` e `Chocolate` seguem o mesmo molde.]
)

== O personagem, detectando pela classe abstrata

#figure(
  raw(read("code/aula-poo-10-solu-01/Personagem.java"), lang: "java", block: true),
  caption: [`Personagem`, usando `isTouching(Alimento.class)` e chamando `preparar()` polimorficamente.]
)

== O mundo

#figure(
  raw(read("code/aula-poo-10-solu-01/MundoBanquete.java"), lang: "java", block: true),
  caption: [`MundoBanquete`, sorteando entre as nove subclasses concretas.]
)

== Pontos-chave

- `new Alimento(10, Color.WHITE)` (comentado no código) não compila — o Java recusa instanciar uma classe abstrata, ponto final. Só as subclasses concretas (`Maca`, `Cenoura`, `Bolo`, ...) podem nascer de verdade.
- Mesmo assim, `isTouching(Alimento.class)` funciona perfeitamente: ele detecta qualquer objeto cuja classe real seja uma subclasse concreta de `Alimento` — a classe abstrata serve só como "categoria" para a busca, nunca como objeto real.
- `a.preparar()` chama o método certo pra cada alimento sem nenhum `if`/`instanceof` — é o mesmo polimorfismo da aula anterior, só que agora garantido pelo compilador: como `Alimento` é abstrata, *toda* subclasse concreta é obrigada a ter seu próprio `preparar()`.

]

#post-layout(meta, body)
