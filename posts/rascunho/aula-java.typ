#import "@preview/callisto:0.3.0"

#set text(font: "Pennstander")
#show math.equation: set text(
 font: "Pennstander Math",
)
#set heading(numbering: "I.")


#callisto.render(
  nb: path("aula-java.ipynb"),
  (0, 1), // first two cells
)