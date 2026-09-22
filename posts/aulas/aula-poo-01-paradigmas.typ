#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Paradigmas de Programação",
  date: "2026-02-12",
  tags: ("java", "paradigmas", "poo"),
  excerpt: "Antes de criar qualquer universo de código, você precisa escolher as regras do jogo. Bem-vindo aos paradigmas de programação — e à Orientação a Objetos.",
)

#let body = [

== Antes de criar, escolha as regras 🌌

Imagina que você é uma divindade recém-formada, de plantão num sábado qualquer, prestes a criar um universo do zero. Antes de sair distribuindo estrelas e planetas, você precisa decidir *como* esse universo vai funcionar. Vai ter gravidade? Vai ter café da manhã? Tudo bem, exagero — mas na programação a pergunta é parecida: antes de escrever a primeira linha, você decide *como* vai organizar o seu código. Essa decisão tem nome: *paradigma*.

A palavra vem do grego _parádeigma_, que significa "modelo" ou "exemplo a seguir". Na prática, um paradigma é a filosofia por trás da linguagem — a forma como você organiza o pensamento para resolver problemas. Duas linguagens podem resolver o mesmo problema de jeitos completamente diferentes, dependendo do paradigma que seguem.

== Os principais paradigmas

#figure(
  table(
    columns: 3,
    [*Paradigma*], [*Ideia central*], [*Exemplo de linguagem*],
    [Imperativo / Estruturado], [Sequência de instruções que mudam o estado do programa], [C, Pascal],
    [Orientado a Objetos], [Organização em objetos que possuem dados e comportamentos], [Java, C\#, Python],
    [Funcional], [Avaliação de funções matemáticas puras], [Haskell, Elixir],
    [Lógico], [Regras e inferências lógicas], [Prolog],
    [Declarativo], [Descreve o que fazer, não como], [SQL, HTML],
  ),
  caption: [Exemplos de paradigmas e linguagens.]
)

Muitas linguagens modernas são *multiparadigma* — Java, Python, C\#, JavaScript deixam você misturar estilos. Mas cada uma tem um favorito, e o do Java é a *Orientação a Objetos* (POO pra íntimos). É nele que vamos morar o semestre inteiro, então bora entender por que ele existe.

== O Caos: programação estruturada 🌀

No começo era só o caos: dados de um lado, funções do outro, cada uma cutucando os dados de quem quiser. Sem dono, sem proteção, sem crachá de identidade. É basicamente uma festa em que qualquer um mexe na geladeira de qualquer um.

#figure(
  image("img/aula-poo-01-paradigmas/funcoes_01.svg"),
  caption: [Paradigma estruturado: dados soltos, funções livres para mexer em qualquer um deles.],
)

Funciona — para programas pequenos. Só que, conforme o projeto cresce, esse "qualquer função acessa qualquer dado" vira uma bagunça digna de quarto de adolescente: tudo existe, nada tem lugar certo, e ninguém mais sabe o que mexeu em quê.

== A Ordem: orientação a objetos ✨

Agora imagina alguém botando ordem nesse caos: cada coisa ganha um *corpo* — dados e comportamentos morando juntos, dentro da mesma estrutura, chamada *classe*. Cada exemplar criado a partir dela é um *objeto*: uma entidade só sua, com nome, características e poderes próprios.

#figure(
  image("img/aula-poo-01-paradigmas/criatura_02.svg"),
  caption: [Paradigma orientado a objetos: dados e comportamentos vivem juntos dentro da classe.],
)

Esse "morar junto" muda tudo:

- Cada objeto carrega seus próprios dados e sabe o que fazer com eles.
- Cada objeto é único — mesmo vindo do mesmo molde, dois objetos nunca são a mesma coisa.
- Ninguém acessa as entranhas de um objeto sem pedir licença primeiro (isso é *encapsulamento* — aula em breve).
- Objetos podem ter famílias (herança) e assinar contratos de comportamento (interfaces) — spoilers das próximas aulas.

Orientação a Objetos não é só um jeito de escrever código: é um jeito de *pensar*. Em vez de dar ordens diretas ao computador, você passa a criar seres que sabem se virar sozinhos.

== Mão na massa: C vs Java

Vamos comparar na prática, com um exemplo bem simples: uma criatura que tem nome e vida.

=== No Caos (em C)

Dados e funções vivem em bairros separados. Qualquer função entra na casa da criatura e mexe no que quiser.

#figure(
  raw(read("code/aula-poo-01-paradigmas/bloco01.c"), lang: "C", block: true),
  caption: [Struct e funções separadas em C: os dados de `fenix` ficam completamente expostos.]
)

Repara no fim do código: alguém deu `fenix.vida = 999999` e ninguém no universo impediu. Essa é a treta da programação estruturada:

- Os dados ficam expostos — qualquer parte do código altera `vida` como quiser.
- `receberDano` e `exibirStatus` não *pertencem* à criatura, existem soltas por aí.
- Para uma nova criatura (dragão, guerreiro), é copiar e colar funções ou empilhar `if-else`.
- Conforme o projeto cresce, vira um emaranhado de funções e `structs` sem relação clara entre si.

=== Na Ordem (em Java)

Agora dados e comportamentos moram sob o mesmo teto.

#figure(
  raw(read("code/aula-poo-01-paradigmas/Criatura.java"), lang: "java", block: true),
  caption: [Classe `Criatura` em Java: atributos e métodos declarados juntos, no mesmo endereço.]
)

#figure(
  raw(read("code/aula-poo-01-paradigmas/Universo.java"), lang: "java", block: true),
  caption: [Duas criaturas independentes nascendo do mesmo molde.]
)

O que muda de verdade:

- `nome` e `vida` moram *dentro* da classe `Criatura` — são dela, ponto final.
- `receberDano()` e `exibirStatus()` também moram lá dentro: a criatura sabe cuidar de si mesma.
- `fenix` e `smaug` são objetos independentes, cada um com sua própria cópia dos atributos — gêmeos que vivem vidas separadas.
- O `main` não precisa saber *como* a criatura recebe dano, só precisa pedir. É o embrião do encapsulamento — tema de uma aula bem próxima.

== Resumo da ópera

#figure(
  image("img/aula-poo-01-paradigmas/paradigma_03.svg"),
  caption: [Lado a lado: estruturado com dados e funções separados; orientado a objetos com tudo junto na classe.],
)

#figure(
  table(
    columns: 3,
    [*Aspecto*], [*Estruturado*], [*Orientado a Objetos*],
    [Organização], [Dados + funções separados], [Dados + métodos juntos (classe)],
    [Unidade básica], [Função / procedimento], [Objeto],
    [Dados], [Expostos (qualquer um acessa)], [Protegidos (encapsulamento)],
    [Reutilização], [Copiar e colar funções], [Herança e composição],
    [Complexidade], [Funciona bem para problemas pequenos], [Escala para sistemas grandes],
  ),
  caption: [Resumo comparativo entre os dois paradigmas.]
)

A programação estruturada não é vilã da história — ela é ótima para scripts curtos e automações simples. Mas quando o universo cresce, a Orientação a Objetos entrega as ferramentas certas para organizar, proteger e reaproveitar código sem enlouquecer no processo. A partir da próxima aula, você começa a criar seus próprios moldes.

]

#post-layout(meta, body)
