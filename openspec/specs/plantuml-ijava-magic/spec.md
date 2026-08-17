# PlantUML IJava Magic Specification

## Purpose

Registrar no kernel IJava uma mágica de célula `%%plantuml` que renderiza diagramas
PlantUML como imagem `image/png`, para exibição nativa no Jupyter e no blog/livro Typst
via Callisto.

## Requirements

### Requirement: Magic de célula `%%plantuml`
The IJava kernel SHALL register a cell magic named `plantuml`, invoked when a cell starts with `%%plantuml`, that renders the cell body as a PlantUML diagram.

#### Scenario: Célula com corpo simples
- **WHEN** o usuário executa uma célula com `%%plantuml` seguido de um corpo de diagrama (ex.: `Alice -> Bob: Oi!`)
- **THEN** a célula é tratada pela mágica `plantuml` e o diagrama é renderizado como uma imagem

#### Scenario: Diagrama sem tags `@startuml`/`@enduml`
- **WHEN** o corpo da célula não inicia com `@startuml`
- **THEN** a mágica envolve automaticamente o corpo com `@startuml`/`@enduml` antes de renderizar

#### Scenario: Diagrama com tags já presentes
- **WHEN** o corpo da célula já inicia com `@startuml`
- **THEN** a mágica usa o corpo como está, sem adicionar tags duplicadas

### Requirement: Saída como `image/png`
A mágica `plantuml` MUST emitir o diagrama como um objeto de saída do Jupyter com mimetype `image/png` (dados em base64), para que seja renderizado nativamente pelo Callisto no blog e no livro Typst.

#### Scenario: Renderização no Callisto
- **WHEN** o notebook contendo a célula `%%plantuml` é renderizado via Callisto
- **THEN** o diagrama aparece como uma imagem nativa (mesmo caminho dos plots matplotlib), em vez de HTML não interpretado

#### Scenario: Exibição no Jupyter
- **WHEN** o usuário executa a célula `%%plantuml` no Jupyter
- **THEN** o diagrama é exibido como imagem no frontend do notebook

### Requirement: Dependência da biblioteca PlantUML
A configuração MUST carregar a biblioteca `net.sourceforge.plantuml:plantuml` via `%maven` com uma versão pinada, de forma que a classe `SourceStringReader` esteja disponível em runtime.

#### Scenario: Carga da dependência
- **WHEN** o usuário executa a célula de configuração com `%maven net.sourceforge.plantuml:plantuml:<versão>`
- **THEN** a biblioteca é baixada e as classes do PlantUML ficam acessíveis no kernel

### Requirement: Funcionamento offline para diagramas de sequência
Diagramas de sequência MUST funcionar 100% offline (sem Graphviz), utilizando apenas a biblioteca PlantUML carregada.

#### Scenario: Diagrama de sequência offline
- **WHEN** o usuário renderiza um diagrama de sequência (`Alice -> Bob`) sem Graphviz instalado
- **THEN** o diagrama é gerado sem acesso à rede ou a executáveis externos

### Requirement: Erro com mensagem clara
Em caso de falha na renderização (ex.: diagrama inválido, Graphviz ausente para tipos que o exigem), a mágica MUST exibir uma mensagem de erro legível na saída da célula.

#### Scenario: Diagrama inválido
- **WHEN** o corpo da célula contém um diagrama que não pode ser renderizado
- **THEN** a mágica retorna uma mensagem de erro explicando a falha