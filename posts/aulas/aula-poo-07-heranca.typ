#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Herança",
  date: "2026-05-05",
  tags: ("java", "heranca", "extends", "super", "override", "polimorfismo"),
  excerpt: "Todo morcego é mamífero, mas nem todo mamífero é morcego. Hoje sua classe ganha família — e aprende a reaproveitar código sem copiar e colar.",
)

#let body = [

== O que é herança?

*Herança* é um dos pilares da Orientação a Objetos: a capacidade de uma classe reutilizar a estrutura e o comportamento definidos em outra classe, chamada de *superclasse* (ou classe pai). A classe que herda é a *subclasse* (ou classe filha).

Com herança, a subclasse incorpora tudo o que a superclasse tem — atributos e métodos — e ainda pode acrescentar suas próprias características. Isso permite criar *classes genéricas*, que reúnem definições comuns a vários objetos (*generalização*), e a partir delas construir classes mais específicas que estendem esse comportamento (*especialização*).

Em Java, a herança é *simples*: uma classe só pode estender uma única superclasse — nada de herança múltipla. O objetivo é especializar uma classe, dando a ela novas funcionalidades sem reescrever código que já existe.

== Nem todo mamífero é morcego

#figure(
  raw(read("code/aula-poo-07-heranca/Mamifero.java"), lang: "java", block: true),
  caption: [Classe `Mamifero`.]
)

#figure(
  raw(read("code/aula-poo-07-heranca/Morcego.java"), lang: "java", block: true),
  caption: [Classe `Morcego`, estendendo `Mamifero`.]
)

Um morcego tem altura, peso, tamanho da presa — e sabe mamar e voar. Pela lógica: todo morcego é mamífero, mas nem todo mamífero é morcego. Isso tem consequências diretas no código:

```java
Mamifero animalMamifero = new Morcego();
Morcego batman = new Mamifero(); // erro de compilação
```

A primeira linha funciona: a variável é do tipo `Mamifero`, mas o objeto é um `Morcego` — e todo `Morcego` *é um* `Mamifero`, então a atribuição é válida. A segunda não: nem todo `Mamifero` é um `Morcego`, então o Java recusa.

```java
Mamifero animalMamifero = new Morcego();
animalMamifero.mamar();
animalMamifero.voar(); // erro: Mamifero não tem voar()
```

Mesmo sendo um morcego por baixo dos panos, a variável `animalMamifero` só enxerga o que a classe `Mamifero` oferece. Para usar `voar()`, é preciso um *type cast* — converter explicitamente a variável para `Morcego`:

#figure(
  raw(read("code/aula-poo-07-heranca/bloco03.java"), lang: "java", block: true),
  caption: [Type cast: convertendo `Mamifero` de volta para `Morcego` para acessar `voar()`.]
)

#figure(
  image("img/aula-poo-07-heranca/mamifero_01.svg"),
  caption: [Hierarquia: `Morcego` é um `Mamifero`.],
)

#figure(
  image("img/aula-poo-07-heranca/diag02_02.svg"),
  caption: [Relação entre a variável de referência e o objeto real.],
)

== Reaproveitando código: Funcionario e Gerente

Todo banco tem funcionários. Vamos modelar:

#figure(
  raw(read("code/aula-poo-07-heranca/Funcionario.java"), lang: "java", block: true),
  caption: [Classe `Funcionario`.]
)

Além de funcionários comuns, existem gerentes: eles guardam as mesmas informações, mas têm extras — uma senha numérica de acesso ao sistema interno e o número de funcionários que gerenciam. Poderíamos jogar tudo isso dentro de `Funcionario` e deixar em branco quando não se aplica, mas isso rapidamente vira uma bagunça de atributos opcionais e métodos que só fazem sentido pra alguns objetos.

Em vez disso, usamos `extends` pra fazer `Gerente` *herdar* tudo que `Funcionario` já tem:

#figure(
  raw(read("code/aula-poo-07-heranca/Gerente.java"), lang: "java", block: true),
  caption: [Classe `Gerente`, estendendo `Funcionario` com `extends`.]
)

Todo objeto `Gerente` automaticamente carrega os atributos definidos em `Funcionario`, porque um `Gerente` *é um* `Funcionario`:

#figure(
  image("img/aula-poo-07-heranca/diag03_03.svg"),
  caption: [`Gerente` estendendo `Funcionario`.],
)

#figure(
  image("img/aula-poo-07-heranca/diag04_04.svg"),
  caption: [Objeto `Gerente` carregando atributos herdados de `Funcionario`.],
)

#figure(
  raw(read("code/aula-poo-07-heranca/TestaGerente.java"), lang: "java", block: true),
  caption: [Testando um `Gerente` que herda comportamento de `Funcionario`.]
)

`Gerente` herda todos os atributos e métodos da classe mãe `Funcionario` — inclusive os privados, embora não consiga acessá-los diretamente (para isso, a classe mãe precisaria expor um método visível que os manipule).

A nomenclatura padrão: `Funcionario` é a *superclasse* de `Gerente`; `Gerente` é a *subclasse* de `Funcionario`. Ou, de forma mais informal: `Funcionario` é a classe mãe, `Gerente` é a classe filha.

== O modificador `protected`

E se você precisa acessar os atributos herdados? Deixar tudo `public` significa que qualquer um pode alterar os atributos do objeto — voltamos ao problema do encapsulamento. Existe um meio-termo, o `protected`: acessível pela própria classe *e* por suas subclasses (e por classes do mesmo pacote, como veremos mais adiante).

#figure(
  raw(read("code/aula-poo-07-heranca/Funcionario_2.java"), lang: "java", block: true),
  caption: [`Funcionario` com atributos `protected`, acessíveis pela subclasse `Gerente`.]
)

Por que não usar `protected` sempre, já que é mais flexível que `private`? Porque isso quebra um pouco a ideia de que só a própria classe deveria manipular seus atributos — é uma discussão mais avançada, mas vale ter em mente: `protected` também libera acesso para outras classes do mesmo pacote, não só para subclasses.

Uma classe pode ter várias filhas, mas só uma mãe — é a herança simples do Java.

#figure(
  image("img/aula-poo-07-heranca/diag05_05.svg"),
  caption: [Uma hierarquia de herança: várias classes filhas, uma única classe mãe cada.],
)

== Generalizando: uma classe genérica, várias específicas

Um banco oferece vários serviços — empréstimo, seguro de veículo, etc. Modelar cada um do zero, sem reaproveitar nada, gera bastante código repetido (o oposto do princípio *Don't Repeat Yourself*, ou DRY). A solução: uma classe genérica `Servico` com o que é comum a todos, e uma classe específica para cada serviço, que herda dela.

#figure(
  raw(read("code/aula-poo-07-heranca/Servico.java"), lang: "java", block: true),
  caption: [Classe genérica `Servico`, com os atributos comuns a todo serviço.]
)

#figure(
  image("img/aula-poo-07-heranca/servico_06.svg"),
  caption: [`Servico` como superclasse de várias classes de serviço específicas.],
)

As classes específicas se conectam à genérica com `extends`, sem precisar redeclarar o que já existe lá:

#figure(
  raw(read("code/aula-poo-07-heranca/Servico_4.java"), lang: "java", block: true),
  caption: [`Servico`, pronta para ser estendida.]
)

#figure(
  raw(read("code/aula-poo-07-heranca/Emprestimo_7.java"), lang: "java", block: true),
  caption: [Classe específica `Emprestimo`, estendendo `Servico`.]
)

#figure(
  raw(read("code/aula-poo-07-heranca/SeguroDeVeiculo_2.java"), lang: "java", block: true),
  caption: [Classe específica `SeguroDeVeiculo`, estendendo `Servico`.]
)

Quando o `new` é aplicado numa subclasse, o objeto criado tem os atributos e métodos definidos ali *e* os herdados da superclasse.

#figure(
  image("img/aula-poo-07-heranca/diag07_07.svg"),
  caption: [Objetos de `Emprestimo` e `SeguroDeVeiculo` carregando o que herdaram de `Servico`.],
)

== Construtores e herança

Em Java, toda classe herda implicitamente de `Object`, a superclasse raiz de tudo. `Object` tem um construtor padrão sem parâmetros, chamado automaticamente se nenhum outro for especificado:

#figure(
  raw(read("code/aula-poo-07-heranca/Object.java"), lang: "java", block: true),
  caption: [O construtor padrão implícito de `Object`.]
)

#figure(
  raw(read("code/aula-poo-07-heranca/MinhaClasse.java"), lang: "java", block: true),
  caption: [Uma classe sem construtor explícito recebe um construtor padrão de brinde.]
)

Numa hierarquia de classes, as chamadas de construtor ficam mais interessantes: pelo menos um construtor de cada classe da cadeia precisa rodar ao instanciar um objeto. Se você cria um `Emprestimo`, pelo menos um construtor de `Emprestimo` *e* um de `Servico` são executados — e os construtores das classes mais genéricas rodam *antes* dos das mais específicas.

#figure(
  raw(read("code/aula-poo-07-heranca/Servico_5.java"), lang: "java", block: true),
  caption: [Construtor de `Servico`.]
)

#figure(
  raw(read("code/aula-poo-07-heranca/Emprestimo_2.java"), lang: "java", block: true),
  caption: [Construtor de `Emprestimo`, disparando o de `Servico` por trás.]
)

#figure(
  raw(read("code/aula-poo-07-heranca/TesteConstrutor.java"), lang: "java", block: true),
  caption: [Testando a ordem de execução dos construtores.]
)

#figure(
  image("img/aula-poo-07-heranca/diag08_08.svg"),
  caption: [Ordem de chamada dos construtores: superclasse primeiro.],
)

#figure(
  image("img/aula-poo-07-heranca/diag09_09.svg"),
  caption: [Cadeia de construtores numa hierarquia de herança.],
)

#figure(
  image("img/aula-poo-07-heranca/diag10_10.svg"),
  caption: [Objeto construído com atributos das duas classes.],
)

Por padrão, todo construtor chama implicitamente o construtor sem argumentos da classe mãe, se nenhuma chamada explícita for feita.

=== Construtores com parâmetros e `super()`

Se uma classe filha define seu próprio construtor, ela deve chamar explicitamente o construtor da superclasse com `super()`, garantindo que a inicialização da classe base aconteça direito:

#figure(
  raw(read("code/aula-poo-07-heranca/Pessoa.java"), lang: "java", block: true),
  caption: [`Pessoa` como superclasse, `Aluno` chamando `super()` explicitamente.]
)

Rodando esse código, a saída é:

```
Construtor da classe Pessoa chamado!
Construtor da classe Aluno chamado!
```

Por que a classe filha precisa chamar `super()`? Três motivos:

+ *Inicialização correta da superclasse* — a parte referente a `Pessoa` precisa estar pronta antes de `Aluno` mexer nos seus próprios atributos.
+ *Consistência* — se `Pessoa` tem lógica importante no construtor (validação, inicialização de recursos), ela precisa rodar antes do objeto `Aluno` ser usado.
+ *Evita erro de compilação* — se a classe mãe não tem construtor sem parâmetros e a filha não chama `super(args)` explicitamente, o código nem compila.

E se `Pessoa` não tivesse um construtor padrão e `Aluno` não chamasse `super()` corretamente? O compilador reclamaria assim: `"Constructor Pessoa in class Pessoa cannot be applied to given types"`. O Java sempre tenta chamar `super()` implicitamente quando nenhum construtor da superclasse é especificado — e se não existir um construtor sem argumentos pra chamar, o compilador desiste.

== Sobrescrita de métodos (override)

Todo fim de ano, os funcionários do banco recebem bonificação: 10% do salário para funcionários comuns, 15% para gerentes.

#figure(
  raw(read("code/aula-poo-07-heranca/Funcionario_3.java"), lang: "java", block: true),
  caption: [`Funcionario` com `getBonificacao()` calculando 10%.]
)

Se deixarmos `Gerente` como está, ele herda o `getBonificacao` de `Funcionario` — e um gerente com salário 5000 receberia bônus de 500, quando deveria receber 750. Criar um método novo (`getBonificacaoDoGerente`) deixaria a classe com dois métodos confusos e respostas diferentes.

A solução certa é *sobrescrever* (override) o método herdado:

#figure(
  raw(read("code/aula-poo-07-heranca/Gerente_2.java"), lang: "java", block: true),
  caption: [`Gerente` sobrescrevendo `getBonificacao()` com o cálculo correto (15%).]
)

A anotação `@Override` deixa explícito no código que um método é a reescrita de um método da classe mãe:

#figure(
  raw(read("code/aula-poo-07-heranca/bloco24.java"), lang: "java", block: true),
  caption: [Uso da anotação `@Override`.]
)

Não é obrigatório usar `@Override`, mas se você usar, o método *precisa* mesmo estar sobrescrevendo algo da classe mãe — senão o compilador reclama.

=== Chamando o método sobrescrito com `super`

Depois de sobrescrito, você não chama mais o método antigo diretamente — mudou o comportamento de verdade. Mas, de dentro da própria classe, dá pra invocar a versão da mãe com `super`. Imagine que a bonificação do gerente deveria ser igual à do funcionário comum, mais R\$ 1000 fixos:

#figure(
  raw(read("code/aula-poo-07-heranca/Gerente_3.java"), lang: "java", block: true),
  caption: [Reimplementando o cálculo do zero — funciona, mas duplica lógica.]
)

O problema: se o cálculo de `Funcionario` mudar, é preciso lembrar de atualizar `Gerente` também. Melhor deixar `Gerente` chamar o `getBonificacao` de `Funcionario` via `super`:

#figure(
  raw(read("code/aula-poo-07-heranca/Gerente_4.java"), lang: "java", block: true),
  caption: [`Gerente` reaproveitando o cálculo da mãe via `super.getBonificacao()`.]
)

Isso vai procurar o método `getBonificacao` na superclasse mais próxima que o tiver — no caso, `Funcionario`. É uma prática comum: o método sobrescrito geralmente faz "algo a mais" que o da classe mãe, e chamar `super` evita duplicar a lógica de base.

== Proibindo e limitando herança

Para impedir que uma classe seja estendida, use o modificador `final`:

#figure(
  raw(read("code/aula-poo-07-heranca/ClasseFinal.java"), lang: "java", block: true),
  caption: [Uma classe `final`: ninguém pode estendê-la.]
)

Já as *classes seladas* (`sealed`), disponíveis em Java, Kotlin, C\# e outras linguagens modernas, permitem controlar explicitamente *quais* subclasses podem estendê-la — combinando `sealed` com `permits`:

#figure(
  raw(read("code/aula-poo-07-heranca/ClasseSelada.java"), lang: "java", block: true),
  caption: [Classe selada, restringindo a herança a um conjunto pré-definido de subclasses.]
)

Vantagens: reforça encapsulamento (subclasses externas não conseguem quebrar invariantes do sistema), reduz acoplamento com código externo, facilita manutenção (você sabe exatamente quem herda de quem) e melhora checagem de tipos em pattern matching. O preço: menos flexibilidade — se um requisito novo pedir uma extensão fora do conjunto selado, você precisa reabrir a classe. Use classes seladas quando a hierarquia é conhecida e estável; evite selar prematuramente uma classe que ainda pode crescer.

]

#post-layout(meta, body)
