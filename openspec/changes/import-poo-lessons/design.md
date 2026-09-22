## Context

Fonte principal: `D:\IFBA\20260IntPoo\unidade2\vibe\apostila-u3\2026-inf-poo`
(VuePress/Markdown). Ver `proposal.md` para a motivação. Pontos relevantes descobertos
na exploração:

- `src/posts/*.md` (aulas) e `src/desafios/*.md` (exercícios) **não têm numeração
  alinhada**: a aula de herança é `07_heranca.md`, mas o desafio correspondente é
  `10_heranca.md`; o desafio de encapsulamento tem duas entregas
  (`06_encapsulamento.md` e `07_encapsulamento_dvd.md`); a aula `08_greenfoot.md` não
  tem desafio correspondente. O pareamento correto é por **assunto**, não por número
  de arquivo.
- **Descoberta importante (durante a implementação)**: existe uma segunda fonte, mais
  preparada, em `D:\IFBA\20260IntPoo\unidade2\vibe\apostila-u3\main-nova.typ` — uma
  conversão prévia de TODAS as 11 aulas para Typst (pacotes locais
  `@local/ifbasaj-apostila` + `@local/sourcecraft`, usados só como referência, não
  importados pelo blog). Ela já resolve o trabalho mecânico mais custoso:
  - Código-fonte de cada aula já está em arquivos individuais, incrementais, em
    `includes/code/<tema>/*.java` (ou `.c`), ex.: `Criatura.java`, `Criatura_2.java`,
    `Criatura_3.java` — cada versão do exemplo conforme a aula evolui o conceito.
  - Diagramas PlantUML já estão **pré-renderizados como SVG** em
    `includes/code/<tema>/plantuml/*.svg` (com o `.pu` fonte ao lado), gerados uma vez
    offline. Não há `.ipynb`, não há Callisto, não há dependência de Jupyter/kernel
    IJava/Graphviz nessa fonte — os SVGs já existem, prontos para copiar.
  - `main-nova.typ` também mantém a camada narrativa mitológica e containers
    (`box-atencao`) — **decisão confirmada com o usuário**: usar esse arquivo só como
    fonte de fatos (código e diagramas certos, já testados), reescrevendo o texto
    corrido no tom direto do blog (sem narrativa, sem `box-atencao`, sem emoji), como
    já decidido no proposal.
  - Essa descoberta **elimina o plano original de gerar notebooks Jupyter/Callisto**
    por aula (verificado nesta máquina: `jupyter`/`java`/kernel `ijava` disponíveis,
    mas `graphviz`/`dot` não instalado — o que bloquearia geração de diagramas de
    classe). Como os SVGs já existem prontos, não é mais necessário executar nada.
- Nenhum post existente no blog usa `image()` com arquivo real ainda —
  `aula-07-figuras.typ` só demonstra com um placeholder gerado. Este change é o
  primeiro a introduzir imagens/diagramas reais em `posts/`.
- A fonte VuePress referencia um binário para download (`wombats.gfar`, cenário
  Greenfoot) via `src/.vuepress/public/files/`. O typst-blog não tem hoje um
  mecanismo de assets estáticos arbitrários (só `assets/css`, `assets/js`).
- `openspec/specs/post-authoring/spec.md` já define o agrupamento `(group, type,
  number)` por prefixo de nome de arquivo (`aula-01-exer-01` etc.) — é isso que usamos
  para parear aula/desafio.

## Goals / Non-Goals

**Goals:**
- Definir o mapeamento exato aula-fonte → post-destino (nome de arquivo, número,
  slug) e desafio-fonte → exercício-destino, resolvendo os descasamentos de número.
- Definir onde ficam código e diagramas de cada post (convenção de path).
- Definir o processo repetível para trazer código (`includes/code/`) e diagramas SVG
  (`includes/code/<tema>/plantuml/`) já prontos de `main-nova.typ`.
- Definir como o conteúdo é reescrito (estrutura de seções, o que se descarta).

**Non-Goals:**
- Não migrar `08_greenfoot.md` desabilitado — a aula entra, mas o download
  `wombats.gfar` fica como link externo para a fonte original (ver Risco abaixo), não
  como asset servido pelo blog.
- Não alterar `scripts/`, `templates/` ou a spec `post-authoring` — usamos só o que já
  existe.
- Não recriar os containers `::: tip/note/warning` como componente Typst — decisão já
  tomada no proposal (estilo simplificado).

## Decisions

### Mapeamento aula ↔ desafio (por assunto, renumerado sequencialmente 01–11)

| # | Slug | Aula fonte | Desafio(s) fonte |
|---|------|-----------|-------------------|
| 01 | paradigmas | `01_paradigmas.md` | `01_paradigmas.md` |
| 02 | classes | `02_classes.md` | `02_classes.md` |
| 03 | objetos | `03_objetos.md` | `03_objetos.md` |
| 04 | associacoes | `04_associacoes.md` | `04_associacoes.md` |
| 05 | listas-associacoes | `05_listas_associacoes.md` | `05_listas_associacoes.md` |
| 06 | encapsulamento | `06_encapsulamento.md` | `06_encapsulamento.md` + `07_encapsulamento_dvd.md` (2 exercícios) |
| 07 | heranca | `07_heranca.md` | `10_heranca.md` |
| 08 | greenfoot | `08_greenfoot.md` | (nenhum) |
| 09 | polimorfismo | `11_polimorfismo.md` | `11_polimorfismo.md` |
| 10 | classes-abstratas | `12_classes_abstratas.md` | `12_classes_abstratas.md` |
| 11 | interface | `13_interface.md` | `13_interface.md` |

**Por que renumerar sequencialmente (01–11) em vez de preservar os números da fonte
(01–08, 11–13)?** Preservar os números originais preservaria também o descasamento
aula/desafio (ex.: `aula-poo-07-heranca.typ` pareado com um desafio numerado
`aula-poo-10-...`, o que quebraria o agrupamento por prefixo que `post-authoring`
exige). Renumerar sequencialmente garante que aula e desafio sempre compartilhem o
mesmo prefixo `aula-poo-NN`, que é o contrato real do agrupamento.
**Alternativa considerada e descartada**: manter os números da fonte e aceitar que o
desafio de herança tenha prefixo diferente da aula — rejeitada porque quebra o
propósito do agrupamento (a spec existe para manter aula+exercício juntos).

Nomes de arquivo resultantes (exemplos): `posts/aulas/aula-poo-01-paradigmas.typ`,
`posts/exercicios/aula-poo-01-exer-01.typ`; para encapsulamento, dois exercícios:
`aula-poo-06-exer-01.typ` (o desafio original) e `aula-poo-06-exer-02.typ` (o DVD).

### Assets por post: colocados junto ao `.typ`

Segue o padrão já usado pelos notebooks existentes no blog (`example.ipynb` ao lado do
`.typ` que o usa). Cada post com imagens/diagramas/código ganha subpastas próprias:

```
posts/aulas/img/aula-poo-02-classes/anatomia-classe.svg
posts/aulas/code/aula-poo-02-classes/Criatura.java
posts/aulas/aula-poo-02-classes.typ
  → #figure(image("img/aula-poo-02-classes/anatomia-classe.svg"), kind: "diagram", ...)
  → #figure(raw(read("code/aula-poo-02-classes/Criatura.java"), lang: "java", block: true), kind: "code", ...)
```

**Alternativa considerada**: uma pasta `assets/img/` central — descartada porque quebra
a autossuficiência do post (spec `post-authoring` exige que o post renderize sozinho
quando compilado diretamente pelo Tinymist; caminho relativo curto e colocado é mais
robusto que apontar para fora de `posts/`).

### Diagramas PlantUML: copiar os SVG já renderizados em `main-nova.typ`

Não se usa Callisto/Jupyter/notebook para esta migração — os diagramas já existem
como SVG estático em `includes/code/<tema>/plantuml/*.svg` (fonte:
`D:\IFBA\20260IntPoo\unidade2\vibe\apostila-u3`). Processo:
1. Para cada diagrama referenciado no trecho relevante de `main-nova.typ`, copiar o
   `.svg` **e o `.pu` correspondente** (fonte PlantUML editável, mesmo nome) para
   `posts/aulas/img/aula-poo-NN-slug/` — o `.pu` não é referenciado pelo `.typ`, fica
   só como fonte para quem precisar editar o diagrama depois.
2. Referenciar o SVG com `#figure(image("img/aula-poo-NN-slug/nome.svg"), caption:
   [...])` (sem `kind:` explícito — ver nota abaixo).

Nota sobre `kind`: `#figure(image(...))` sem `kind:` já é inferido automaticamente
como imagem pelo Typst (com supplement padrão); passar `kind: "diagram"` como string
literal exige `supplement:` explícito (erro de compilação sem ele) e não é o que os
posts existentes do blog fazem na prática — nenhum `.typ` atual passa `kind:` em
figuras de imagem/diagrama, apesar do texto de `aula-07-figuras.typ` sugerir isso.
Confirmado compilando `aula-poo-01-paradigmas.typ`.
Não requer nenhuma dependência de build nova (nem Jupyter, nem Graphviz, nem Callisto)
— é só uma cópia de arquivo estático, resolvendo o bloqueio de toolchain encontrado
durante a implementação (`graphviz`/`dot` ausente nesta máquina).

**Abordagem original (descartada durante a implementação)**: gerar um `.ipynb` por
aula com kernel IJava executando `%%plantuml` (padrão de `aula-10-plantuml.typ`) —
descartada porque (a) os SVGs corretos já existem prontos em `main-nova.typ`, tornando
a re-execução redundante, e (b) esta máquina não tem `graphviz` instalado, o que
bloquearia parte dos diagramas (classe, componente etc.) até a instalação.

### Reescrita de conteúdo: tom leve e bem-humorado, sem boxes, público do integrado

**Decisão revisada após feedback do usuário** (a primeira versão da Aula 01 ficou
didática demais, tom "blog técnico direto" — não é isso que se quer): o público é
estudante do ensino médio integrado, e o tom deve ser **leve, bem-humorado e
atraente**, não um manual seco. A metáfora "Deus Criador / Criaturas" da fonte foi
inspirada no monólogo *Um Sábado Qualquer*, de Carlos Ruas (um stand-up sobre Deus
narrando a criação do mundo de forma descontraída e engraçada) — não é uma narrativa
religiosa séria, é uma piada estrutural. Pode (e deve) ser reaproveitada, mas de forma
econômica: humor tecendo a explicação técnica, não uma camada narrativa separada de
3 blocos com parágrafos de "Gênese" à parte.

Diretrizes concretas:
- Cada aula tem uma sequência única de `==` seções que já mistura explicação técnica
  com o tom brincalhão — não replicar a estrutura de 3 camadas (📖/🌌/💻) de
  `main-nova.typ` como 3 seções separadas; o humor entra na prosa da própria explicação.
- Sem os containers `::: tip/note/warning`/`box-atencao` — piadas e analogias ficam no
  texto corrido, não em caixas destacadas.
- Pode usar a metáfora Deus/Criatura como fio condutor leve (nomes de exemplo como
  `Criatura`, `Universo`, comentários engraçados), sem exagerar em linguagem bíblica
  solene — o objetivo é engajar, não parecer um sermão.
- Diagramas PlantUML de sequência/classe são mantidos quando ilustram conceito
  técnico (ex.: diagrama de classe mostrando atributos/métodos); os que só ilustravam
  a metáfora em si (sem valor técnico) podem ser descartados.
- Emoji com moderação são bem-vindos para dar energia ao texto (diferente da decisão
  original de "sem emoji") — desde que não vire poluição visual.

Todo código de exemplo (Java, C, qualquer linguagem) vai em **arquivo externo**, nunca
colado inline no `.typ` — mesma convenção já usada em `main-nova.typ`
(`#raw(read("caminho"), lang: "java", block: true)`). Os arquivos-fonte vêm de
`includes/code/<tema>/*.java` (já existentes, incrementais por conceito) quando o
tema tem entrada lá; quando a fonte só tiver o include `@[code](./caminho.java)` do
Markdown original sem equivalente em `includes/code/`, copia-se o `.java` referenciado
por esse include. Cada post ganha uma subpasta própria de código, no mesmo espírito da
pasta de imagens:

```
posts/aulas/code/aula-poo-01-paradigmas/Criatura.java
posts/aulas/code/aula-poo-01-paradigmas/Universo.java
posts/aulas/aula-poo-01-paradigmas.typ
  → #figure(raw(read("code/aula-poo-01-paradigmas/Criatura.java"), lang: "java", block: true), caption: [...], kind: "code")
```

**Alternativa considerada (colar o código inline no `.typ`)**: descartada durante a
implementação — o usuário pediu explicitamente arquivo externo para todo código de
exemplo, em qualquer linguagem, seguindo o padrão de `main-nova.typ`.

**Convenção de `lang:`** (confirmada com o usuário): usar `lang: "java"` (minúsculo,
convenção do codly) para Java, mas `lang: "C"` (maiúsculo) para C — mesma grafia usada
em `main-nova.typ` para blocos C.

### Exercícios: post curto por desafio, sem narrativa

`posts/exercicios/aula-poo-NN-exer-0M.typ` traz o enunciado do desafio (objetivos,
requisitos, critérios), no mesmo tom direto, com `tags` incluindo o assunto da aula.
Quando o desafio referencia código-fonte completo (`10_heranca.md`,
`13_interface.md`), os arquivos `.java` (de `src/desafios/code/<tema>/`, a fonte
VuePress — não têm equivalente em `includes/code/`) são copiados para
`posts/exercicios/code/aula-poo-NN-exer-0M/` e referenciados via `raw(read(...), lang:
"java", block: true)`, nunca colados inline.

## Risks / Trade-offs

- **[Risco] `wombats.gfar` (cenário Greenfoot) não tem onde morar no blog** — não há
  mecanismo de asset binário arbitrário hoje. → **Mitigação**: a aula `08-greenfoot`
  linka para o arquivo na fonte original (URL/caminho documentado no texto) em vez de
  servir uma cópia; se um mecanismo de download genérico for necessário no futuro, é
  um change separado (fora de escopo aqui).
- **[Risco] Perda de conteúdo pedagógico ao remover a camada narrativa** — a
  metáfora "Deus/Criatura" tem função didática de fixação. → **Mitigação**: é uma
  decisão já confirmada com o usuário (estilo simplificado, reafirmada mesmo após
  descobrir que `main-nova.typ` já traz a narrativa pronta); documentado aqui para
  rastreabilidade, não é uma pergunta em aberto.
- **[Trade-off] Cópias de `.java`/`.svg` ficam desatualizadas se `main-nova.typ` ou
  `includes/code/` mudarem depois** — como não há vínculo automático entre a fonte e o
  blog, uma correção futura na apostila original não se propaga sozinha. Aceito: a
  fonte de verdade passa a ser o `typst-blog` a partir da importação (ver proposal.md -
  Why).

## Migration Plan

1. Preparar diretórios: `posts/aulas/`, `posts/exercicios/`, `posts/aulas/img/`,
   `posts/aulas/code/`.
2. Para cada linha da tabela de mapeamento, na ordem 01→11: ler a seção correspondente
   de `main-nova.typ` para identificar quais arquivos de `includes/code/<tema>/` (código
   e SVG) são usados e em que ordem; escrever o post reescrevendo o texto no tom direto
   do blog; copiar os `.java`/`.svg` referenciados; converter o(s) desafio(s) pareado(s).
3. Rodar `bun run build` (ou equivalente) para validar que o build completo aceita os
   novos posts.
4. Sem rollback especial: são arquivos novos; reverter é `git revert`/remover os
   arquivos criados.
