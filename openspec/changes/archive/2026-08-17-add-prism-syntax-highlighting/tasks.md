## 1. Configuração e Inclusão de Scripts

- [x] 1.1 Atualizar templates do site (`site.typ` e geradores) para incluir os scripts do Prism.js Core e Autoloader via CDN
- [x] 1.2 Adicionar script de inicialização para mapear atributos `data-lang` emitidos pelo Typst para classes `language-*` reconhecidas pelo Prism

## 2. Tema CSS Estilo Codly

- [x] 2.1 Criar regras de estilo CSS em `assets/css/style.css` (ou folha dedicada) com a paleta de cores inspirada no `codly`
- [x] 2.2 Estilizar blocos `<pre>` e `<code>` com espaçamento, cantos arredondados e tipografia monoespaçada
- [x] 2.3 Adicionar estilos para badge/indicador visual de linguagem e tokens de sintaxe (keywords, strings, números, funções)

## 3. Validação e Testes

- [x] 3.1 Executar build do blog (`npm run build`) e verificar que as páginas HTML contêm os scripts e estilos
- [x] 3.2 Iniciar servidor de preview (`npm run serve`) e validar visualmente o realce de sintaxe em posts com código Typst e outras linguagens
