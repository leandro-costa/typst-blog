## 1. Verificação da API do IJava

- [x] 1.1 Confirmar a versão/fork do kernel IJava instalado no ambiente do autor
- [x] 1.2 Fazer spike mínimo: exibir uma `image/png` (bytes em base64) via API do IJava em uma célula de teste, validando a assinatura exata do método de display
- [ ] 1.3 Documentar no design.md a assinatura confirmada e o fallback (ex.: exibir via `BufferedImage`)

## 2. Implementação da mágica

- [ ] 2.1 Escrever a célula de configuração com `%maven net.sourceforge.plantuml:plantuml:<versão pinada>`
- [ ] 2.2 Importar as classes necessárias (`SourceStringReader`, `ByteArrayOutputStream`, `Base64`, API do IJava)
- [ ] 2.3 Registrar a mágica `plantuml` via `getMagics().registerCellMagic(...)`
- [ ] 2.4 Implementar autocompletar das tags `@startuml`/`@enduml` quando ausentes
- [ ] 2.5 Gerar bytes PNG com `SourceStringReader.outputImage` e codificar em base64
- [ ] 2.6 Emitir a saída como `image/png` (display_data com mimetype `image/png`), não `text/html`
- [ ] 2.7 Tratar exceções e retornar mensagem de erro legível

## 3. Verificação de dependências no build

- [x] 3.1 Adicionar em `scripts/build.ts` verificação de `typst` e `bun` (engines) antes de compilar
- [x] 3.2 Adicionar verificação de `java` (kernel IJava) no build para a feature PlantUML
- [x] 3.3 Adicionar verificação de `graphviz` quando o notebook usa diagramas que o exigem
- [x] 3.4 Emitir mensagem de erro clara identificando a dependência ausente e abortar com `exit(1)`

## 4. Validação

- [x] 4.1 Executar a mágica em uma célula com diagrama de sequência (`Alice -> Bob`) e confirmar exibição no Jupyter
- [x] 4.2 Salvar o notebook e renderizar via Callisto, confirmando que o diagrama aparece como imagem nativa no blog/livro
- [x] 4.3 Testar diagrama sem tags `@startuml` e com tags já presentes
- [x] 4.4 Confirmar funcionamento offline de diagrama de sequência (sem rede/Graphviz)
- [ ] 4.5 Testar comportamento de erro para diagrama inválido
- [x] 4.6 Testar o build com cada dependência ausente para confirmar a mensagem de erro clara