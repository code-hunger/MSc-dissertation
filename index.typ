#import "src/lib/colour.typ": colour, enable-colours
#import "src/lib/references.typ": myfooter
#import "src/lib/wide.typ": wide, page-base, page-args
#import "@preview/great-theorems:0.1.2": great-theorems-init
#import "src/lib/thm-blocks.typ": *
#import "src/symbols.typ": *

#show: enable-colours

#set par(justify: true)
#set text(size: 11pt)

#set page(page-base, numbering: "1.", ..page-args, footer: myfooter)
#let letters = ("A", "B", "C", "D", "E", "F")
// #show heading.where(level: 1): set heading(numbering: "I.")
#set heading(numbering: "I.A.1")
#show selector.or(..(2,3,4).map(l => heading.where(level: l))): set heading(numbering: (chapter, letter, ..nums) => letters.at(letter - 1) + "." + nums.pos().map(str).join("."))
#show ref.where(element: heading): set heading(numbering: "1)1)")
#show heading.where(level: 1): set block(below: 2em)
#show heading.where(level: 2): set block(below: 1.5em)
#show heading.where(level: 3): set block(below: 1.1em)
#show heading.where(level: 4): set block(below: 1em)
#show heading.where(level: 5): set heading(numbering: none)
#show: great-theorems-init

#let title-case(string) = {
  return string.replace(
    regex("[A-Za-z]+('[A-Za-z]+)?"),
    word => upper(word.text.first()) + lower(word.text.slice(1)),
  )
}
#import "@preview/titleize:0.1.1": titlecase
#show heading.where(level: 2): it => { show: titlecase; it }
#show heading.where(level: 3): it => { show: titlecase; it }

#show "Ito": "Itô" // hihi
#show "Borel": box(math.cal($B$)+"orel") // is that too silly lol?
#show "localization": "localisation"
#show "Localization": "Localisation"

#import "@preview/wordometer:0.1.5": word-count, total-words
#show: word-count

// Uni picture, title, supervisor
// #include("front/front-page.typ")

#page(columns: 1, margin: 3cm)[ 
  #heading(numbering: none)[Abstract]

  In this thesis we investigate a general pattern for sampling from probability distributions via
  Markov chains, namely the stochastic localisation approach. We first properly develop the language
  with measure theory and conditional laws. We then take a look at two concrete algorithms based on
  it, a continuous space one and a discrete space one. In the former case, we introduce
  time-reversed diffusions and take good care in deriving why exactly its equations are the way they
  are, in the modern language of probability laws and Schwarz distributions. In the latter case, we
  look at how sampling is done by observing the rate of a Poisson point processes, and extend this
  (known) algorithm in a couple directions.

  #heading(numbering: none)[Own work declaration]
  This thesis is written entirely by me,
  Alexander Gudev. All used literature is cited in place. Wherever a large language model has been
  used in developing ideas, its output has been thoroughly thought over and has been rewritten
  manually from scratch in this text.
]

#page(columns: 1, margin: (x: 20%))[
  // the outline adds a numbered 'Contents' heading which bumps the counter for later headings, so
  // we turn that off here.
  #show heading: set heading(numbering: none) 

  #outline(depth: 2)
  Contains #total-words words.
]

= Introduction and background
#include("src/The sampling problem.typ")
#include("src/Bayes philosophy.typ")
#include("src/Unstarted processes.typ")
#include("src/Stochastic Localisation.typ")

= Stochastic localisation with time-reversed diffusions
Before we even attempt to reverse time, we need to understand how it flows forward.
#include("src/Time-derivative of density.typ")
#include("src/Bra-Ket notation.typ")
#include("src/The general Fokker-Planck equations.typ")
#include("src/The grad log correction term.typ")

// Poisson chapter
#include("src/Poisson point process.typ")

#bibliography("src/references.yaml",
 style: "apa"
  // style: "src/lib/reference-style.csl"
)
