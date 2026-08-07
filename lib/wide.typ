#import "colour.typ": colour
#let wide = "a5" not in sys.inputs
#let page-setup = if wide { "a4" } else { "a5" }
#let grid-columns-count = if wide { 3 } else { 1 }
#let grid-vline-if-wide = if wide { (grid.vline(stroke: colour.bg4), []) }
