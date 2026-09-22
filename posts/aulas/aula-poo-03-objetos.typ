#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Objetos: Referência, Comunicação, Comparação e toString",
  date: "2026-03-31",
  tags: ("java", "objeto", "referencia", "equals", "tostring", "bluej"),
  excerpt: "As criaturas já existem. Agora é hora de entender onde elas moram de verdade, como se falam, e como reconhecer se são a mesma ou só gêmeas parecidas.",
)

#let body = [

== Onde a criatura realmente mora?

Na aula passada você aprendeu a criar classes com atributos, métodos e construtores. Mas quando você escreve algo como

```java
Criatura fenix = new Criatura("Fênix", 100, "Ave de Fogo", 30);
```

o que *exatamente* fica guardado na variável `fenix`? A criatura inteira? Surpresa: não.

Uma variável de tipo objeto não armazena o objeto em si — ela armazena uma *referência*, o endereço de memória onde o objeto foi criado. É como uma placa com o endereço da casa, não a casa em si.

Isso muda tudo:

- *Atribuir* uma variável a outra (`c2 = c1`) não copia o objeto, só copia o endereço. As duas passam a apontar para o *mesmo* objeto.
- *Comparar* com `==` compara os *endereços*, não o conteúdo dos objetos.
- *Passar* um objeto como parâmetro de método envia a *referência* — o método pode alterar o objeto original de verdade.

Usaremos daqui em diante a classe `Criatura` construída progressivamente na aula anterior:

#figure(
  raw(read("code/aula-poo-03-objetos/Criatura.java"), lang: "java", block: true),
  caption: [Classe `Criatura`, base para os exemplos desta aula.]
)

== Duas referências, dois objetos

#figure(
  raw(read("code/aula-poo-03-objetos/Universo.java"), lang: "java", block: true),
  caption: [`c1` e `c2` apontam para criaturas diferentes.]
)

Aqui `c1` e `c2` apontam para criaturas *diferentes* — cada uma com seu próprio espaço na memória, sua própria essência.

#figure(
  image("img/aula-poo-03-objetos/diag01_01.svg"),
  caption: [Duas referências, dois objetos distintos na memória.],
)

== Duas referências, um único objeto

#figure(
  raw(read("code/aula-poo-03-objetos/Universo_2.java"), lang: "java", block: true),
  caption: [`c2 = c1`: duas referências, o mesmo objeto.]
)

Cuidado: `c2 = c1` *não* cria uma nova criatura. Só faz `c2` apontar para o *mesmo* objeto que `c1`. Alterar por `c2` é o mesmo que alterar por `c1` — porque é literalmente a mesma criatura, só com dois apelidos.

#figure(
  image("img/aula-poo-03-objetos/diag02_02.svg"),
  caption: [Duas referências apontando para o mesmo objeto.],
)

Uma variável também pode não apontar para nada:

```java
Criatura fantasma = null; // Nenhuma criatura existe aqui
fantasma.exibirStatus();  // ERRO! NullPointerException!
```

`null` significa que a referência não aponta para ninguém. Tentar invocar um método numa referência nula é gritar ordem para o vazio — o programa responde com uma bela `NullPointerException`.

== Comunicação entre objetos

Objetos não vivem isolados: eles interagem através de *mensagens*, que em Java são chamadas de métodos. Quando um objeto chama o método de outro, ele está enviando uma mensagem: o *remetente* é quem chama, o *destinatário* é quem executa, a *mensagem* é o nome do método com seus parâmetros, e a *resposta* é o retorno (se houver). Um objeto nunca faz tudo sozinho — o poder está na interação.

Vamos aprofundar isso com a classe `Conta`:

#figure(
  raw(read("code/aula-poo-03-objetos/Conta.java"), lang: "java", block: true),
  caption: [Classe `Conta` com o método `transferir`.]
)

Repare no método `transferir`: ele recebe *outra conta* como parâmetro. Quando `c1.transferir(c2, 200)` roda, a conta `c1` saca de si mesma e deposita na `c2` — dois objetos colaborando.

#figure(
  image("img/aula-poo-03-objetos/universo_03.svg"),
  caption: [Diagrama de sequência: transferência entre contas — objetos se comunicando.],
)

#figure(
  raw(read("code/aula-poo-03-objetos/Universo_3.java"), lang: "java", block: true),
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
  raw(read("code/aula-poo-03-objetos/Universo_4.java"), lang: "java", block: true),
  caption: [Duas criaturas com atributos idênticos, comparadas com `==`.]
)

Mesmo com atributos idênticos, `c1 == c2` dá `false`. Por quê? Porque `==` compara *endereços* de memória, e cada `new` cria um objeto num endereço diferente. São gêmeas — não a mesma criatura.

#figure(
  image("img/aula-poo-03-objetos/diag04_04.svg"),
  caption: [O operador `==` compara endereços, não conteúdo.],
)

O `==` pergunta "vocês moram no mesmo lugar?" — não "vocês são iguais?". Para comparar conteúdo, precisamos do `equals()`.

=== O método `equals()` compara conteúdo

Para comparar duas criaturas pelo conteúdo, sobrescrevemos o `equals()`:

#figure(
  raw(read("code/aula-poo-03-objetos/Criatura_2.java"), lang: "java", block: true),
  caption: [`equals()` sobrescrito para comparar criaturas pelo nome.]
)

Agora dá pra comparar pelo conteúdo:

#figure(
  raw(read("code/aula-poo-03-objetos/Universo_5.java"), lang: "java", block: true),
  caption: [Comparando criaturas com `equals()`.]
)

Quem define o *critério de igualdade* é você. No exemplo acima, decidimos que duas criaturas são iguais se tiverem o mesmo nome. Poderia ser pelo tipo, pela vida, ou por uma combinação de atributos — depende da regra do seu programa.

Outro exemplo, com a classe `Conta`:

#figure(
  raw(read("code/aula-poo-03-objetos/Conta_2.java"), lang: "java", block: true),
  caption: [`equals()` sobrescrito na classe `Conta`.]
)

== toString: dando voz ao objeto

Sem `toString()`, imprimir um objeto com `IO.println(fenix)` mostra algo como `Criatura@1a2b3c4d` — o nome da classe seguido do endereço de memória. Nada informativo.

```java
Criatura fenix = new Criatura("Fênix", 100, "Ave de Fogo", 30);
IO.println(fenix); // Imprime algo como: Criatura@1a2b3c4d
```

Isso acontece porque o `toString()` padrão, herdado de `Object`, só devolve nome da classe + endereço. Sobrescreva-o para dar uma identidade legível ao objeto:

#figure(
  raw(read("code/aula-poo-03-objetos/Criatura_3.java"), lang: "java", block: true),
  caption: [`toString()` sobrescrito para uma apresentação legível.]
)

Agora:

```java
Criatura fenix = new Criatura("Fênix", 100, "Ave de Fogo", 30);
IO.println(fenix); // Fênix [Ave de Fogo] - Vida: 100 | Força: 30
```

O `IO.println()` chama o `toString()` automaticamente. O objeto agora sabe se apresentar. O `@Override` indica que estamos sobrescrevendo um método herdado da classe `Object` — falaremos mais de herança em breve, mas já vale saber: todo objeto em Java herda o `toString()`, e você pode personalizá-lo.

Outro exemplo com `Conta`:

#figure(
  raw(read("code/aula-poo-03-objetos/Conta_3.java"), lang: "java", block: true),
  caption: [`toString()` sobrescrito na classe `Conta`.]
)

```java
Conta c1 = new Conta(1, "Leandro");
c1.depositar(500);
IO.println(c1); // Conta 1 | Leandro | Saldo: R$500.0 | Limite: R$0.0
```

== A classe `Criatura` completa (até aqui)

#figure(
  raw(read("code/aula-poo-03-objetos/Criatura_4.java"), lang: "java", block: true),
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

*Passo 7 — Referência compartilhada:* no Code Pad do BlueJ (View → Show Code Pad):

```java
Criatura c1 = fenix1;
Criatura c2 = fenix1;
```

Inspecione ambas. Alterar uma (ex.: `c1.vida = 999`) altera a outra — porque são a *mesma* criatura.

Esse roteiro no BlueJ revela verdades importantes: duas criaturas podem parecer iguais mas serem diferentes (`equals`), e duas referências podem parecer diferentes mas apontarem para a mesma criatura (`==`).

]

#post-layout(meta, body)
