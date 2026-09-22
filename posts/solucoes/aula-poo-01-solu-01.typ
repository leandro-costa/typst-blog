#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: Paradigmas de Programação",
  date: "2026-02-13",
  tags: ("java", "paradigmas", "poo", "solucao"),
  excerpt: "Dois guerreiros brigando primeiro no Caos (C, struct + funções soltas) e depois na Ordem (Java, classe com atributos e métodos juntos).",
)

#let body = [

== Abordagem

O exercício pede o mesmo sistema em dois paradigmas: uma `struct Guerreiro` em C, com funções separadas, e uma classe `Guerreiro` em Java, com os métodos dentro da classe. Em ambas as versões, `atacar` reduz a vida do alvo pela força de quem ataca, e `exibirStatus` mostra nome, vida e força antes e depois do combate.

== Versão em C (paradigma estruturado)

#figure(
  raw(read("code/aula-poo-01-solu-01/guerreiro.c"), lang: "C", block: true),
  caption: [`struct Guerreiro` com `atacar` e `exibirStatus` como funções externas.]
)

Repare que `atacar` recebe *dois ponteiros* — atacante e alvo — porque, no paradigma estruturado, uma função não "pertence" a nenhum dos dois; ela só manipula os dados que recebe.

== Versão em Java (orientado a objetos)

#figure(
  raw(read("code/aula-poo-01-solu-01/Guerreiro.java"), lang: "java", block: true),
  caption: [Classe `Guerreiro`, com `atacar` e `exibirStatus` pertencendo ao objeto.]
)

#figure(
  raw(read("code/aula-poo-01-solu-01/Testa.java"), lang: "java", block: true),
  caption: [Criando dois guerreiros e fazendo um atacar o outro.]
)

Saída:

```
--- Antes do ataque ---
Conan | Vida: 100 | Forca: 25
Thorin | Vida: 100 | Forca: 20
--- Depois do ataque ---
Conan | Vida: 100 | Forca: 25
Thorin | Vida: 75 | Forca: 20
```

== O que muda de verdade

Na versão C, `atacar(&conan, &thorin)` — o "ataque" é algo que alguém de fora faz *aos* dois guerreiros. Na versão Java, `conan.atacar(thorin)` — o ataque é algo que o próprio `conan` *faz*. É exatamente a diferença que a aula levanta: em Java, o guerreiro sabe se virar sozinho; em C, alguém de fora precisa dizer à função o que fazer com os dados.

]

#post-layout(meta, body)
