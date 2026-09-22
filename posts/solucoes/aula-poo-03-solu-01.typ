#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: Objetos, Referência, Comparação e toString",
  date: "2026-04-01",
  tags: ("java", "objeto", "equals", "tostring", "poo", "solucao"),
  excerpt: "Guerreiro com identidade própria: equals comparando nome e clã, toString formatado, e o clássico == vs equals lado a lado.",
)

#let body = [

== Abordagem

`Guerreiro` guarda nome, vida, força e clã. O critério de igualdade pedido é "mesmo nome e mesmo clã" — não confundir com `==`, que compara referência (endereço), nunca conteúdo.

#figure(
  raw(read("code/aula-poo-03-solu-01/Guerreiro.java"), lang: "java", block: true),
  caption: [Classe `Guerreiro`, com `atacar`, `toString` e `equals` sobrescritos.]
)

== Testando

#figure(
  raw(read("code/aula-poo-03-solu-01/Testa.java"), lang: "java", block: true),
  caption: [Quatro guerreiros — dois deles idênticos em conteúdo, mas objetos diferentes.]
)

Saída (os acentos podem aparecer estranhos no terminal do Windows sem UTF-8, mas o conteúdo está correto):

```
[Cimérios] Conan - Vida: 100 | Força: 25
[Cimérios] Conan - Vida: 100 | Força: 25
[Anões da Montanha] Thorin - Vida: 120 | Força: 20
[Elfos Silvanos] Legolas - Vida: 90 | Força: 18

conan1 == conan2 ? false
conan1.equals(conan2) ? true
conan1.equals(thorin) ? false

Conan ataca Thorin!
[Anões da Montanha] Thorin - Vida: 95 | Força: 20
```

== Pontos-chave

- `conan1` e `conan2` têm exatamente o mesmo nome e clã, mas `==` retorna `false` — são dois `new` diferentes, dois endereços diferentes.
- `equals` retorna `true` para `conan1`/`conan2` porque o critério escolhido (nome + clã) foi satisfeito — mesmo sendo objetos distintos na memória.
- `toString` sobrescrito faz o `IO.println(guerreiro)` já imprimir a versão formatada, sem precisar chamar nada manualmente.
- `atacar` só altera o alvo (`alvo.vida -= this.forca`) — quem ataca não perde nada, só o alvo recebe o dano.

]

#post-layout(meta, body)
