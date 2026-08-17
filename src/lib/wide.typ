#import "colour.typ": colour

#if "format" in sys.inputs and sys.inputs.format not in ("", "a5", "2-column", "note-taking") {
  PARAM_ERROR /* ERROR: `wide` parameter not set correctly! Must be either empty, 0 or 1. */
}

#let format = if "format" not in sys.inputs { "" } else { sys.inputs.format }

#let wide = format == ""
#let page-base = if format in ("2-column", "") { "a4" } else { "a5" }
#let a4 = page-base == "a4"

#let page-args = (() => {
  let margins = (// more margins to allow space for note taking with other tools
    if "note-taking" in sys.inputs { (left: 1cm, top: 1cm, right: 6cm, bottom: 7cm) }
    else if format == "2-column" { (x: 1cm) }
    else if wide { 3cm }
  )
  let margins = if margins != none { (margin: margins) } else { (:) }

  let columns = if format == "2-column" { (columns: 2) } else { (:) }

  margins + columns
})()
#let grid-columns-count = if wide { 3 } else { 1 }
#let grid-vline-if-wide = if wide { (grid.vline(stroke: colour.bg4), []) }
