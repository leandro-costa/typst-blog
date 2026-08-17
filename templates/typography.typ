// templates/typography.typ
// Padrões tipográficos comuns a TODAS as exportações do corpo do artigo:
// book (PDF), SVG (site) e preview paged. Qualquer destino de exportação
// que renderize o conteúdo do post deve aplicar `article-style` em vez de
// repetir os `set` locais — assim os padrões ficam num único lugar.

#import "codly.typ": apply-codly

// Aplica a tipografia do artigo e o realce de código (codly) ao corpo.
#let article-style(body) = {
  set text(size: 11pt, lang: "pt", region: "BR")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.")
  show figure.where(kind: table): set figure.caption(position: top)

  apply-codly(body)
}