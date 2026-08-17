#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Tinymist: O LSP para Typst",
  date: "2026-08-10",
  
  tags: ("typst", "tinymist", "lsp", "editor"),
  excerpt: "Conheça o Tinymist, o Language Server Protocol que transforma a experiência de edição de documentos Typst.",
)

#let body = [

O #link("https://github.com/Myriad-Dreamin/tinymist")[Tinymist] é um servidor de linguagem (LSP) completo para Typst, desenvolvido pela comunidade. Ele transforma qualquer editor compatível com LSP em um ambiente de desenvolvimento poderoso para documentos Typst.

== Funcionalidades

O Tinymist oferece um conjunto impressionante de recursos:

=== Destaque semântico

Além do destaque sintático básico, o Tinymist fornece *semantic highlighting*, que distingue diferentes usos de símbolos (funções, variáveis, labels, etc.).

=== Ações de código

*Quick fixes* e refatorações como:
- Aumentar/diminuir nível de headings
- Converter equações entre inline, block e multi-line

=== Formatação

Integração com formatadores como `typstfmt` ou `typstyle`, permitindo manter um estilo consistente em todo o projeto.

=== Preview em tempo real

Uma das funcionalidades mais impressionantes é o preview instantâneo. A cada alteração no documento, o Tinymist recompila e atualiza a visualização no navegador:

```bash
# No VS Code, use o comando:
# Tinymist: Start Default Preview
```

== Integração com editores

O Tinymist funciona com diversos editores:

| Editor | Extensão/Plugin |
|--------|-----------------|
| VS Code | Tinymist Typst |
| Neovim | `nvim-lspconfig` + `typst-preview.nvim` |
| Helix | Suporte LSP nativo |
| Kate | Via LSP |

== Configuração no Neovim

```lua
-- Iniciar preview
vim.lsp.get_clients({ name = "tinymist" })[1]:exec_cmd({
  command = "tinymist.startDefaultPreview",
  title = "Preview"
})
```

== Considerações

Embora o Tinymist seja extremamente capaz, vale notar que o preview contínuo pode consumir mais bateria em laptops, já que recompila a cada keystroke. Para sessões longas de escrita, considere desabilitar o preview automático.
]

#post-layout(meta, body)
