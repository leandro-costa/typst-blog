#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Interface: contratos entre classes",
  date: "2026-08-11",
  tags: ("java", "interface", "polimorfismo", "contrato"),
  excerpt: "Um Bolo não é parente de uma Maçã — mas os dois podem assinar o mesmo contrato e virar comida ao mesmo método. Herança é família; interface é combinado.",
)

#let body = [

== Por que existem padrões

No dia a dia, qualquer aparelho elétrico que você compra encaixa na tomada de casa. Por quê? Porque existe um *padrão*. Se cada fabricante inventasse seu próprio formato de plugue, usar qualquer coisa seria um caos — sem falar nos riscos. Por isso órgãos reguladores definem padrões que todo fabricante precisa respeitar.

Em Orientação a Objetos, a mesma ideia de padronização existe: a *interface*.

Uma interface é um *contrato*: define um conjunto de métodos que qualquer classe que "assinar" esse contrato é obrigada a implementar. Quem programa contra uma interface ganha uma garantia — sabe exatamente quais métodos esperar de qualquer classe que assinou o mesmo contrato, não importa a família dela.

== Herança é família, interface é combinado

Até aqui, os comportamentos vinham do sangue: uma subclasse herdava de uma superclasse. Mas às vezes classes de *linhagens completamente diferentes* precisam do mesmo comportamento. Um `Peixe` e um `Avião` não têm nada em comum na árvore de herança — mas os dois podem "se mover no ar/água" de formas específicas, e um sistema pode querer tratar qualquer coisa "voável" do mesmo jeito, sem se importar de onde ela veio.

Forçar uma herança entre coisas de naturezas incompatíveis é gambiarra. A solução é outra: o *contrato*. Qualquer classe, de qualquer família, pode implementar uma interface e ganhar aquele comportamento combinado:

- Interface `Voavel`: quem implementa, ganha o método `voar()`.
- Interface `Nadavel`: quem implementa, ganha o método `nadar()`.

Uma classe pode implementar *várias* interfaces ao mesmo tempo, sem precisar trocar de superclasse. O contrato não pergunta sua linhagem — só exige que você cumpra o que prometeu.

O melhor de tudo: qualquer objeto que implementa uma interface pode ser tratado pelo tipo dessa interface. Um sistema pode guardar tudo que é `Voavel` numa mesma lista — sejam aviões, pássaros ou drones — e chamar `voar()` em todos, confiando que cada um cumpre o contrato à sua maneira.

Interface não é herança: herança é a família em que você nasceu; interface é o contrato que você decide assinar. E todo comportamento contratado vale pra qualquer classe, de qualquer família.

```java
Conta c = new Conta();          // Erro! Interface não se instancia.
Conta c2 = new ContaCorrente(); // Correto: a referência é o contrato, o objeto é real.
```

== Exemplo 1: o contrato da conta

No sistema do banco, a interface `Conta` padroniza a assinatura de todos os tipos de conta:

#figure(
  raw(read("code/aula-poo-11-interface/bloco01.java"), lang: "java", block: true),
  caption: [Interface `Conta`, definindo o contrato.]
)

As classes que representam tipos de conta assinam o contrato implementando-o:

#figure(
  raw(read("code/aula-poo-11-interface/ContaPoupanca.java"), lang: "java", block: true),
  caption: [`ContaPoupanca` implementando a interface `Conta`.]
)

#figure(
  image("img/aula-poo-11-interface/conta_01.svg"),
  caption: [UML do contrato `Conta` e suas implementações.],
)

== Exemplo 2: se comporta como

Uma `PrevidenciaPrivada` não é uma conta bancária no sentido estrito — mas pode implementar `Conta` e se comportar como uma, para fins de depósito e saque:

#figure(
  raw(read("code/aula-poo-11-interface/PrevidenciaPrivada.java"), lang: "java", block: true),
  caption: [`PrevidenciaPrivada` implementando `Conta` mesmo sem ser uma conta "de verdade".]
)

== Exemplo 3: polimorfismo pela interface

`GeradorDeExtrato` aceita *qualquer* objeto que implementou `Conta` — poupança, corrente, previdência, tanto faz:

#figure(
  raw(read("code/aula-poo-11-interface/GeradorDeExtrato.java"), lang: "java", block: true),
  caption: [`GeradorDeExtrato`, funcionando com qualquer implementação de `Conta`.]
)

#figure(
  raw(read("code/aula-poo-11-interface/TesteExtrato.java"), lang: "java", block: true),
  caption: [Gerando extrato de contas de tipos diferentes com o mesmo código.]
)

== Exemplo 4: quando só a interface resolve

Agora o caso onde herança não ajuda: `Gerente` e `Empresa` vivem em *árvores de herança completamente separadas* — não há como tratá-las de forma polimórfica só com herança. A interface `Usuario` cria a ponte entre elas:

#figure(
  raw(read("code/aula-poo-11-interface/Funcionario.java"), lang: "java", block: true),
  caption: [`Funcionario` implementando a interface `Usuario`.]
)

#figure(
  image("img/aula-poo-11-interface/usuario_02.svg"),
  caption: [UML da interface `Usuario` unindo duas árvores de herança independentes.],
)

#figure(
  raw(read("code/aula-poo-11-interface/TesteAutenticacao.java"), lang: "java", block: true),
  caption: [Autenticando `Gerente` e `Empresa` pelo mesmo contrato `Usuario`.]
)

== Exemplo 5: subinterface — contrato que junta contratos

Uma interface pode estender várias outras, acumulando obrigações. Quem implementa `ContaTributavel` promete tudo que `Conta` exige *e* tudo que `Tributavel` exige:

#figure(
  raw(read("code/aula-poo-11-interface/ContaInvestimento.java"), lang: "java", block: true),
  caption: [`ContaInvestimento` implementando a subinterface `ContaTributavel`.]
)

```java
ContaTributavel ct = new ContaInvestimento();
Conta c = new ContaInvestimento();
Tributavel t = new ContaInvestimento();
```

#figure(
  image("img/aula-poo-11-interface/conta_03.svg"),
  caption: [UML da subinterface `ContaTributavel`.],
)

== Exemplo 6: métodos default

A interface `ExemploInterface` tem um método abstrato e um método `default` com implementação padrão já pronta. `ExemploClasse` só precisa implementar o abstrato — o `default` já vem de graça:

#figure(
  raw(read("code/aula-poo-11-interface/ExemploClasse.java"), lang: "java", block: true),
  caption: [Implementando só o método abstrato; o `default` já está pronto.]
)

Saída:

```
Implementação do método abstrato.
Implementação padrão do método default.
```

]

#post-layout(meta, body)
