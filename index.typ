#import "src/lib/colour.typ": colour, enable-colours
#import "src/lib/references.typ": myfooter
#import "src/lib/wide.typ": wide, page-base, page-args

#show: enable-colours

#set par(justify: true)
#set text(size: 11pt)

#set page(page-base, ..page-args, footer: myfooter)
#set heading(numbering: "A.1.")
#show heading.where(level: 1): set block(below: 1.5em)
#show heading.where(level: 2): set block(below: 1.1em)
#show heading.where(level: 3): set block(below: 1em)
#show heading.where(level: 4): set heading(numbering: none)

#show "Ito": "Itô" // hihi
#show "Borel": math.cal($B$)+"orel" // is that too silly lol?

#import "@preview/wordometer:0.1.5": word-count, total-words
#show: word-count

In this document, there are #total-words words outside of math formulas.
#include("src/Omega-time duality.typ")

#include("src/The sampling problem.typ")

#pagebreak()
#include("src/The Fokker-Planck equations.typ")

= Ornstein-Uhlenbeck

Let $x ~ mu$ such that $x perp W$.

$ d Z_t &= -Z_t d t + sqrt(2) d W_t\
  Z_0 &= x $

#let calN01 = $cal(N)(0,1)$
#let integral0t = $integral_0^t$

From $e^(-t) d e^t Z_t = d Z + Z d t$ we find the solution is
$ Z_t &= e^(-t) x + sqrt(2) e^(-t) integral0t e^s dif W_t \
      &= e^(-t) x + sqrt(1 - e^(-2t)) med G_t ,
      quad
      (x, G_t) &~ mu times.o calN01 $

where we rescaled the stochastic integral to $ G_t := (1\/2 (e^(2 t) - 1))^(-1\/2) integral0t e^s dif W_s $ to get a unit normal#footnote[$integral0t e^s dif W_s$ is normal of variance $V = integral0t e^(2s) dif s = 1/2 (e^(2t)-1)$, thus $G_t := V^(-1\/2) integral0t e^s dif W_s$ is normal of variance 1.] $G_t ~ calN01$.

#pagebreak()

#include("src/The grad log correction term.typ")
