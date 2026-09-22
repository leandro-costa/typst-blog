#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: Modelagem de um Aparelho de DVD",
  date: "2026-05-27",
  tags: ("java", "encapsulamento", "construtor", "poo", "solucao"),
  excerpt: "AparelhoDVD que respeita cada regra: nada de volume fora de 1-5, nada de play sem filme, nada de stop fora de play.",
)

#let body = [

== Abordagem

Cada operação começa checando `ligado` — se o aparelho está desligado, nada acontece (nem erro, nem exceção: simplesmente a operação não tem efeito). `volume` fica travado entre 1 e 5. `play()` só funciona com um filme inserido, e devolve o texto formatado com nome e duração; `stop()` só funciona se já estiver em play.

#figure(
  raw(read("code/aula-poo-06-solu-02/Filme.java"), lang: "java", block: true),
  caption: [Classe `Filme`.]
)

#figure(
  raw(read("code/aula-poo-06-solu-02/AparelhoDVD.java"), lang: "java", block: true),
  caption: [Classe `AparelhoDVD`, com todas as regras de estado.]
)

== Testando

#figure(
  raw(read("code/aula-poo-06-solu-02/Testa.java"), lang: "java", block: true),
  caption: [Exercitando as regras: desligado, ligado, volume, play sem filme, play com filme, stop.]
)

Saída:

```
Volume (desligado, deve continuar 2): 2
Ligado? true
Volume após aumentar duas vezes: 4
Play sem filme inserido: null
Play com filme inserido: Filme: De Volta para o Futuro, Duração:116.0
Em play após stop? false
```

== Pontos-chave

- O construtor já deixa o aparelho num estado válido: desligado, volume 2, sem filme, fora de play — nunca existe um `AparelhoDVD` "quebrado".
- Cada método reforça sua própria pré-condição (`if (ligado)`, `if (filme != null)`, `if (emPlay)`) em vez de confiar que quem chamou já verificou — é assim que o objeto se protege sozinho.
- `play()` retorna `null` quando não pode tocar, em vez de lançar exceção — simples o suficiente pro nível da aula, mas já mostra a ideia de "o método recusa educadamente".

]

#post-layout(meta, body)
