#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: Corrida de Animais (Greenfoot)",
  date: "2026-07-15",
  tags: ("java", "heranca", "greenfoot", "poo", "solucao"),
  excerpt: "Completando a corrida: Corredor já define a estrutura comum, falta só criar Tartaruga e Lebre no mesmo molde do Gato e montar o mundo da pista.",
)

#let body = [

== Abordagem

O enunciado já entrega `Corredor` (classe base, com `velocidade` protegido e `act()` movendo o corredor), `CorredorGato` (um exemplo de subclasse) e `Chegada` (detecta quem cruza a linha primeiro). Falta escrever as duas subclasses restantes — `CorredorTartaruga` e `CorredorLebre` — seguindo exatamente o mesmo padrão do `CorredorGato`, e montar o `MundoCorrida` que organiza a pista.

#figure(
  raw(read("code/aula-poo-07-solu-01/Corredor.java"), lang: "java", block: true),
  caption: [Classe base `Corredor`, dada no enunciado.]
)

#figure(
  raw(read("code/aula-poo-07-solu-01/CorredorGato.java"), lang: "java", block: true),
  caption: [`CorredorGato`, dada no enunciado — o modelo a seguir.]
)

== As subclasses que faltavam

Cada uma só precisa chamar `super(velocidade, tipo)` com seus próprios valores, e pintar a imagem herdada de `Actor` com a cor correspondente:

#figure(
  raw(read("code/aula-poo-07-solu-01/CorredorTartaruga.java"), lang: "java", block: true),
  caption: [`CorredorTartaruga`: velocidade 2, verde.]
)

#figure(
  raw(read("code/aula-poo-07-solu-01/CorredorLebre.java"), lang: "java", block: true),
  caption: [`CorredorLebre`: velocidade 8, azul.]
)

== A linha de chegada

#figure(
  raw(read("code/aula-poo-07-solu-01/Chegada.java"), lang: "java", block: true),
  caption: [`Chegada`, dada no enunciado — detecta o primeiro corredor a tocá-la.]
)

== Montando o mundo

#figure(
  raw(read("code/aula-poo-07-solu-01/MundoCorrida.java"), lang: "java", block: true),
  caption: [`MundoCorrida`: desenha as três faixas, posiciona os corredores e a linha de chegada.]
)

== Pontos-chave

- `CorredorTartaruga` e `CorredorLebre` não sobrescrevem `act()` nem redeclaram `velocidade` — eles só *configuram* o que já existe na classe mãe, passando valores diferentes pro construtor via `super(...)`. Isso é herança funcionando: a lógica de mover mora só em `Corredor`, uma vez.
- `Chegada` não sabe (nem precisa saber) se o corredor que a tocou é tartaruga, gato ou lebre — ela só enxerga `Corredor` e chama `getTipo()`, que cada subclasse já herdou pronto.
- No `MundoCorrida`, cada corredor entra numa faixa (coordenada Y) diferente — as velocidades diferentes (2, 5, 8) é que decidem quem chega primeiro na linha em `x = 580`.

]

#post-layout(meta, body)
