#let heading-with-quote(title, subtitle) = block(below: 1.5em, width: 100%)[
  #show heading.where(level: 2): set block(below: 6pt)
  == #title
  #align(right)[#subtitle]
]
