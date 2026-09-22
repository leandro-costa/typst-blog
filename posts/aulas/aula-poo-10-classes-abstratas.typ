#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Classes Abstratas: profecias incompletas",
  date: "2026-07-28",
  tags: ("java", "classe-abstrata", "metodo-abstrato", "heranca"),
  excerpt: "Ninguém já viu uma 'figura genérica' desenhada — sempre é um círculo, um retângulo, algo específico. É hora de aprender a declarar o que falta sem ainda saber como.",
)

#let body = [

== O que é uma classe abstrata?

Uma *classe abstrata* é uma classe que *não pode ser instanciada*. Ela existe pra servir de molde base pra outras classes — agrupa características e comportamentos comuns, mas não faz sentido criar objetos diretamente dela.

Uma classe abstrata pode conter:

- *Atributos e métodos concretos* (com implementação), herdados normalmente pelas subclasses.
- *Métodos abstratos*: declarados sem corpo, que *obrigatoriamente* precisam ser implementados por qualquer subclasse concreta.

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/MinhaClasse.java"), lang: "java", block: true),
  caption: [Uma classe abstrata com um método abstrato.]
)

Se uma classe concreta herda de uma abstrata e não implementa *todos* os métodos abstratos, o código simplesmente não compila. A única saída, nesse caso, é tornar essa classe filha também abstrata.

Pense assim: uma classe abstrata é como uma promessa — declara o que deve ser feito, mas quem cumpre é a subclasse.

```java
Criatura c = new Criatura();     // Erro! Não dá pra instanciar uma promessa.
Criatura c2 = new Dragao();      // Correto: a referência é genérica, o objeto é real.
```

A grande vantagem é que o polimorfismo continua funcionando perfeitamente: você pode ter um `Criatura[]` guardando `Dragao`, `Fenix` e `Golem` ao mesmo tempo, e chamar `mover()` em cada um.

== Exemplo 1: figuras geométricas, evoluídas

Na aula de polimorfismo, `Figura` tinha um `desenhar()` concreto que dizia "Desenhando uma figura genérica...". Só que ninguém desenha uma figura genérica de verdade — sempre é um círculo, um retângulo, algo específico. Faz sentido tornar `Figura` abstrata:

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/Figura.java"), lang: "java", block: true),
  caption: [`Figura` como classe abstrata, com `desenhar()` sem implementação.]
)

#figure(
  image("img/aula-poo-10-classes-abstratas/figura_01.svg"),
  caption: [UML da hierarquia abstrata de figuras.],
)

Testando o polimorfismo com a classe abstrata:

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/TesteFiguras.java"), lang: "java", block: true),
  caption: [Cada subclasse concreta desenhando à sua maneira.]
)

Saída:

```
⬤ Desenhando um círculo vermelho de raio 5.0
▬ Desenhando um retângulo azul (4.0 x 3.0)
```

== Exemplo 2: Pessoa, Aluno e Professor

Numa faculdade, uma `Pessoa` genérica não existe de verdade — ou é `Aluno`, ou é `Professor`. `Pessoa` vira abstrata:

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/Pessoa.java"), lang: "java", block: true),
  caption: [`Pessoa` abstrata, base para `Aluno` e `Professor`.]
)

#figure(
  image("img/aula-poo-10-classes-abstratas/pessoa_02.svg"),
  caption: [UML da hierarquia abstrata `Pessoa`.],
)

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/TesteFaculdade.java"), lang: "java", block: true),
  caption: [Tratando `Aluno` e `Professor` de forma polimórfica via `Pessoa`.]
)

Saída:

```
Clara entrou na faculdade.
Clara estacionou na área dos estudantes.
Dr. Santos entrou na faculdade.
Dr. Santos estacionou nas vagas de professores.
```

== Exemplo 3: funcionários, de novo

No sistema bancário, a empresa só tem `Gerente`, `Diretor`, `Presidente` — nunca "apenas um funcionário". `Funcionario` vira classe abstrata:

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/Funcionario.java"), lang: "java", block: true),
  caption: [`Funcionario` abstrata.]
)

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/ControleDeBonificacoes.java"), lang: "java", block: true),
  caption: [Processando bonificações via referência abstrata.]
)

== Exemplo 4: contas bancárias

Numa `Conta` genérica também não faz sentido existir de verdade — é sempre `ContaPoupanca`, `ContaCorrente` ou `ContaSalario`. Tornar `Conta` abstrata é a escolha natural:

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/Conta.java"), lang: "java", block: true),
  caption: [`Conta` como classe abstrata.]
)

== Exemplo 5: máquina de bebidas quentes

Uma máquina que prepara bebidas tem partes iguais para todas (ferver água, servir) e uma parte que varia por bebida (preparar o ingrediente):

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/BebidaQuente.java"), lang: "java", block: true),
  caption: [`BebidaQuente` abstrata, com o passo variável isolado num método abstrato.]
)

#figure(
  raw(read("code/aula-poo-10-classes-abstratas/TesteBebidas.java"), lang: "java", block: true),
  caption: [Preparando café, chá e chocolate com o mesmo fluxo geral.]
)

Saída:

```
--- Preparando ---
Fervendo água...
Adicionando pó de café ao filtro.
Passando água quente pelo pó...
Servindo na xícara.
Aproveite sua bebida!

--- Preparando ---
Fervendo água...
Colocando o saquinho de chá na xícara.
Despejando água quente...
Servindo na xícara.
Aproveite sua bebida!

--- Preparando ---
Fervendo água...
Adicionando chocolate em pó ao leite.
Misturando bem...
Servindo na xícara.
Aproveite sua bebida!
```

]

#post-layout(meta, body)
