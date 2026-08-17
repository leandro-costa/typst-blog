## Context

O blog Typst renderiza notebooks Jupyter via Callisto (`aula-08-callisto.typ` usa `callisto.config(nb: path("example.ipynb"))`). O Callisto converte saídas de células para conteúdo nativo do Typst. Investigamos o código do Callisto v0.3.0 e confirmamos:

- Saídas `text/html` são tratadas pelo handler `text-html` (handlers.typ:160), que simplesmente as passa por um parser de Markdown (`markdown-generic`/`cmarker`). Uma tag HTML `<img src="data:image/png;base64,...">` **não é** uma imagem de Markdown e não é renderizada como imagem no Typst.
- Saídas `image/png` (com dados base64) caem no handler `image-base64` (handlers.typ:104) → `image-generic` → `std.image()`, renderizando nativamente. É exatamente o caminho dos plots matplotlib já presentes no `example.ipynb`.

O autor quer escrever diagramas PlantUML em células do Jupyter com kernel IJava usando a sintaxe `%%plantuml`, e que esses diagramas apareçam tanto no Jupyter quanto no blog/livro renderizado por Callisto.

## Goals / Non-Goals

**Goals:**
- Registar uma mágica de célula `%%plantuml` no kernel IJava com sintaxe limpa.
- Emitir a saída como `image/png` (display_data com mimetype `image/png`, bytes base64), compatível com a renderização nativa do Callisto.
- Suportar fonte com ou sem tags `@startuml`/`@enduml`.
- Rodar 100% offline para diagramas de sequência (sem Graphviz).
- Baixar a dependência PlantUML via `%maven` em runtime.

**Non-Goals:**
- Não criar um pacote PlantUML nativo em Typst (cetz) — o requisito explícito é o diagrama nascer no notebook IJava.
- Não modificar o código do Callisto nem do blog.
- Não suportar saídas em SVG por esta change (pode ser evolução futura).
- Não garantir suporte offline para diagramas que exigem Graphviz (classe, componente, atividade, estado).

## Decisions

### 1. Emitir saída como `image/png`, não `text/html`
O código comumente compartilhado usa `getDisplay().render(html, "text/html")` com um `<img>` base64. Isso falha na travessia Callisto → Typst. **Decisão:** o magic deve gerar os bytes PNG (via `SourceStringReader.outputImage`) e exibi-los como `image/png`.
- *Alternativa considerada:* manter `text/html`. Rejeitada porque o Callisto trata HTML como Markdown e não renderiza a tag `<img>` como imagem.

### 2. Rota de renderização confirmada no Callisto
`image/png` (base64) → handler `image-base64` → `image-generic` → `std.image()`. Idêntica aos plots matplotlib já funcionais. Isso garante que o diagrama aparece como figura nativa no blog e no PDF.

### 3. Autocompletar tags `@startuml`/`@enduml`
Se o corpo da célula não começar com `@startuml`, envolvê-lo com as tags. Assim o usuário escreve apenas o corpo do diagrama.

### 4. Dependência via `%maven`
Usar `%maven net.sourceforge.plantuml:plantuml:<versão>` na célula de configuração para baixar a biblioteca em tempo de execução. A versão precisa ser pinada (ex.: 1.2024.3) para reprodutibilidade.

### 5. API do IJava ainda não validada empiricamente
A assinatura exata para exibir `image/png` no IJava precisa ser confirmada rodando no kernel. Candidatos: `getDisplay().render(pngBytes, "image/png")` ou exibir um `BufferedImage`/`Image` nativo. Este é um ponto de verificação antes de finalizar a implementação.

### 6. Verificação de dependências no build
O `scripts/build.ts` deve checar as dependências antes de compilar, usando `runCommand` (lib.ts) para executar o binário com flag de versão (`typst --version`, `java -version`, `graphviz -V`). `bun` é o próprio runtime do script (verificado via `process.versions.bun` contra `package.json` `engines.bun`). Cada dependência ausente gera uma mensagem de erro clara identificando o que falta e o build aborta com `exit(1)`.
- *Alternativa considerada:* deixar o `runCommand` de compilação falhar sozinho quando o binário não existe. Rejeitada porque o erro genérico de spawn não indica qual dependência está ausente, dificultando o diagnóstico.
- A verificação de `typst`/`bun` é responsabilidade da capability `build-tooling`; a de `java`/`graphviz` (feature PlantUML) é da `plantuml-ijava-magic`.

## Risks / Trade-offs

- [Assinatura da API do IJava para `image/png` incerta] → Fazer um spike mínimo (célula de teste) para confirmar o método exato antes de escrever a mágica completa; manter fallback para exibir via `BufferedImage`.
- [Diagramas que exigem Graphviz não rodam sem o executável instalado] → Documentar que somente diagramas de sequência funcionam offline; exigir Graphviz para os demais.
- [Dependência via `%maven` depende de rede na primeira execução] → Fazer cache do jar para execuções seguintes offline após o primeiro download.
- [HTML `<img>` já gerado em notebooks existentes não será migrado] → Esta change cria o magic; notebooks antigos precisariam ser reexecutados para emitir `image/png`.
- [Dependência de build ausente gera erro confuso no spawn] → A verificação prévia no build valida cada binário e emite mensagem clara indicando qual dependência instalar.