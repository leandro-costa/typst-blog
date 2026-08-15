// templates/codly.typ
// Padronização de exibição de código (PDF + preview) via pacote codly.
// O site (HTML) continua usando o CSS (.post-content pre) para o fundo.

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

// Aplica o tema de código ao conteúdo passado (PDF/preview).
#let apply-codly(body) = {
  show: codly-init.with()
  codly(languages: codly-languages)
  body
}