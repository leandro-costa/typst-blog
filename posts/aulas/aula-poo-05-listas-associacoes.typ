#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Listas nas Associações: Modelando 1:N e N:N",
  date: "2026-04-14",
  tags: ("java", "associacao", "lista", "arraylist"),
  excerpt: "Uma turma tem vários alunos. Um livro tem várias categorias. Chegou a hora de aprender a construir listas e usá-las para conectar várias criaturas de uma vez.",
)

#let body = [

== O que são associações com listas?

Você já sabe que uma classe pode ter um atributo cujo tipo é outra classe — isso é associação. Mas e quando uma coisa se relaciona com *várias* outras ao mesmo tempo? Um carro pode ter vários passageiros. Uma turma pode ter vários alunos. Um livro pode pertencer a várias categorias. Uma escola pode ter várias turmas. Para modelar isso, usamos um atributo do tipo `List`.

```java
List<Aluno> alunos;
List<Livro> livros;
List<Categoria> categorias;
```

Isso ainda não cria a lista em si — só declara o tipo. Para criar a lista de verdade, é preciso instanciar um `ArrayList`:

```java
List<Aluno> alunos = new ArrayList<>();
List<Livro> livros = new ArrayList<>();
List<Categoria> categorias = new ArrayList<>();
```

- `List<Aluno>` declara o tipo da lista.
- `new ArrayList<>()` cria a lista em memória.
- Os `<>` vazios usam inferência de tipo — o Java já sabe que é um `ArrayList<Aluno>`.

Essa é a forma mais comum de tornar uma associação *dinâmica* e *flexível*.

#figure(
  image("img/aula-poo-05-listas-associacoes/turma_01.svg"),
  caption: [UML de associações com listas para `Turma`/`Aluno`/`Professor`.],
)

#figure(
  image("img/aula-poo-05-listas-associacoes/livro_02.svg"),
  caption: [UML de associações com listas para `Livro`/`Autor`/`Categoria`.],
)

== Por que usar `ArrayList`?

`ArrayList` é uma coleção que deixa você:

- armazenar vários objetos relacionados;
- adicionar e remover itens dinamicamente;
- percorrer a lista com `for`, `foreach` ou `forEach`;
- usar `contains` para checar se um objeto já está presente.

É perfeito para classes que representam um *todo* que contém ou referencia *muitas partes*.

== Associações 1:N com listas

Pense em: `Cliente` possui `List<Conta>`; `Agencia` possui `List<Conta>`; `Conta` possui `List<CartaoDeCredito>`. É uma associação de *um para muitos* — um cliente pode ter várias contas, uma agência controla várias contas.

=== Exemplo: Turma, Aluno e Professor

#figure(
  raw(read("code/aula-poo-05-listas-associacoes/Turma.java"), lang: "java", block: true),
  caption: [Classe `Turma`, associada a listas de `Aluno` e `Professor`.]
)

#figure(
  raw(read("code/aula-poo-05-listas-associacoes/Aluno.java"), lang: "java", block: true),
  caption: [Classe `Aluno`.]
)

Aqui, `Turma` tem uma associação com muitos `Aluno` e outra com muitos `Professor`.

== Por que usar `contains`?

O método `contains` usa o `equals` por baixo dos panos para comparar objetos na lista. Por isso, quando você guarda objetos associados numa lista, precisa implementar `equals` direitinho:

#figure(
  raw(read("code/aula-poo-05-listas-associacoes/bloco03.java"), lang: "java", block: true),
  caption: [Usando `contains` para verificar se um aluno já está na lista.]
)

Sem um `equals` bem implementado, duas instâncias diferentes com o mesmo conteúdo podem ser consideradas diferentes — e o `contains` te trai bonito.

== Exemplo: biblioteca digital com categorias e autores

Outro domínio rico em listas: um livro pode ser classificado em várias categorias e pertence a um autor.

#figure(
  raw(read("code/aula-poo-05-listas-associacoes/Livro.java"), lang: "java", block: true),
  caption: [Classe `Livro`, associada a um `Autor` e a uma lista de `Categoria`.]
)

Aqui temos: `Livro` associado a um único `Autor`, e `Livro` associado a muitas `Categoria` via `List<Categoria>`. Quando cada categoria pode ter muitos livros e cada livro pode ter muitas categorias, isso forma um relacionamento *muitos para muitos*.

== Como percorrer associações com listas

Com `for` tradicional:

#figure(
  raw(read("code/aula-poo-05-listas-associacoes/bloco05.java"), lang: "java", block: true),
  caption: [Percorrendo uma lista de alunos com `for` tradicional.]
)

Com `foreach`:

```java
for (Aluno aluno : turma.getAlunos()) {
    System.out.println(aluno);
}
```

Com `forEach` (Java 8+):

```java
turma.getAlunos().forEach(aluno -> System.out.println(aluno));
```

== Resumo

- `List` serve para representar associações 1:N e N:N.
- Use `ArrayList` internamente para armazenar os objetos.
- Implemente `equals()` quando for usar `contains()` em listas de objetos.
- Use laços e `forEach` para percorrer as relações associadas.

A lista não é um atributo qualquer: ela *é* a associação viva entre duas classes.

]

#post-layout(meta, body)
