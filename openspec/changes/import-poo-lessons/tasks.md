## 1. Preparação

- [x] 1.1 Criar as pastas `posts/aulas/img/`, `posts/aulas/code/` e
  `posts/exercicios/` e verificar que existem no filesystem.
- [x] 1.2 (Obsoleto — ver Context em `design.md`) Verificação de toolchain Jupyter/Java
  não é mais necessária: os diagramas já existem pré-renderizados como SVG em
  `includes/code/<tema>/plantuml/` (fonte `main-nova.typ`), então não há execução de
  notebook nesta migração.

**Nota válida para todas as tarefas "copiar SVG" abaixo**: sempre copiar o `.pu`
(fonte PlantUML) junto com o `.svg` correspondente (mesmo nome, mesma pasta
`img/aula-poo-NN-.../`), mesmo que o `.pu` não seja referenciado pelo `.typ` — serve
como fonte editável para quem precisar ajustar o diagrama depois.

## 2. Aula 01 — Paradigmas

- [x] 2.1 Criar `posts/aulas/aula-poo-01-paradigmas.typ` a partir da seção
  "Paradigmas de Programação" de `main-nova.typ` (linhas 17–169) e de
  `src/posts/01_paradigmas.md`, reescrito no tom direto do blog (sem narrativa, sem
  `box-atencao`, sem emoji); código via `raw(read(...))` de arquivos copiados (não
  colado inline); `meta` preenchida; verificar compilando o arquivo sozinho
  (`typst compile --root .`).
- [x] 2.2 Copiar `includes/code/paradigmas/{bloco01.c,Criatura.java,Universo.java}` para
  `posts/aulas/code/aula-poo-01-paradigmas/` e os diagramas (`.svg` **+ `.pu`
  correspondente**)
  `includes/code/paradigmas/plantuml/{funcoes_01,criatura_02,paradigma_03}.{svg,pu}`
  para `posts/aulas/img/aula-poo-01-paradigmas/`; verificar que os `#figure` no `.typ`
  resolvem esses caminhos.
- [x] 2.3 Criar `posts/exercicios/aula-poo-01-exer-01.typ` a partir de
  `src/desafios/01_paradigmas.md`, mesmo tom direto; verificar compilação isolada.

## 3. Aula 02 — Classes

- [x] 3.1 Criar `posts/aulas/aula-poo-02-classes.typ` a partir da seção "Classes:
  Atributos, Métodos e Construtores" de `main-nova.typ` (linhas 171–413) e de
  `src/posts/02_classes.md`, tom leve/bem-humorado, código via arquivo externo;
  verificar compilação isolada.
- [x] 3.2 Copiar os `.java` de `includes/code/classes/` efetivamente referenciados
  nessa seção (`Criatura.java`...`Criatura_6.java`, `Universo.java`...`Universo_5.java`,
  `Conta_2.java`, `Conta_3.java`, `Conta_4.java`) para
  `posts/aulas/code/aula-poo-02-classes/`, e os SVGs+`.pu` referenciados
  (`diag01_nova_01`, `universo_nova_02`, `criatura_nova_03`) para
  `posts/aulas/img/aula-poo-02-classes/`; verificado que os `#figure` resolvem os
  caminhos.
- [x] 3.3 Criar `posts/exercicios/aula-poo-02-exer-01.typ` a partir de
  `src/desafios/02_classes.md`; verificado compilação isolada.

## 4. Aula 03 — Objetos

- [x] 4.1 Criar `posts/aulas/aula-poo-03-objetos.typ` a partir da seção "Objetos:
  Referência, Comunicação, Comparação e toString" de `main-nova.typ` (linhas 415–716)
  e de `src/posts/03_objetos.md`, tom leve/bem-humorado, código via arquivo externo;
  verificado compilação isolada.
- [x] 4.2 Copiar os `.java` de `includes/code/objetos/` referenciados na seção
  (`Criatura.java`...`Criatura_4.java`, `Universo.java`...`Universo_5.java`,
  `Conta.java`...`Conta_3.java`) para `posts/aulas/code/aula-poo-03-objetos/`, e os
  SVGs+`.pu` referenciados (`diag01_01`, `diag02_02`, `diag04_04`, `universo_03`) para
  `posts/aulas/img/aula-poo-03-objetos/`; verificado que os `#figure` resolvem os
  caminhos.
- [x] 4.3 Criar `posts/exercicios/aula-poo-03-exer-01.typ` a partir de
  `src/desafios/03_objetos.md`; verificado compilação isolada.

## 5. Aula 04 — Associações

- [x] 5.1 Criar `posts/aulas/aula-poo-04-associacoes.typ` a partir da seção
  "Associações: Agregação e Composição" de `main-nova.typ` (linhas 718–894) e de
  `src/posts/04_associacoes.md`, tom leve/bem-humorado, código via arquivo externo;
  verificado compilação isolada.
- [x] 5.2 Copiar os `.java` de `includes/code/associacoes/` referenciados na seção
  (`Motor.java`, `Carro.java`, `Fornecedor.java`, `Produto.java`, `Produto_2.java`,
  `ItemCompra.java`, `Carrinho.java`, `Universo.java`, `Universo_2.java`,
  `Universo_3.java`) para `posts/aulas/code/aula-poo-04-associacoes/`, e os SVGs+`.pu`
  (`carro_01`, `produto_02`, `carrinho_03`, `diag04_04`) para
  `posts/aulas/img/aula-poo-04-associacoes/`; verificado que os `#figure` resolvem os
  caminhos.
- [x] 5.3 Criar `posts/exercicios/aula-poo-04-exer-01.typ` a partir de
  `src/desafios/04_associacoes.md`; verificado compilação isolada.

## 6. Aula 05 — Listas de Associações

- [x] 6.1 Criar `posts/aulas/aula-poo-05-listas-associacoes.typ` a partir da seção
  "Listas nas Associações" de `main-nova.typ` (linhas 896–1059) e de
  `src/posts/05_listas_associacoes.md`, tom leve/bem-humorado, código via arquivo
  externo; verificado compilação isolada.
- [x] 6.2 Copiar os `.java` de `includes/code/listas/` referenciados na seção
  (`Turma.java`, `Aluno.java`, `bloco03.java`, `Livro.java`, `bloco05.java`) para
  `posts/aulas/code/aula-poo-05-listas-associacoes/`, e os SVGs+`.pu` (`turma_01`,
  `livro_02`) para `posts/aulas/img/aula-poo-05-listas-associacoes/`; verificado que
  os `#figure` resolvem os caminhos.
- [x] 6.3 Criar `posts/exercicios/aula-poo-05-exer-01.typ` a partir de
  `src/desafios/05_listas_associacoes.md`; verificado compilação isolada.

## 7. Aula 06 — Encapsulamento

- [x] 7.1 Criar `posts/aulas/aula-poo-06-encapsulamento.typ` a partir da seção
  "Encapsulamento" de `main-nova.typ` (linhas 1061–1179) e de
  `src/posts/06_encapsulamento.md`, tom leve/bem-humorado, código via arquivo externo;
  verificado compilação isolada.
- [x] 7.2 Copiar os `.java` de `includes/code/encapsulamento/` referenciados na seção
  (`Conta.java`, `Conta_2.java`) para `posts/aulas/code/aula-poo-06-encapsulamento/`
  (esta pasta não tem `plantuml/` na fonte — nenhum diagrama a copiar).
- [x] 7.3 Criar `posts/exercicios/aula-poo-06-exer-01.typ` a partir de
  `src/desafios/06_encapsulamento.md`; verificado compilação isolada.
- [x] 7.4 Criar `posts/exercicios/aula-poo-06-exer-02.typ` a partir de
  `src/desafios/07_encapsulamento_dvd.md` (segunda entrega, mesma aula); verificado
  compilação isolada.

## 8. Aula 07 — Herança

- [x] 8.1 Criar `posts/aulas/aula-poo-07-heranca.typ` a partir da seção "Herança" de
  `main-nova.typ` (linhas 1180–1717) e de `src/posts/07_heranca.md`, tom leve/
  bem-humorado, código via arquivo externo; verificado compilação isolada. Seção é
  densa e sem narrativa na fonte (estilo Caelum/K19) — usado um subconjunto
  representativo dos exemplos (25 arquivos `.java`), não todas as ~34 variantes
  incrementais da fonte, mantendo os conceitos completos.
- [x] 8.2 Copiar os `.java` de `includes/code/heranca/` efetivamente referenciados na
  seção (`Mamifero.java`, `Morcego.java`, `bloco03.java`, `Funcionario.java`,
  `Gerente.java`, `Funcionario_2.java`, `TestaGerente.java`, `Servico.java`,
  `Servico_4.java`, `Emprestimo_7.java`, `SeguroDeVeiculo_2.java`, `Object.java`,
  `MinhaClasse.java`, `Servico_5.java`, `Emprestimo_2.java`, `TesteConstrutor.java`,
  `Pessoa.java`, `Aluno.java`, `Funcionario_3.java`, `Gerente_2.java`, `Gerente_3.java`,
  `Gerente_4.java`, `bloco24.java`, `ClasseFinal.java`, `ClasseSelada.java`) para
  `posts/aulas/code/aula-poo-07-heranca/`, e os SVGs+`.pu` referenciados
  (`mamifero_01`, `diag02_02`...`diag05_05`, `servico_06`, `diag07_07`...`diag10_10`)
  para `posts/aulas/img/aula-poo-07-heranca/`; verificado que os `#figure` resolvem os
  caminhos.
- [x] 8.3 Criar `posts/exercicios/aula-poo-07-exer-01.typ` a partir de
  `src/desafios/10_heranca.md`, copiando `Corredor.java`, `CorredorGato.java`,
  `Chegada.java` de `src/desafios/code/heranca/` (fonte VuePress, sem equivalente em
  `includes/code/`) para `posts/exercicios/code/aula-poo-07-exer-01/` e referenciando
  via arquivo externo; copiado `src/desafios/img/heranca/Mundo.png` e `Tree.png` para
  `posts/exercicios/img/aula-poo-07-exer-01/`; verificado compilação isolada.

## 9. Aula 08 — Greenfoot

- [x] 9.1 Criar `posts/aulas/aula-poo-08-greenfoot.typ` a partir da seção "Greenfoot"
  de `main-nova.typ` (linhas 1718–2081, texto completo, tutorial passo a passo já
  convertido de `src/posts/08_greenfoot.md`), adaptado ao tom do blog; copiadas as 16
  imagens referenciadas de `2026-inf-poo/src/posts/img/` para
  `posts/aulas/img/aula-poo-08-greenfoot/` e os 15 arquivos `.java` de
  `includes/code/greenfoot/` para `posts/aulas/code/aula-poo-08-greenfoot/`; o
  download do cenário `wombats.gfar` ficou mencionado em texto (sem copiar o
  binário) — decisão registrada em `design.md`; verificado compilação isolada.
- [x] 9.2 Confirmado que esta aula não tem diagrama PlantUML nem desafio pareado —
  nenhum post criado em `posts/exercicios/` para ela.

## 10. Aula 09 — Polimorfismo

- [x] 10.1 Criar `posts/aulas/aula-poo-09-polimorfismo.typ` a partir da seção
  "Polimorfismo" de `main-nova.typ` (linhas 2083–2299) e de
  `src/posts/11_polimorfismo.md`, tom leve/bem-humorado, código via arquivo externo;
  verificado compilação isolada.
- [x] 10.2 Copiar os `.java` de `includes/code/polimorfismo/` referenciados na seção
  (`Figura.java`, `TesteFiguras.java`, `Animal.java`, `Simulador.java`,
  `Funcionario.java`, `ControleDeBonificacoes.java`, `bloco07.java`,
  `EmpregadoDaFaculdade.java`, `GeradorDeRelatorio.java`, `ControleDePonto.java`,
  `Funcionario_2.java`, `ControleDePonto_2.java`, `bloco13.java`, `bloco14.java`) para
  `posts/aulas/code/aula-poo-09-polimorfismo/`, e os SVGs+`.pu` (`figura_01`,
  `animal_02`, `diag03_03`, `diag04_04`, `funcionario_05`) para
  `posts/aulas/img/aula-poo-09-polimorfismo/`; verificado que os `#figure` resolvem os
  caminhos.
- [x] 10.3 Criar `posts/exercicios/aula-poo-09-exer-01.typ` a partir de
  `src/desafios/11_polimorfismo.md`; verificado compilação isolada.

## 11. Aula 10 — Classes Abstratas

- [x] 11.1 Criar `posts/aulas/aula-poo-10-classes-abstratas.typ` a partir da seção
  "Classes Abstratas" de `main-nova.typ` (linhas 2300–2460) e de
  `src/posts/12_classes_abstratas.md`, tom leve/bem-humorado, código via arquivo
  externo; verificado compilação isolada.
- [x] 11.2 Copiar os `.java` de `includes/code/abstratas/` referenciados na seção
  (`MinhaClasse.java`, `Figura.java`, `TesteFiguras.java`, `Pessoa.java`,
  `TesteFaculdade.java`, `Funcionario.java`, `ControleDeBonificacoes.java`,
  `Conta.java`, `BebidaQuente.java`, `TesteBebidas.java`) para
  `posts/aulas/code/aula-poo-10-classes-abstratas/`, e os SVGs+`.pu` (`figura_01`,
  `pessoa_02`) para `posts/aulas/img/aula-poo-10-classes-abstratas/`; verificado que
  os `#figure` resolvem os caminhos.
- [x] 11.3 Criar `posts/exercicios/aula-poo-10-exer-01.typ` a partir de
  `src/desafios/12_classes_abstratas.md`; verificado compilação isolada.

## 12. Aula 11 — Interface

- [x] 12.1 Criar `posts/aulas/aula-poo-11-interface.typ` a partir da seção
  "Interface" de `main-nova.typ` (linhas 2461–2606) e de
  `src/posts/13_interface.md`, tom leve/bem-humorado, código via arquivo externo;
  verificado compilação isolada.
- [x] 12.2 Copiar os `.java` de `includes/code/interface/` referenciados na seção
  (`bloco01.java`, `ContaPoupanca.java`, `PrevidenciaPrivada.java`,
  `GeradorDeExtrato.java`, `TesteExtrato.java`, `Funcionario.java`,
  `TesteAutenticacao.java`, `ContaInvestimento.java`, `ExemploClasse.java`) para
  `posts/aulas/code/aula-poo-11-interface/`, e os SVGs+`.pu` (`conta_01`, `usuario_02`,
  `conta_03`) para `posts/aulas/img/aula-poo-11-interface/`; verificado que os
  `#figure` resolvem os caminhos.
- [x] 12.3 Criar `posts/exercicios/aula-poo-11-exer-01.typ` a partir de
  `src/desafios/13_interface.md`, copiando `MyWorld.java`, `Personagem.java`,
  `Comestivel.java`, `Alimento.java`, `Doce.java` de
  `src/desafios/code/interface/` (fonte VuePress) para
  `posts/exercicios/code/aula-poo-11-exer-01/` e referenciando via arquivo externo;
  verificado compilação isolada.

## 13. Validação final

- [x] 13.1 Rodado `bun run build`: 34 posts encontrados (22 novos + 12 já existentes),
  todos os 11 `posts/aulas/aula-poo-*.typ` e os 13 `posts/exercicios/aula-poo-*.typ`
  compilaram sem erro e aparecem corretamente agrupados/ordenados por `aula-poo-NN`
  na lista de posts do build. Avisos de "bloco de código sem #figure" são sobre
  blocos ```` ```java ```` soltos (exemplos curtos inline) — mesmo padrão de aviso já
  presente em posts antigos do blog, não é falha.
- [x] 13.2 Livro compilado sem erro (`dist/book.pdf` gerado pelo mesmo `bun run
  build`), incluindo as novas aulas.
- [x] 13.3 Verificado que os SVGs gerados por post (`dist/posts/aula-poo-*.svg`) têm
  tamanho consistente com conteúdo visual real embutido (ex.: 3.6 MB para a aula de
  Greenfoot, com 16 imagens; 1.5–1.9 MB para aulas com diagramas PlantUML) — como o
  Typst falha a compilação se um caminho de `image()`/`read()` não resolve, e todos
  os posts compilaram e foram inclusos no build/livro sem erro, os diagramas e blocos
  de código externos estão resolvendo corretamente.
