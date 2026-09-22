#import "../../templates/post.typ": post-layout
#import "@preview/callisto:0.3.0"

#let meta = (
  title: "Objetos: Referência, Comunicação, Comparação e toString",
  date: "2026-03-31",
  tags: ("java", "objeto", "referencia", "equals", "tostring", "bluej"),
  excerpt: "As criaturas já existem. Agora é hora de entender onde elas moram de verdade, como se falam, e como reconhecer se são a mesma ou só gêmeas parecidas.",
)

#let body = [

#let (execute, stage-notebook) = callisto.config(
  nb: path("aula-poo-03-objetos.ipynb"),
  kernel: "ijava",
)
// Todo bloco marcado "java-x" — venha de um arquivo externo (`raw(read(...))`)
// ou escrito direto na página — é exportado para o notebook e executado de
// verdade; o que aparece embaixo do código é a saída real do kernel IJava.
#show raw.where(lang: "java-x"): it => execute(it)
#stage-notebook()

== Onde a criatura realmente mora?

Na aula passada você aprendeu a criar classes com atributos, métodos e construtores. A classe `Criatura` que construímos progressivamente vai nos acompanhar aqui — e, a partir de agora, todo código desta aula roda de verdade: o que você vê é o que executou, e a saída embaixo é a saída real do kernel.

#figure(
  raw(read("code/aula-poo-03-objetos/Criatura.java"), lang: "java-x", block: true),
  caption: [Classe `Criatura`, base para os exemplos desta aula.]
)

Antes de mexer com referências, uma curiosidade rápida: o que acontece se você tentar *imprimir* um objeto direto, sem preparar nada?


#figure(
  ```java-x
  Criatura fenix = new Criatura("Fênix", 100, "Ave de Fogo", 30);
  IO.println(fenix);
  ```,
  caption: [Instanciação e impressão da criatura Fênix em Java.],
)



Nada legível. O nosso kernel roda o código dentro de um ambiente REPL (JShell), então o nome da classe vem com um prefixo interno (`REPL.$JShell$...`); rodando com `javac`/`java` puro ou no BlueJ, você veria só `Criatura@` seguido do endereço. De qualquer forma, o endereço muda a cada execução — o que importa aqui é que *nenhuma* das duas formas é informativa. Vamos resolver isso com `toString()` mais adiante.

o que *exatamente* fica guardado na variável `fenix`? A criatura inteira? Surpresa: não.

Uma variável de tipo objeto não armazena o objeto em si — ela armazena uma *referência*, o endereço de memória onde o objeto foi criado. É como uma placa com o endereço da casa, não a casa em si.

Isso muda tudo:

- *Atribuir* uma variável a outra (`c2 = c1`) não copia o objeto, só copia o endereço. As duas passam a apontar para o *mesmo* objeto.
- *Comparar* com `==` compara os *endereços*, não o conteúdo dos objetos.
- *Passar* um objeto como parâmetro de método envia a *referência* — o método pode alterar o objeto original de verdade.

== Duas referências, dois objetos

#figure(
  ```java-x
  Criatura c1 = new Criatura("Fênix", 100, "Ave de Fogo", 30);
  Criatura c2 = new Criatura("Smaug", 200, "Dragão", 50);
  IO.print(c1);
  IO.print(c2);
  ```,
  caption: [`c1` e `c2` apontam para criaturas diferentes.]
)

Aqui `c1` e `c2` apontam para criaturas *diferentes* — cada uma com seu próprio espaço na memória, sua própria essência.

#figure(
  image("img/aula-poo-03-objetos/diag01_01.svg"),
  caption: [Duas referências, dois objetos distintos na memória.],
)

== Duas referências, um único objeto

#figure(
  ```java-x
  Criatura c1 = new Criatura("Fênix", 100, "Ave de Fogo", 30);
  Criatura c2 = c1; // c2 aponta para a MESMA criatura!

  c2.nome = "Fênix Renascida";
  IO.println(c1.nome);
  ```,
  caption: [`c2 = c1`: duas referências, o mesmo objeto.]
)

Cuidado: `c2 = c1` *não* cria uma nova criatura. Só faz `c2` apontar para o *mesmo* objeto que `c1`. Alterar por `c2` é o mesmo que alterar por `c1` — porque é literalmente a mesma criatura, só com dois apelidos. Por isso `c1.nome` também virou `"Fênix Renascida"`, mesmo sem nunca mexer em `c1` diretamente.

#figure(
  image("img/aula-poo-03-objetos/diag02_02.svg"),
  caption: [Duas referências apontando para o mesmo objeto.],
)

Uma variável também pode não apontar para nada. Vamos deixar isso quebrar de propósito, para ver a exceção de verdade:

#figure(
  align(left, execute(raw("Criatura fantasma = null; // Nenhuma criatura existe aqui\nfantasma.exibirStatus();  // ERRO! NullPointerException!", lang: "java", block: true))),
  caption: [Chamando um método numa referência nula.]
)

`null` significa que a referência não aponta para ninguém. Tentar invocar um método numa referência nula é gritar ordem para o vazio — o programa responde com uma `NullPointerException` de verdade, como você vê no erro acima. O kernel sobrevive: as próximas células continuam rodando normalmente depois de um erro.

== Comunicação entre objetos

Objetos não vivem isolados: eles interagem através de *mensagens*, que em Java são chamadas de métodos. Quando um objeto chama o método de outro, ele está enviando uma mensagem: o *remetente* é quem chama, o *destinatário* é quem executa, a *mensagem* é o nome do método com seus parâmetros, e a *resposta* é o retorno (se houver). Um objeto nunca faz tudo sozinho — o poder está na interação.

Vamos aprofundar isso com a classe `Conta`:

#figure(
  raw(read("code/aula-poo-03-objetos/Conta.java"), lang: "java-x", block: true),
  caption: [Classe `Conta` com o método `transferir`.]
)

Repare no método `transferir`: ele recebe *outra conta* como parâmetro. Quando `c1.transferir(c2, 200)` roda, a conta `c1` saca de si mesma e deposita na `c2` — dois objetos colaborando.

#figure(
  image("img/aula-poo-03-objetos/universo_03.svg"),
  caption: [Diagrama de sequência: transferência entre contas — objetos se comunicando.],
)

#figure(
  ```java-x
  Conta c1 = new Conta(1, "Leandro");
  Conta c2 = new Conta(2, "Maria");

  c1.depositar(1000);

  c1.exibirExtrato();
  c2.exibirExtrato();

  c1.transferir(c2, 200);

  c1.exibirExtrato();
  c2.exibirExtrato();
  ```,
  caption: [Transferência entre duas contas em ação.]
)

O método `transferir` não inventa nada novo — ele compõe poderes que já existem: `sacar` e `depositar`. Um código eficiente reutiliza, não repete.

== Comparação: `==` vs `equals`

Em Java existem duas formas de comparar objetos, e a diferença é essencial:

#figure(
  table(
    columns: 3,
    [*Operador / Método*], [*O que compara*], [*Quando usar*],
    [`==`], [Os endereços (referências)], [Verificar se é o mesmo objeto],
    [`equals()`], [O conteúdo (como você definir)], [Verificar se são equivalentes],
  ),
  caption: [Diferença entre `==` e `equals()`.]
)

Por padrão, o `equals()` herdado de `Object` compara endereços — igualzinho ao `==`. Para comparar pelo conteúdo, você precisa *sobrescrever* o método na sua classe.

=== O operador `==` compara referências

#figure(
  ```java-x
  Criatura c1 = new Criatura("Fênix", 100, "Ave de Fogo", 30);
  Criatura c2 = new Criatura("Fênix", 100, "Ave de Fogo", 30);

  if (c1 == c2) {
      IO.println("Mesma criatura!");
  } else {
      IO.println("Criaturas diferentes!");
  }
  ```,
  caption: [Duas criaturas com atributos idênticos, comparadas com `==`.]
)

Por quê? Porque `==` compara *endereços* de memória, e cada `new` cria um objeto num endereço diferente. São gêmeas — não a mesma criatura.

#figure(
  image("img/aula-poo-03-objetos/diag04_04.svg"),
  caption: [O operador `==` compara endereços, não conteúdo.],
)

O `==` pergunta "vocês moram no mesmo lugar?" — não "vocês são iguais?". Para comparar conteúdo, precisamos do `equals()`.

=== O método `equals()` compara conteúdo

Para comparar duas criaturas pelo conteúdo, sobrescrevemos o `equals()`. Isso redefine a `Criatura` que já estava rodando desde o início da aula — a partir daqui ela ganha um critério de igualdade de verdade:

#figure(
  raw(read("code/aula-poo-03-objetos/Criatura_2.java"), lang: "java-x", block: true),
  caption: [`equals()` sobrescrito para comparar criaturas pelo nome.]
)

Agora dá pra comparar pelo conteúdo:

#figure(
  ```java-x
  Criatura c1 = new Criatura("Fênix", 100, "Ave de Fogo", 30);
  Criatura c2 = new Criatura("Fênix", 150, "Ave de Gelo", 40);

  IO.println(c1 == c2);      // false — endereços diferentes
  IO.println(c1.equals(c2)); // true  — mesmo nome!
  ```,
  caption: [Comparando criaturas com `equals()`.]
)

Quem define o *critério de igualdade* é você. No exemplo acima, decidimos que duas criaturas são iguais se tiverem o mesmo nome. Poderia ser pelo tipo, pela vida, ou por uma combinação de atributos — depende da regra do seu programa.

Outro exemplo, com a classe `Conta` (redefinindo, do mesmo jeito, a `Conta` que já vínhamos usando):

#figure(
  raw(read("code/aula-poo-03-objetos/Conta_2.java"), lang: "java-x", block: true),
  caption: [`equals()` sobrescrito na classe `Conta`.]
)

== toString: dando voz ao objeto

Lá no início da aula vimos que, sem `toString()`, imprimir um objeto mostra algo ilegível — o nome da classe seguido do endereço de memória. Vamos consertar isso sobrescrevendo o método:

#figure(
  text(size: 0.8em, raw(read("code/aula-poo-03-objetos/Criatura_4.java"), lang: "java-x", block: true)),
  caption: [Versão completa de `Criatura`, agora com `toString()` também sobrescrito (além do `equals()` que já tinha).]
)

#figure(
  ```java-x
  Criatura fenix = new Criatura("Fênix", 100, "Ave de Fogo", 30);
  IO.println(fenix);
  ```,
  caption: [Criando uma criatura e imprimindo-a.]
)

O objeto agora sabe se apresentar. O `@Override` indica que estamos sobrescrevendo um método herdado da classe `Object` — falaremos mais de herança em breve, mas já vale saber: todo objeto em Java herda o `toString()`, e você pode personalizá-lo.

Outro exemplo com `Conta`, agora também com `toString()`:

#figure(
  raw(read("code/aula-poo-03-objetos/Conta_4.java"), lang: "java-x", block: true),
  caption: [`Conta` completa, agora com `toString()` sobrescrito.]
)

#figure(
  ```java-x
  Conta c1 = new Conta(1, "Leandro");
  c1.depositar(500);
  IO.println(c1);
  ```,
  caption: [Depositando e imprimindo uma conta.]
)

== A classe `Criatura` completa (até aqui)

Segue de novo, como referência rápida, a versão completa da `Criatura` que já usamos e executamos na seção de `toString()`:

#figure(
  text(size: 0.8em, raw(read("code/aula-poo-03-objetos/Criatura_4.java"), lang: "java-x", block: true)),
  caption: [Versão completa de `Criatura` com tudo que vimos até esta aula.]
)

== Roteiro no BlueJ

*Passo 1 — Criar o projeto:* abra o BlueJ e crie a classe `Criatura` com o código completo acima (com `toString` e `equals`). Compile.

*Passo 2 — Criar duas criaturas idênticas:* clique com o botão direito na classe `Criatura` → `new Criatura(String, int, String, int)`, e crie:
- `fenix1`: `"Fênix"`, `100`, `"Ave de Fogo"`, `30`
- `fenix2`: `"Fênix"`, `100`, `"Ave de Fogo"`, `30`

Duas criaturas no banco. Parecem iguais — mas serão?

*Passo 3 — Testar o `toString()`:* botão direito em `fenix1` → `String toString()`. O BlueJ mostra `"Fênix [Ave de Fogo] - Vida: 100 | Força: 30"`. Ela se apresentou!

*Passo 4 — Testar o `equals()`:* botão direito em `fenix1` → `boolean equals(Criatura)`, escolhendo `fenix2`. O resultado é `true` — mesmo nome, equivalentes.

*Passo 5 — Criar uma criatura diferente:* crie `"Smaug"`, `200`, `"Dragão"`, `50`. Teste `fenix1.equals(smaug1)` — agora dá `false`.

*Passo 6 — Inspecionar:* inspecione `fenix1` e `fenix2`. Mesma essência, mas objetos *diferentes* no banco, cada um no seu próprio lugar. Gêmeas, não a mesma criatura.

*Passo 7 — Referência compartilhada:* no Code Pad do BlueJ (View → Show Code Pad) — este trecho é específico do BlueJ, então não roda no nosso notebook:

```java
Criatura c1 = fenix1;
Criatura c2 = fenix1;
```

Inspecione ambas. Alterar uma (ex.: `c1.vida = 999`) altera a outra — porque são a *mesma* criatura.

Esse roteiro no BlueJ revela verdades importantes: duas criaturas podem parecer iguais mas serem diferentes (`equals`), e duas referências podem parecer diferentes mas apontarem para a mesma criatura (`==`).

]

#post-layout(meta, body)
