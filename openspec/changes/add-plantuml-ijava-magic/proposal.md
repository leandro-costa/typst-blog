## Why

O autor deseja escrever diagramas PlantUML diretamente em células de notebooks Jupyter com o kernel IJava usando uma sintaxe limpa `%%plantuml`, e que esses diagramas sobrevivam à renderização via Callisto nos posts e no livro Typst. O código comumente compartilhado para esse magic emite a saída como `text/html` com um `<img>` base64 — isso renderiza no Jupyter, mas não no blog, porque o Callisto trata `text/html` como Markdown e não interpreta a tag HTML como imagem.

## What Changes

- Criar um magic de célula `%%plantuml` registrado no kernel IJava.
- O magic deve renderizar a célula como **`image/png`** (display_data com mimetype `image/png`, bytes em base64), e não como `text/html`, para que o diagrama seja renderizado nativamente pelo Callisto (handler `image-base64` → `std.image()`), idêntico aos plots matplotlib já suportados.
- Suportar sintaxe PlantUML com ou sem tags `@startuml`/`@enduml` (adicionando-as automaticamente quando ausentes).
- Registrar a dependência da biblioteca PlantUML via `%maven` em tempo de execução.
- Garantir funcionamento 100% offline para diagramas que não exigem Graphviz (ex.: sequência); diagramas que exigem Graphviz (classe, componente, atividade, estado) dependem do executável instalado no sistema.
- Validar empiricamente a assinatura exata da API do IJava para exibir saída `image/png` (o handler de `text/html` é conhecido; o de `image/png` ainda precisa de confirmação em runtime).
- Adicionar ao script de build (`scripts/build.ts`) a verificação prévia de todas as dependências antes de compilar: binário `typst` presente/funcional e runtime `bun` compatível; e, para a feature PlantUML, `java` (kernel IJava) e `graphviz` (quando o notebook usa diagramas que o exigem). Falha com mensagem de erro clara identificando a dependência ausente.

## Capabilities

### New Capabilities
- `plantuml-ijava-magic`: Capacidade de escrever e renderizar diagramas PlantUML em células de notebooks Jupyter com o kernel IJava, com saída em `image/png` compatível com a renderização via Callisto. Inclui a verificação das dependências Java/Graphviz no build.

### Modified Capabilities
- `build-tooling`: O build passa a validar a presença e funcionalidade das dependências (binário `typst`, runtime `bun`) antes de compilar, com mensagem de erro clara quando ausentes.

## Impact

- Notebooks Jupyter: células de notebook com o kernel IJava passam a aceitar a mágica `%%plantuml`.
- Dependências em runtime do kernel IJava: biblioteca `net.sourceforge.plantuml:plantuml` (baixada via `%maven`).
- Script de build (`scripts/build.ts`): passa a verificar dependências (`typst`, `bun`, `java`, `graphviz`) antes de compilar.
- Pipeline Callisto → Typst (blog e livro): diagramas PlantUML renderizados como figuras de imagem nativas, desde que a saída seja `image/png`.
- Sistema operacional: disponibilidade do Graphviz para tipos de diagrama que o exigem (sequência funciona sem ele).