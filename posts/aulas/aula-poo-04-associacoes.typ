#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Associações: Agregação e Composição",
  date: "2026-03-10",
  tags: ("java", "associacao", "agregacao", "composicao"),
  excerpt: "Suas criaturas já nascem, vivem e se comunicam. Agora é hora de conectá-las — e descobrir o que acontece quando uma precisa da outra para existir.",
)

#let body = [

== O que é uma associação?

Até aqui, seus objetos viviam de forma relativamente independente: cada um com seus atributos e métodos. Mas no mundo real — e no universo do código — as coisas se relacionam. Um carro tem um motor. Um carrinho de compras contém itens. Um produto tem um fornecedor.

Uma *associação* é a forma como uma classe se relaciona com outra. Na prática: uma classe possui um atributo cujo tipo é outra classe. Quando isso acontece, dizemos que uma classe está *associada* à outra.

Existem três tipos principais de associação:

#figure(
  table(
    columns: 4,
    [*Tipo*], [*Símbolo UML*], [*Dependência*], [*Analogia*],
    [Associação], [→], [Relação genérica], [Um elo qualquer],
    [Agregação], [◇→], [A parte existe sem o todo], [Item na mochila],
    [Composição], [◆→], [A parte morre com o todo], [Órgão no corpo],
  ),
  caption: [Os três tipos de associação em POO.]
)

== Agregação: as partes existem sozinhas

Na *agregação*, o objeto contido não depende da existência do objeto principal — ele é passado de fora, como um item que você carrega na mochila. Se você "morre" no jogo, o item continua existindo no mundo, pronto pra outro pegar.

- A classe contida *não é instanciada* dentro da classe principal.
- É tipicamente *passada por parâmetro* (no construtor ou num setter).
- O todo *usa* a parte, mas não a *cria*.

Exemplo concreto: um `Produto` tem um `Fornecedor`. Se o produto deixar de existir, o fornecedor continua vivo — ele fornece pra outros produtos também.

== Composição: sem o todo, a parte morre

Na *composição*, o objeto contido depende da existência do principal. Ele é criado *dentro* do objeto principal — como um órgão dentro de um corpo. Se o corpo morre, o órgão morre junto.

- A classe contida *é instanciada* pela classe principal.
- Quando o principal some da memória, as partes somem junto.
- O todo *contém* as partes, não só as referencia.

Exemplo concreto: um `Carrinho` de compras contém `ItemCompra`. Se o carrinho é destruído, os itens perdem o sentido — eles só existem *dentro* daquele carrinho.

== A pergunta decisiva

Pra decidir entre agregação e composição, faça esta pergunta: *se o todo for destruído, a parte ainda faz sentido sozinha?*

- *Sim* → agregação (item de inventário).
- *Não* → composição (órgão vital).

Um guerreiro sem coração é só pedra — mas um guerreiro sem espada ainda é um guerreiro, só que desarmado. O coração é composição; a espada é agregação. As relações entre objetos definem a arquitetura do seu sistema: um monte de classes isoladas, sem relação nenhuma entre si, não tem vida nem propósito.

== Associação simples: Carro e Motor

Vamos começar com o clássico: um carro que possui um motor.

#figure(
  image("img/aula-poo-04-associacoes/carro_01.svg"),
  caption: [Diagrama UML: associação entre `Carro` e `Motor`.],
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Motor.java"), lang: "java", block: true),
  caption: [Classe `Motor`.]
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Carro.java"), lang: "java", block: true),
  caption: [Classe `Carro`, recebendo um `Motor` no construtor.]
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Universo.java"), lang: "java", block: true),
  caption: [Criando um `Motor` e passando para um `Carro`.]
)

O `Motor` foi criado *fora* do `Carro` e passado como parâmetro. O motor existe independentemente do carro — se o carro fosse destruído, o motor continuaria existindo no programa.

== Agregação: Produto e Fornecedor

Na agregação, a relação é ainda mais explícita: a parte existe antes e depois do todo.

#figure(
  image("img/aula-poo-04-associacoes/produto_02.svg"),
  caption: [Diagrama UML: agregação entre `Produto` e `Fornecedor`.],
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Fornecedor.java"), lang: "java", block: true),
  caption: [Classe `Fornecedor`.]
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Produto.java"), lang: "java", block: true),
  caption: [Classe `Produto`, recebendo um `Fornecedor` no construtor.]
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Universo_2.java"), lang: "java", block: true),
  caption: [Um fornecedor associado a múltiplos produtos.]
)

Na agregação, a parte é passada por parâmetro. O todo não a cria — só a referencia. Se o todo for destruído, a parte segue existindo tranquilamente no programa.

== Composição: Carrinho e ItemCompra

Na composição, a parte só existe dentro do todo — ela é *criada* pelo próprio todo.

#figure(
  image("img/aula-poo-04-associacoes/carrinho_03.svg"),
  caption: [Diagrama UML: composição entre `Carrinho` e `ItemCompra`, agregação entre `ItemCompra` e `Produto`.],
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Produto_2.java"), lang: "java", block: true),
  caption: [Classe `Produto`.]
)

#figure(
  raw(read("code/aula-poo-04-associacoes/ItemCompra.java"), lang: "java", block: true),
  caption: [Classe `ItemCompra`, associada a um `Produto`.]
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Carrinho.java"), lang: "java", block: true),
  caption: [Classe `Carrinho`, que cria seus próprios `ItemCompra`.]
)

#figure(
  raw(read("code/aula-poo-04-associacoes/Universo_3.java"), lang: "java", block: true),
  caption: [Adicionando produtos a um carrinho.]
)

A diferença no código é clara: o `Carrinho` *cria* o `ItemCompra` dentro de `adicionarProduto()` — o item nasce dentro do carrinho e morre com ele. Já o `ItemCompra` *recebe* o `Produto` por parâmetro — o produto existe antes e depois do item. Composição e agregação, lado a lado, no mesmo sistema.

== Resumo visual

#figure(
  image("img/aula-poo-04-associacoes/diag04_04.svg"),
  caption: [Comparação visual entre agregação e composição.],
)

#figure(
  table(
    columns: 3,
    [*Critério*], [*Agregação*], [*Composição*],
    [A parte existe sozinha?], [Sim], [Não],
    [Quem cria a parte?], [Classe externa], [O próprio todo],
    [Passagem], [Parâmetro (externo)], [Instanciação interna],
    [Se o todo morre...], [A parte sobrevive], [A parte morre junto],
    [UML], [Losango vazio (◇)], [Losango preenchido (◆)],
  ),
  caption: [Agregação vs composição, resumido.]
)

]

#post-layout(meta, body)
