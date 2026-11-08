#import "@preview/intextual:0.1.1": flushr
#import "colour.typ": colour
#import "@preview/great-theorems:0.1.2": mathblock, proofblock, great-theorems-init

#let left-stroke-colour = 2pt + colour.muted.blue
#let stroke-colour = colour.fg3
#let definition = mathblock(blocktitle: "Definition", inset: (1em), stroke: (left: left-stroke-colour))
#let meta-prop = mathblock(blocktitle: "Context", stroke: (left: left-stroke-colour), inset: (left: 1em, y: 5pt))
#let conclusion = mathblock(blocktitle: "Conclusion", inset: (x: 5pt,y: 7pt), fill: colour.bg0, stroke: .5pt + stroke-colour)
#let abstr-nons = mathblock(blocktitle: "Abstract nonsense", inset: (left: 1em, y: .6em), stroke: (left: left-stroke-colour, top: left-stroke-colour))
#let derivation = proofblock(blocktitle: "Derivation", prefix: [_Derivation_.])

#let derivation-end-here = flushr(math.square)

#let proof = proofblock()
