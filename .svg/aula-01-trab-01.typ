// Gerado automaticamente — não edite à mão.
#set page(height: auto, margin: 10pt)
#let toc-seq = counter("toc-seq")
#let fig-seq = counter("fig-seq")
#show heading: it => {
  toc-seq.step()
  let n = toc-seq.get().first()
  link("#sec-" + str(n))[#it]
}
#show figure: it => {
  fig-seq.step()
  let n = fig-seq.get().first()
  link("#fig-" + str(n))[#it]
}
#show link: it => {
  let d = it.dest
  if type(d) == label {
    link("#" + str(d))[#it.body]
  } else {
    it
  }
}
#include "../posts/trabalhos/aula-01-trab-01.typ"