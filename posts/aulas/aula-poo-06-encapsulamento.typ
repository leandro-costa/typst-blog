#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Encapsulamento",
  date: "2026-05-19",
  tags: ("java", "encapsulamento", "getters", "setters", "modificadores"),
  excerpt: "Dar vida a uma criatura não basta — se qualquer um puder mexer nas entranhas dela, o universo vira uma barraca de feira. Hora de blindar seus objetos.",
)

#let body = [

== O que é encapsulamento?

*Encapsulamento* é um dos pilares da Orientação a Objetos. É a técnica de esconder as entranhas de um objeto — seus dados e a lógica interna — expondo para o mundo de fora só uma interface controlada.

O objetivo é proteger o estado interno do objeto, garantindo que ele nunca fique num estado inválido por causa de alguém de fora mexendo onde não devia. Em vez de deixar qualquer parte do programa alterar um atributo à vontade, o próprio objeto assume a responsabilidade por seus dados.

== Organizando a bagunça: pacotes

Antes de falar em proteção, precisamos de organização. Em Java, classes moram em *pacotes* — agrupamentos lógicos de classes relacionadas, que correspondem literalmente a pastas no sistema de arquivos. Eles servem para:

- *Evitar conflitos de nome*: duas classes podem ter o mesmo nome, desde que estejam em pacotes diferentes.
- *Organizar a visibilidade*: alguns modificadores de acesso dependem de a classe estar ou não no mesmo pacote.

A palavra-chave `package` (no topo do arquivo) declara a qual pacote a classe pertence. A palavra-chave `import` permite usar classes de outros pacotes no seu código.

== Visibilidade e modificadores de acesso

Para implementar o encapsulamento, Java usa *modificadores de acesso*, que definem quem pode "ver" ou "tocar" numa classe, atributo ou método.

=== Visibilidade de classes

Classes de nível superior só têm dois tipos de visibilidade:

- `public`: visível para qualquer outra classe, em qualquer pacote.
- _(padrão, sem modificador)_: visível só para classes do *mesmo pacote*.

=== Visibilidade de atributos e métodos

Para os membros de uma classe, existem quatro níveis:

#figure(
  table(
    columns: 3,
    [*Modificador*], [*Visibilidade*], [*Descrição*],
    [`public`], [Total], [Acessível de qualquer lugar.],
    [`protected`], [Herdada], [Acessível por classes do mesmo pacote e por subclasses (mesmo em pacotes diferentes).],
    [_(padrão)_], [Pacote], [Acessível só por classes do mesmo pacote.],
    [`private`], [Restrita], [Acessível só dentro da própria classe.],
  ),
  caption: [Os quatro níveis de visibilidade em Java.]
)

== Getters e setters: os portais controlados

Se você torna seus atributos `private` para protegê-los, como faz pra ler ou alterar esses valores de fora? Criando *portais controlados* — os métodos de acesso:

- *Getter* (`get`): método público que retorna o valor de um atributo privado. Permite *leitura*, não alteração.
- *Setter* (`set`): método público que recebe um valor e o atribui ao atributo privado. Permite *escrita*, com a vantagem de poder adicionar *validações* antes de aceitar a mudança.

A convenção é `get`/`set` seguido do nome do atributo com a primeira letra maiúscula (`getSaldo()`, `setSaldo()`).

== Por que isso importa: o desastre do saldo público

Imagine que você criou uma `ContaBancaria` com `saldo` e `titular` como atributos `public`. De repente, qualquer parte do código pode:

- Fazer `conta.saldo = 0`, zerando o saldo sem passar por nenhuma transação.
- Fazer `conta.saldo = -999999`, quebrando a regra básica de que saldo não pode ser um buraco negro de dívida.
- Trocar o `titular` da conta no meio de uma operação, sem ninguém perceber.

Isso não é liberdade — é negligência. Quando os dados estão expostos, você perde o controle das regras do seu próprio sistema.

A solução: selar os atributos com `private` e construir portais controlados (getters e setters). Agora, se alguém quiser alterar o saldo, precisa passar pelo `setSaldo()`, onde você pode impor a lei: "nenhum valor negativo será aceito aqui".

Se todos os atributos de uma classe são `public`, você não criou um objeto — criou uma barraca de feira onde qualquer um entra e mexe no que quiser.

== Na prática: negligência vs proteção

=== Sem encapsulamento

Nesta versão, qualquer código pode interferir diretamente na conta.

#figure(
  raw(read("code/aula-poo-06-encapsulamento/Conta.java"), lang: "java", block: true),
  caption: [Classe `Conta` com atributos públicos — sem nenhuma proteção.]
)

=== Com encapsulamento

Agora protegemos a essência e criamos portais com validação.

#figure(
  raw(read("code/aula-poo-06-encapsulamento/Conta_2.java"), lang: "java", block: true),
  caption: [Classe `Conta` com atributos privados, getters e setters validando entrada.]
)

== Roteiro no BlueJ

*Passo 1 — Criar o molde:* crie a classe `Conta` com atributos `private` e métodos `get`/`set`. Compile.

*Passo 2 — Instanciar:* botão direito na classe `Conta` → `new Conta("Mortal", 1000.0)`.

*Passo 3 — Testar a blindagem:* botão direito no objeto criado. Note que você *não consegue* alterar `saldo` diretamente — o atributo não aparece na lista de métodos invocáveis. A blindagem está funcionando.

*Passo 4 — Usar os portais:* botão direito no objeto → `getSaldo()` mostra `1000.0`. Agora tente `setSaldo(-500.0)` — o valor não muda, porque a regra interna da classe bloqueou.

*Passo 5 — Inspecionar:* botão direito → _Inspect_. Você ainda *vê* o valor do saldo (modo debug), mas não consegue *alterá-lo* sem passar pelos portais.

]

#post-layout(meta, body)
