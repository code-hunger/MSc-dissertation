#import "colour.typ": colour
#import "@preview/great-theorems:0.1.2": mathblock, proofblock, great-theorems-init

#let meta-prop = mathblock(blocktitle: "Context", stroke: (left: colour.fg3), inset: (left: 1em, y: 5pt))
#let conclusion = mathblock(blocktitle: "Conclusion", inset: (x: 5pt,y: 7pt), fill: colour.bg1, stroke: .5pt + colour.fg3)
#let abstr-nons = mathblock(blocktitle: "Abstract nonsense", inset: (left: 1em, y: .6em), stroke: (left: colour.fg3, top: colour.fg3))
#let derivation = proofblock(blocktitle: "Derivation", prefix: [_Derivation_.])

