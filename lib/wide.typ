#let wide = false
#let page-setup = if wide { "a4" } else { "a5" }
#let grid-columns-count = if wide { 3 } else { 1 }
#let grid-vline-if-wide = if wide { grid.vline() }
