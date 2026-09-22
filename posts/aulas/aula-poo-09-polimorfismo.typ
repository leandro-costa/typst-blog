#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Polimorfismo: a metamorfose dos objetos",
  date: "2026-07-21",
  tags: ("java", "polimorfismo", "heranca", "dynamic-binding"),
  excerpt: "Um peixe nada, um sapo pula, um pássaro voa — e você só precisa dizer 'mova-se!'. Chegou a hora de entender como um único código lida com formas diferentes.",
)

#let body = [

== O que é polimorfismo?

*Polimorfismo* é um dos pilares da Orientação a Objetos. A palavra vem do grego _polys_ (muitos) + _morphê_ (forma) — "muitas formas". Em POO, é a capacidade de um objeto ser *referenciado* de várias formas diferentes. Cuidado: isso não significa que o objeto se transforma — ele nasce de um tipo e morre daquele mesmo tipo. O que muda é a maneira como *nos referimos* a ele.

Na prática: uma variável de um tipo genérico (a superclasse) pode guardar uma referência para um objeto de qualquer tipo específico compatível (uma subclasse). Quando você chama um método através dessa referência genérica, quem roda de verdade é o comportamento da *classe real do objeto* — não da referência. Essa decisão acontece em *tempo de execução*: é a chamada *ligação tardia* (dynamic binding).

Imagine um cosmos com Peixes, Anfíbios e Pássaros — todos compartilham a essência de serem `Animal`, todos sabem se mover, mas cada um do seu jeito: o peixe nada, o anfíbio pula, o pássaro voa. Você não precisa saber, a cada instante, qual bicho específico está na sua frente — só manda "mova-se!", e cada um responde de acordo com sua própria natureza. Essa é a essência do polimorfismo: tratar objetos de tipos especializados de forma genérica, confiando que cada um sabe executar suas próprias habilidades.

== Exemplo 1: figuras geométricas

#figure(
  raw(read("code/aula-poo-09-polimorfismo/Figura.java"), lang: "java", block: true),
  caption: [Classe `Figura` e suas subclasses.]
)

#figure(
  image("img/aula-poo-09-polimorfismo/figura_01.svg"),
  caption: [UML da hierarquia de figuras geométricas.],
)

`Círculo`, `Retângulo` e `Quadrado` são todos `Figura`. O resultado de `desenhar()` depende do tipo real de cada uma:

#figure(
  raw(read("code/aula-poo-09-polimorfismo/TesteFiguras.java"), lang: "java", block: true),
  caption: [Chamando `desenhar()` em uma lista de figuras diferentes.]
)

Saída:

```
⬤ Desenhando um círculo
▬ Desenhando um retângulo
◻ Desenhando um quadrado
```

== Exemplo 2: simulação de animais

#figure(
  raw(read("code/aula-poo-09-polimorfismo/Animal.java"), lang: "java", block: true),
  caption: [Classe `Animal` e suas subclasses, cada uma com seu `mover()`.]
)

#figure(
  image("img/aula-poo-09-polimorfismo/animal_02.svg"),
  caption: [UML da hierarquia `Animal`, com polimorfismo no método `mover()`.],
)

#figure(
  raw(read("code/aula-poo-09-polimorfismo/Simulador.java"), lang: "java", block: true),
  caption: [Chamando `mover()` numa coleção de animais diferentes.]
)

Saída:

```
Nemo nadou 2 metros!
Frogg pulou 1 metro!
Sky voou 3 metros!
```

Cada animal responde ao `mover()` de acordo com sua própria instância. Mesmo todos sendo tratados como `Animal`, o comportamento executado é sempre do tipo real do objeto.

#figure(
  image("img/aula-poo-09-polimorfismo/diag03_03.svg"),
  caption: [Na memória: a mesma variável aponta para objetos de tipos diferentes em cada iteração.],
)

== Exemplo 3: funcionários e bonificações

Suponha um sistema bancário em que todo funcionário tem uma bonificação, mas gerentes seguem uma regra diferente:

#figure(
  raw(read("code/aula-poo-09-polimorfismo/Funcionario.java"), lang: "java", block: true),
  caption: [Classe `Funcionario`.]
)

Uma variável do tipo `Funcionario` guarda uma referência — nunca o objeto em si. Como todo `Gerente` *é um* `Funcionario`, podemos referenciá-lo assim:

```java
Gerente gerente = new Gerente();
Funcionario funcionario = gerente; // polimorfismo!
funcionario.setSalario(5000.0);
```

#figure(
  image("img/aula-poo-09-polimorfismo/diag04_04.svg"),
  caption: [Duas variáveis diferentes apontando para o mesmo objeto na memória.],
)

Mesmo referenciando o `Gerente` como `Funcionario`, o método executado continua sendo o da classe real:

```java
IO.println(funcionario.getBonificacao()); // 750.0 (método do Gerente!)
```

O Java decide qual método rodar em tempo de execução, olhando pro objeto real na memória — não pro tipo da variável.

=== Controle de bonificações

O poder do polimorfismo aparece quando criamos métodos genéricos, que funcionam pra qualquer subtipo sem precisar saber qual é:

#figure(
  raw(read("code/aula-poo-09-polimorfismo/ControleDeBonificacoes.java"), lang: "java", block: true),
  caption: [Um único método processando bonificações de qualquer tipo de funcionário.]
)

#figure(
  raw(read("code/aula-poo-09-polimorfismo/bloco07.java"), lang: "java", block: true),
  caption: [Usando `ControleDeBonificacoes` com uma lista mista de funcionários e gerentes.]
)

Vale registrar: herança aumenta o acoplamento entre as classes — a relação entre mãe e filha é forte, e uma mudança na classe pai pode afetar todas as filhas. Isso é um problema da herança, não do polimorfismo, e vamos resolver mais pra frente com interfaces.

== Exemplo 4: empregados da faculdade

#figure(
  raw(read("code/aula-poo-09-polimorfismo/EmpregadoDaFaculdade.java"), lang: "java", block: true),
  caption: [Classe base `EmpregadoDaFaculdade`.]
)

#figure(
  raw(read("code/aula-poo-09-polimorfismo/GeradorDeRelatorio.java"), lang: "java", block: true),
  caption: [`GeradorDeRelatorio`, que processa qualquer tipo de empregado.]
)

```java
GeradorDeRelatorio relatorio = new GeradorDeRelatorio();
relatorio.adiciona(new ProfessorDaFaculdade());
relatorio.adiciona(new Reitor());
```

Quem programou `GeradorDeRelatorio` nunca imaginou que existiria um `Reitor` — e mesmo assim o sistema funciona. Esse é o poder do polimorfismo: programar para o futuro sem precisar conhecê-lo.

== Exemplo 5: controle de ponto

Sem polimorfismo, você precisaria de um método pra cada cargo:

#figure(
  raw(read("code/aula-poo-09-polimorfismo/ControleDePonto.java"), lang: "java", block: true),
  caption: [Sem polimorfismo: um método por cargo.]
)

Com polimorfismo, um único método atende qualquer funcionário:

#figure(
  raw(read("code/aula-poo-09-polimorfismo/Funcionario_2.java"), lang: "java", block: true),
  caption: [Hierarquia de `Funcionario` pronta para polimorfismo.]
)

#figure(
  image("img/aula-poo-09-polimorfismo/funcionario_05.svg"),
  caption: [UML da hierarquia de funcionários.],
)

#figure(
  raw(read("code/aula-poo-09-polimorfismo/ControleDePonto_2.java"), lang: "java", block: true),
  caption: [Um único `registraEntrada` para qualquer tipo de funcionário.]
)

```java
ControleDePonto ponto = new ControleDePonto();
ponto.registraEntrada(new Gerente());
ponto.registraEntrada(new Telefonista());
```

As vantagens são diretas: um cargo novo não exige alterar `ControleDePonto`; um cargo que deixa de existir não precisa de remoção especial; qualquer ajuste na lógica de registro acontece num único lugar.

== Exemplo 6: polimorfismo no Greenfoot — o grande banquete

No Greenfoot, todo `Actor` tem o método `isTouching(Class cls)`, que verifica se o ator está tocando outro ator *daquela classe ou de qualquer subclasse dela*. Isso é polimorfismo em ação: o tipo que você passa como parâmetro determina o alcance da detecção.

#figure(
  raw(read("code/aula-poo-09-polimorfismo/bloco13.java"), lang: "java", block: true),
  caption: [Detectando apenas um tipo específico de ator.]
)

#figure(
  raw(read("code/aula-poo-09-polimorfismo/bloco14.java"), lang: "java", block: true),
  caption: [Trocando o tipo passado para detectar uma família inteira de atores.]
)

A beleza aqui é que o polimorfismo não está num método que *recebe* um parâmetro polimórfico — está dentro do próprio `isTouching`, que pergunta internamente: "o ator tocando é instância dessa classe ou de alguma subclasse dela?". Com `isTouching(Maca.class)`, só objetos exatamente `Maca` são detectados. Com `isTouching(Fruta.class)`, qualquer `Maca`, `Banana` ou `Uva` é detectada — porque todas *são* `Fruta`. Não é o método `comer` que muda de assinatura: é o detector que usa polimorfismo pra enxergar todas as formas de fruta de uma vez.

]

#post-layout(meta, body)
