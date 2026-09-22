#import "@preview/callisto:0.3.0"

// Configura o arquivo de intercâmbio do notebook
#let (output, execute, evaluate, stage-notebook) = callisto.config(
  nb: path("export.ipynb"),
  kernel: "python3",
)

// Indica ao Typst para interceptar blocos com a tag "py-x" e processá-los pelo Callisto
#show raw.where(lang: "py-x"): it => execute(it)

= Relatório com Código Executável

Abaixo está o bloco de código que será exportado para o notebook e executado:

```py-x
import matplotlib.pyplot as plt
plt.plot([1, 2, 3], [4, 5, 6])
plt.show()
```
