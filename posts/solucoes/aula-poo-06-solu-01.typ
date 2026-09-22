#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: O Tesouro do Dragão Ancestral",
  date: "2026-05-20",
  tags: ("java", "encapsulamento", "poo", "solucao"),
  excerpt: "Ouro e diamantes trancados atrás de private — depósito e saque validados, e nenhum jeito de tirar diamante do lugar.",
)

#let body = [

== Abordagem

`quantidadeOuro` e `quantidadeDiamantes` são `private` — ninguém mexe neles direto, só através dos métodos. `depositarOuro` e `sacarOuro` validam antes de agir; `adicionarDiamantes` existe, mas propositalmente não existe nenhum método de saque de diamantes.

#figure(
  raw(read("code/aula-poo-06-solu-01/Tesouro.java"), lang: "java", block: true),
  caption: [Classe `Tesouro`, com validação em cada operação.]
)

== Testando

#figure(
  raw(read("code/aula-poo-06-solu-01/Testa.java"), lang: "java", block: true),
  caption: [Depósitos, saques válidos e inválidos.]
)

Saída:

```
Tesouro do Dragão: 500 moedas de ouro, 10 diamantes.
Tesouro do Dragão: 700 moedas de ouro, 10 diamantes.
O Dragão não aceita oferendas vazias ou dívidas!
Tesouro do Dragão: 400 moedas de ouro, 10 diamantes.
Tentar roubar mais do que existe é um convite ao fogo do dragão!
Tesouro do Dragão: 400 moedas de ouro, 13 diamantes.
```

== Pontos-chave

- O construtor com parâmetros *reaproveita* `depositarOuro` e `adicionarDiamantes` em vez de atribuir os atributos direto — assim, as mesmas validações que protegem o tesouro depois de criado também valem no nascimento dele.
- `sacarOuro` combina as duas checagens (`valor <= 0` e `valor > quantidadeOuro`) numa condição só — tanto faz o motivo, a resposta é a mesma recusa.
- A ausência de um `sacarDiamantes()` *é* o requisito — não existe nenhuma forma de contornar essa regra de fora da classe, porque o comportamento simplesmente não foi escrito.

]

#post-layout(meta, body)
