#import "@preview/callisto:0.3.0"

#let (output, execute, evaluate,
    stage-notebook) = callisto.config(
  nb: path("callisto-execute-export.ipynb"),
  kernel: "python3",
  theme: "neat",
)
#show raw.where(lang: "py-x"): it => {
  set text(1em/0.8)
  execute(it)
}
#stage-notebook()

Here is a plot of $y = x^2$ :

```py-x
import matplotlib.pyplot as plt
plt.rcParams['figure.figsize'] = (3, 2)
x = [1, 2, 3, 4]
y = [1, 4, 9, 16]
plt.plot(x, y);
```

The plot uses #evaluate(`len(x)`) data points.

Here is how to expand $(a+b)^2$ with SymPy:

```py-x
#| output: false
import sympy as sp
a, b = sp.symbols('a b')
sp.expand((a+b)**2)
```<sympy-calc>

The result is: #output(<sympy-calc>)