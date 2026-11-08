#let dark = "dark" in sys.inputs and sys.inputs.dark=="1"
#if "dark" in sys.inputs and sys.inputs.dark not in ("", "0", "1", "-1") {
  PARAM_ERROR /* ERROR: `dark` parameter not set correctly! Must be either empty, 0 or 1. */
}
#let print = "dark" in sys.inputs and sys.inputs.dark in ("", "0")

#import "@preview/gruvy:2.1.0": gruvbox, theme-colors

// This article is being written in Scotland, the UK.
#let colour = if dark { 
  theme-colors.dark.soft
} else if print {
  (
    fg0: black, fg1: luma(10%), fg2: luma(30%), fg3: gray, fg4: silver,
    bg0: white, bg1: luma(97%), bg3: luma(70%), bg4: luma(60%),
    muted: theme-colors.light.hard.muted,
    strong: theme-colors.light.hard.strong,
  )
} else {
    theme-colors.light.hard
  }

#let enable-colours = if dark { gruvbox.with(theme-color: colour) } else { (x) => x }
#let enable-colours = gruvbox.with(theme-color: colour, print: print)
