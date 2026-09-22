#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Greenfoot: programando com o mundo na tela",
  date: "2026-06-02",
  tags: ("java", "greenfoot", "heranca", "tutorial"),
  excerpt: "Chega de imaginar objetos só no papel — no Greenfoot você vê caranguejos, lagostas e minhocas se mexendo de verdade, e cada bug vira um bicho fazendo besteira na tela.",
)

#let body = [

== Interagindo com o Greenfoot

Este tutorial usa um cenário chamado "wombats" — baixe o arquivo do cenário na fonte original do curso (arquivo `wombats.gfar`) e abra-o no Greenfoot. Você deve ver isto:

#figure(
  image("img/aula-poo-08-greenfoot/Cenario-principal.png"),
  caption: [Cenário principal do Greenfoot, com o mundo dos wombats.],
)

Se você não vir o mundo, e as classes à direita estiverem com barras diagonais, é porque o código ainda não foi compilado — clique em "Compilar" no canto inferior direito.

A área quadriculada que cobre a maior parte da janela é o *mundo*. À direita fica o painel de classes, com todas as classes Java do projeto — `World` e `Actor` sempre estarão lá (vêm com o Greenfoot); as demais pertencem ao cenário específico. Abaixo do mundo ficam os controles de execução (`Act`, `Run`, `Reset` e o controle de velocidade).

#figure(
  image("img/aula-poo-08-greenfoot/Annotated-interface.png"),
  caption: [Interface anotada do Greenfoot.],
)

=== Colocando objetos no mundo

Clique com o botão direito na classe `Wombat` no painel de classes:

#figure(
  image("img/aula-poo-08-greenfoot/Classe-popup-wombat-plain.png"),
  caption: [Menu de contexto da classe `Wombat`.],
)

Escolha `new Wombat()` e clique em qualquer lugar do mundo — parabéns, você acabou de criar um objeto e colocá-lo no mundo. Wombats comem folhas, então coloque algumas folhas também (classe `Leaf`). Dica: segure `Shift` e clique repetidamente no mundo para posicionar vários objetos da classe selecionada de uma vez, sem precisar abrir o menu toda hora.

=== Fazendo os objetos agirem

Clique em `Act`: cada objeto executa uma rodada do que foi programado pra fazer. Folhas não fazem nada; wombats se movem para frente e comem qualquer folha no caminho. Clique em `Run` para repetir `Act` automaticamente, em alta velocidade — o botão vira `Pause`, e o controle deslizante ao lado ajusta a velocidade.

Você também pode invocar métodos individuais direto num objeto do mundo (clique direito nele, não na classe):

#figure(
  image("img/aula-poo-08-greenfoot/Ator-pop-up-wombat-plain.png"),
  caption: [Menu de contexto de um wombat já no mundo.],
)

Experimente `turnLeft()` ou `move()`. Alguns métodos devolvem resposta — `getLeavesEaten()`, por exemplo, informa quantas folhas aquele wombat já comeu.

O mundo em si também é um objeto com métodos próprios: clique com o botão direito num espaço vazio do mundo para ver seu menu.

#figure(
  image("img/aula-poo-08-greenfoot/World-popup-wombatworld-plain.png"),
  caption: [Menu de contexto do mundo.],
)

`populate()` cria vários wombats e folhas de uma vez. `randomLeaves(int howMany)` espalha folhas aleatoriamente — repare que ele pede um parâmetro (`howMany`, um `int`): ao invocá-lo, uma caixa de diálogo pede o valor.

== Movimento e controle de teclado

Baixe o cenário inicial do `Crab` na fonte do curso e abra-o no Greenfoot — você verá um mundo arenoso vazio:

#figure(
  image("img/aula-poo-08-greenfoot/principal-dos-Caranguejos.png"),
  caption: [Cenário inicial do caranguejo.],
)

Clique com o botão direito em `Crab`, escolha `new Crab()` e posicione o caranguejo no mundo:

#figure(
  image("img/aula-poo-08-greenfoot/new_crab.png"),
  caption: [Criando um novo `Crab`.],
)

Clique em `Run`. Nada acontece — seu caranguejo é preguiçoso! Vamos abrir o código-fonte (clique duplo na classe, ou botão direito → "Abrir Editor"):

#figure(
  image("img/aula-poo-08-greenfoot/class-popup-Crab-open-editor.png"),
  caption: [Abrindo o editor da classe `Crab`.],
)

O `act()` está vazio:

#figure(
  image("img/aula-poo-08-greenfoot/edit-Crab-act.png"),
  caption: [O método `act()` sem nenhuma instrução.],
)

Preencha com uma instrução de movimento:

```java
public void act(){
  move(4);
}
```

Cuidado com maiúsculas, ponto e vírgula, e parênteses — Java é implicável com isso. Compile, coloque um caranguejo no mundo e clique em `Run`: ele desliza até bater na borda e parar ali (na real, ele continua tentando se mover, só que o Greenfoot não deixa sair do mundo). Mude o `4` para outro valor e veja o efeito — inclusive um número negativo.

Agora vamos fazer o caranguejo girar também, adicionando `turn(3)` depois do `move`:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco01.java"), lang: "java", block: true),
  caption: [Caranguejo que se move e gira, formando um círculo.]
)

O caranguejo passa a andar em círculos — e, de quebra, sempre acaba se afastando da borda quando bate nela. Melhor ainda seria controlar essa rotação pelo teclado:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco02.java"), lang: "java", block: true),
  caption: [Girando o caranguejo com as setas esquerda/direita do teclado.]
)

Usamos um método do Greenfoot pra checar se uma tecla está pressionada — `"left"` e `"right"` são as setas, mas você pode trocar por `"a"`/`"d"` se preferir. Compile e teste; ajuste os números pra mudar a velocidade de rotação. Se colocar vários caranguejos no mundo, todos giram juntos, porque todos rodam o mesmo código — você virou o mestre de uma dança sincronizada de crustáceos. E se você segurar esquerda e direita ao mesmo tempo? Testa e descobre.

== Detectando toques, removendo atores, criando métodos

=== Comendo minhocas

Vamos criar a classe `Worm` (clique direito em `Actor` → "nova subclasse", nome `Worm` com W maiúsculo — convenção Java).

#figure(
  image("img/aula-poo-08-greenfoot/class-popup-Actor-new-subclass.png"),
  caption: [Criando uma subclasse de `Actor`.],
)

#figure(
  image("img/aula-poo-08-greenfoot/new-class-worm.png"),
  caption: [Nova classe `Worm`, com a imagem `worm.png`.],
)

`Worm` não precisa de código nenhum — minhocas são paradas e burras, presa fácil. O objetivo é fazer o `Crab` comer a minhoca ao passar por cima dela. O código atual do `Crab`:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco02.java"), lang: "java", block: true),
  caption: [`Crab` antes de aprender a comer.]
)

Usamos `isTouching(Worm.class)` para checar contato, e `removeTouching(Worm.class)` só quando houver uma minhoca ali de fato:

```java
if (isTouching(Worm.class)) {
    removeTouching(Worm.class);
}
```

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco04.java"), lang: "java", block: true),
  caption: [`Crab` completo, comendo minhocas no caminho.]
)

Compile, espalhe minhocas e um caranguejo, e guie-o com as setas até devorar tudo.

=== Refatoração: separando responsabilidades

O método `act()` do caranguejo já faz duas coisas distintas: mover/girar e comer. Vamos extrair cada comportamento pra um método próprio — `moveAndTurn()` e `eat()` — sem mudar o resultado final, só a organização (isso se chama *refatoração*):

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco05.java"), lang: "java", block: true),
  caption: [`act()` delegando para `moveAndTurn()` e `eat()`.]
)

Nada de comportamento mudou — só ficou mais fácil de ler.

=== Mostrando o placar

Adicione um atributo privado `int quantidade`, inicializado em 0, e incremente-o (mostrando na tela) toda vez que uma minhoca é comida:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco06.java"), lang: "java", block: true),
  caption: [Contando e exibindo quantas minhocas o caranguejo já comeu.]
)

== Salvando o mundo, criando e tocando som

=== Salvando o mundo

Cansado de recriar o cenário toda vez que compila? O Greenfoot escreve esse código pra você: com minhocas e um caranguejo já posicionados, clique com o botão direito no mundo e escolha "Save the World":

#figure(
  image("img/aula-poo-08-greenfoot/world-popup-CrabWorld-save-the-world.png"),
  caption: [Salvando o estado atual do mundo.],
)

Isso gera código dentro de `CrabWorld` que recria essas posições sempre que o cenário reinicia:

#figure(
  raw(read("code/aula-poo-08-greenfoot/CrabWorld.java"), lang: "java", block: true),
  caption: [Construtor de `CrabWorld` com os atores salvos.]
)

Para mudar o tamanho do mundo, ajuste o `super(560, 560, 1)` no construtor: largura, altura, e tamanho da célula em pixels.

=== Tocando e gravando sons

O cenário já vem com `eating.wav`. Toque-o quando o caranguejo comer uma minhoca, com `Greenfoot.playSound(...)`:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco08.java"), lang: "java", block: true),
  caption: [Tocando um som ao comer uma minhoca.]
)

Se você tiver microfone, dá pra gravar seus próprios sons pelo menu "Controles":

#figure(
  image("img/aula-poo-08-greenfoot/scenario-menu-controls-show-sound-recorder.png"),
  caption: [Abrindo o gravador de som.],
)

#figure(
  image("img/aula-poo-08-greenfoot/sound-recorder.png"),
  caption: [O gravador de som do Greenfoot.],
)

Grave, e normalmente vai sobrar um silêncio no início e no fim:

#figure(
  image("img/aula-poo-08-greenfoot/sound-recorder-need-trim.png"),
  caption: [Trechos de silêncio a serem cortados no início e no fim da gravação.],
)

Selecione só a parte útil e clique em "Cortar para seleção" — o silêncio do começo é o mais chato de deixar, porque cria a sensação de atraso. Salve com outro nome (`myeating.wav`, por exemplo) e troque a referência no código.

== Um jogo de dois jogadores

Crie uma classe `Lobster` com o mesmo código do `Crab`, mas trocando os controles para `Q`/`W`:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco09.java"), lang: "java", block: true),
  caption: [`Lobster`, controlada por `Q`/`W`.]
)

Agora dá pra competir: quem come mais minhocas?

=== Usando herança de verdade

`Crab` e `Lobster` têm código quase idêntico — a receita clássica pra usar herança. Extraímos o que é comum pra uma classe `Decapoda`:

#figure(
  raw(read("code/aula-poo-08-greenfoot/Decapoda.java"), lang: "java", block: true),
  caption: [Classe `Decapoda`, com o comportamento comum aos crustáceos do jogo.]
)

E fazemos `Crab` e `Lobster` estenderem `Decapoda`:

#figure(
  raw(read("code/aula-poo-08-greenfoot/Crab.java"), lang: "java", block: true),
  caption: [`Crab` agora como subclasse de `Decapoda`.]
)

#figure(
  raw(read("code/aula-poo-08-greenfoot/Lobster.java"), lang: "java", block: true),
  caption: [`Lobster` agora como subclasse de `Decapoda`.]
)

#figure(
  image("img/aula-poo-08-greenfoot/heranca.png"),
  caption: [A hierarquia de herança resultante no Greenfoot.],
)

== Um inimigo que se move sozinho

O jogo tá fácil demais — falta tensão. Hora de um inimigo que coma caranguejos: um *cavalo-marinho*, criado como uma nova subclasse de `Actor` (a imagem já vem disponível no cenário). Faça-o se mover em linha reta e comer caranguejos no caminho — você já sabe como fazer isso pelas seções anteriores.

Pra deixá-lo menos previsível, use `Greenfoot.getRandomNumber(...)` pra girar uma quantidade aleatória a cada quadro:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco13.java"), lang: "java", block: true),
  caption: [Primeira tentativa: giro aleatório a cada quadro.]
)

O resultado é meio bobo — gira demais, sempre pro mesmo lado. Ajuste pra virar só ocasionalmente (10% de chance por quadro):

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco14.java"), lang: "java", block: true),
  caption: [Girando só ocasionalmente, com 10% de chance por quadro.]
)

E pra girar pros dois lados (não só direita), desloque o intervalo do número aleatório:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco15.java"), lang: "java", block: true),
  caption: [Girando entre -45° e +45°, pra qualquer lado.]
)

Por fim, pra ele não ficar preso nas bordas, force um giro de 180° quando estiver perto do limite do mundo:

#figure(
  raw(read("code/aula-poo-08-greenfoot/bloco16.java"), lang: "java", block: true),
  caption: [Virando 180° ao se aproximar da borda do mundo.]
)

Compile, espalhe caranguejos, cavalos-marinhos e minhocas — e tente sobreviver.

== Exercício rápido

- Escolha um conjunto de imagens num banco de assets gratuito (procure por "top down" em bancos de imagens de jogos).
- Crie um projeto no Greenfoot com um mundo e dois atores.
- Faça um dos atores remover o outro (igual fizemos com `Crab` e `Worm`).

]

#post-layout(meta, body)
