#import "colour.typ": colour
#if "a5" in sys.inputs and sys.inputs.a5 not in ("", "0", "1") {
  PARAM_ERROR /* ERROR: `wide` parameter not set correctly! Must be either empty, 0 or 1. */
}

#let wide = "a5" not in sys.inputs or sys.inputs.a5 != "1"
#let page-setup = if wide { "a4" } else { "a5" }
#let grid-columns-count = if wide { 3 } else { 1 }
#let grid-vline-if-wide = if wide { (grid.vline(stroke: colour.bg4), []) }
