#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Classes: Atributos, Métodos e Construtores",
  date: "2026-02-19",
  tags: ("java", "classe", "atributo", "metodo", "construtor", "bluej"),
  excerpt: "No primeiro dia, o Caos não bastava — era hora de criar Moldes e dar vida às Criaturas. Bem-vindo às classes.",
)

#let body = [

== O que é uma Classe?

Na aula passada você aprendeu que, na Orientação a Objetos, dados e comportamentos moram juntos. Hoje a pergunta é: *onde* exatamente eles moram? Resposta: dentro de uma `Classe`.

Uma classe é a *descrição* de um conjunto de entidades que compartilham os mesmos atributos (características), métodos (comportamentos) e significado. É o *molde* a partir do qual objetos são criados — a planta baixa de cada tipo de criatura que vai existir no seu programa.

A palavra "classe" vem lá da biologia: todos os seres da mesma classe biológica compartilham atributos e comportamentos em comum, mas não são idênticos — variam nos *valores* desses atributos. Pense na espécie _Homo sapiens_: ela descreve um grupo com características comuns (nome, idade, altura), mas _Homo sapiens_ não é um ser humano — é a *especificação*. Para ter um ser humano de verdade, você precisa de uma *instância*.

Algumas analogias que ajudam a fixar:

- Uma *receita de bolo* não é um bolo — você precisa segui-la (instanciá-la) para comer.
- A *planta de uma casa* não é uma casa — você mora no objeto, não no desenho.
- O *molde de uma criatura* não é uma criatura — alguém precisa apertar o botão da vida.

== O que é um Objeto?

Um *objeto* é uma instância de uma classe: uma entidade concreta, única e independente que existe de verdade no programa. Cada objeto:

- É *único* — mesmo vindo do mesmo molde, dois objetos são entidades diferentes.
- Tem *atributos*, que guardam suas características e seu estado atual.
- Tem *métodos*, que definem o que ele sabe fazer.
- É *independente* — cuida dos próprios dados e executa as próprias ações.

Exemplo clássico: um objeto do tipo `Conta` tem *atributos* (titular, número, saldo, limite) e *métodos* (sacar, depositar, transferir).

== Fase 1 — O primeiro molde (classe com atributos)

Vamos começar simples: uma `Criatura` com uma essência básica.

#figure(
  raw(read("code/aula-poo-02-classes/Criatura.java"), lang: "java", block: true),
  caption: [Primeira versão da classe `Criatura`: só atributos.]
)

Três linhas, três atributos. Molde pronto — mas sozinho ele não faz absolutamente nada. Falta a parte divertida: criar uma criatura de verdade.

*Atributos* são as propriedades de uma classe. Elas descrevem as características que cada objeto terá; assim que a classe é instanciada em um objeto, os atributos recebem valores concretos que definem aquele objeto específico.

#figure(
  raw(read("code/aula-poo-02-classes/Conta_2.java"), lang: "java", block: true),
  caption: [Classe `Conta` com atributos declarados.]
)

Cada conta criada a partir desse molde tem seu próprio número, seu próprio cliente, seu próprio saldo. O molde é um só — as contas podem ser milhares.

== Fase 2 — Instanciando objetos

#figure(
  raw(read("code/aula-poo-02-classes/Universo.java"), lang: "java", block: true),
  caption: [Duas criaturas nascendo do mesmo molde, com essências diferentes.]
)

Repare: `fenix` e `smaug` vêm do *mesmo molde*, mas são criaturas *diferentes*, cada uma com sua própria essência. Isso é o que chamamos de instanciar um objeto — o `new` é literalmente o botão que dá vida à criatura.

#figure(
  image("img/aula-poo-02-classes/diag01_nova_01.svg"),
  caption: [Um molde (classe), três criaturas (objetos) — cada uma com sua própria essência.],
)

O molde não é a criatura. Ele é a *ideia* da criatura. Sem o `new`, você tem só um sonho no código; com o `new`, você tem um objeto vivo, ocupando memória de verdade.

== Fase 3 — Métodos: os poderes da criatura

Um molde sem poderes cria só criaturas inertes. *Métodos* definem o que um objeto pode *fazer* — as ações, os comportamentos, as habilidades. Eles são acionados por outros objetos (ou pelo próprio programa), e é assim que os objetos conversam entre si: trocando mensagens via chamadas de método.

Um método pode não retornar nada (`void` — executa e não devolve resposta) ou retornar um valor (executa e devolve uma resposta).

=== Métodos sem retorno (`void`)

#figure(
  raw(read("code/aula-poo-02-classes/Criatura_2.java"), lang: "java", block: true),
  caption: [Métodos `receberDano` e `exibirStatus`, sem valor de retorno.]
)

Agora a criatura *sabe* o que fazer: recebe dano, se cura, exibe status. Não precisamos mais mexer diretamente nas entranhas dela — só damos a ordem, e ela executa.

#figure(
  raw(read("code/aula-poo-02-classes/Universo_2.java"), lang: "java", block: true),
  caption: [Chamando métodos sem retorno em uma instância de `Criatura`.]
)

=== Métodos com retorno

Às vezes você quer que o objeto *responda* quando é acionado. Para isso o método precisa devolver um valor:

#figure(
  raw(read("code/aula-poo-02-classes/Criatura_3.java"), lang: "java", block: true),
  caption: [Método `estaViva()` retornando um `boolean`.]
)

#figure(
  raw(read("code/aula-poo-02-classes/Conta_3.java"), lang: "java", block: true),
  caption: [Classe `Conta` com um método que retorna valor.]
)

=== Métodos que recebem objetos

O verdadeiro poder aparece quando um objeto conversa com outro, recebendo-o como parâmetro:

#figure(
  raw(read("code/aula-poo-02-classes/Criatura_4.java"), lang: "java", block: true),
  caption: [Método `atacar` recebendo outra `Criatura` como alvo.]
)

#figure(
  image("img/aula-poo-02-classes/universo_nova_02.svg"),
  caption: [Diagrama de sequência: duas criaturas trocando mensagens (uma ataca a outra).],
)

#figure(
  raw(read("code/aula-poo-02-classes/Universo_4.java"), lang: "java", block: true),
  caption: [Duas criaturas interagindo: uma ataca, a outra recebe dano.]
)

== Fase 4 — Construtor: o ritual de nascimento

Até aqui nossas criaturas nascem *vazias*, e a gente preenche os atributos um a um na mão. Perigoso: e se você esquecer de definir o nome? A criatura existe sem identidade — um fantasma no seu programa.

O *construtor* resolve isso. É um método especial, executado *automaticamente* quando um objeto é criado, e serve para:

- *Inicializar* os atributos com valores válidos.
- *Garantir* que todo objeto nasça com uma essência definida.
- *Evitar* objetos em estados inválidos ou vazios.

Regras do construtor:

+ Tem o *mesmo nome* da classe.
+ *Não* tem tipo de retorno — nem `void`.
+ É chamado automaticamente pelo operador `new`.
+ Se você não escrever nenhum, o Java te dá um construtor padrão (sem parâmetros) de brinde.
+ Uma classe pode ter *vários construtores* diferentes.

#figure(
  raw(read("code/aula-poo-02-classes/Criatura_5.java"), lang: "java", block: true),
  caption: [Construtor que exige nome, vida, tipo e força na criação.]
)

Com construtor, o gesto de criação fica muito mais seguro:

#figure(
  raw(read("code/aula-poo-02-classes/Universo_5.java"), lang: "java", block: true),
  caption: [Criando criaturas já completas, direto no construtor.]
)

Sem construtor, é como um universo sem Big Bang: até existe, mas nada acontece.

=== A palavra-chave `this`

Dentro de um método ou construtor, `this` se refere ao *próprio objeto* — à instância que está executando a ação. Quando escrevemos `this.nome = nome`, estamos dizendo: "o atributo `nome` *deste objeto* recebe o valor do parâmetro `nome`".

=== Múltiplos construtores

Uma classe pode ter vários construtores — cada um para uma situação diferente:

#figure(
  raw(read("code/aula-poo-02-classes/Criatura_6.java"), lang: "java", block: true),
  caption: [Dois construtores: um completo, outro simplificado que delega ao primeiro.]
)

#figure(
  raw(read("code/aula-poo-02-classes/Conta_4.java"), lang: "java", block: true),
  caption: [Classe `Conta` com dois construtores (com e sem limite).]
)

== Resumo visual: anatomia de uma classe

#figure(
  image("img/aula-poo-02-classes/criatura_nova_03.svg"),
  caption: [Anatomia completa de uma classe: atributos, construtores e métodos.],
)

Uma classe sem construtor é como uma receita sem instruções de preparo. Uma classe sem métodos é uma ficha cadastral que nunca faz nada. Junte os três — atributos, construtor, métodos — e você tem um molde pronto para dar vida a quantas criaturas quiser.

]

#post-layout(meta, body)
