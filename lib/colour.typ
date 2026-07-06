#let dark = sys.inputs.dark.len() > 0

#import "@preview/gruvy:2.1.0": gruvbox, theme-colors

// This article is being written in Scotland, the UK.
#let colour = if dark { 
  theme-colors.dark.soft
} else {(
  fg0: black, fg1: luma(10%), fg2: luma(30%), fg3: gray, fg4: silver,
  bg0: white, bg1: white, bg3: luma(70%), bg4: luma(60%)
)}

#let enable-colours = if dark { gruvbox.with(theme-color: colour) } else { (x) => x }
