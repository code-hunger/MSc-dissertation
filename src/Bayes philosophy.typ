#import "lib/colour.typ": colour

== Priors, posteriors and Empirical Bayes

We will use a few terms from statistics throughout this article of which we provide a quick overview
in this section.

#let dom = $op("dom")$
A probability space $(Omega, PP)$ is assumed, i.e. a set $Omega$ and a measure $PP : dom(PP) -> [0,1]$ satisfying $PP(Omega) = 1$.  
We leave $dom(PP)$, the domain of $PP$, unnamed, and we call its elements _events_. 
That is, an _event_ is a subset $A subset.eq Omega$ which is also an element of $dom(PP)$.

=== For events

//#let OOmega = $#stack(spacing: .5pt, (scale(y: 80%, $Omega$)), place(line(end: (-2pt, -2pt)) , line(length: 1em)))$
Imagine two events $Alpha, Lambda subset.eq Omega$, where $Lambda$ is mysterious and $Alpha$ is observable, by which we mean that 
- we (potentially) *do not know* the probability of $Lambda$ (hence mysterious), but
- we *do know* the conditional probability of $A$ given $Lambda$, $PP(Alpha|Lambda)$. 
  That is, we know the dependence of $Alpha$ on $Lambda$.

Now let us observe $Alpha$ (or its complement).
We would be interested in $PP(Lambda|Alpha)$, that is, what do we learn about the mystery from the observable?

The Bayes formula relates $PP(Lambda|Alpha)$ to $PP(Alpha|Lambda)$, but it requires knowledge of
$PP(Lambda)$: 
#import "@preview/intextual:0.1.1": intertext-rule, intertext, centertext, flushr
#[
#show: intertext-rule
$ #flushr[(Bayes)] PP(Lambda|Alpha) = PP(Lambda)/PP(Alpha) dot PP(Alpha|Lambda). $
]

Thus _in the context of information being revealed_, the terms *prior* and *posterior* are
introduced:
#align(center, grid(
  columns: 2,
  // column-gutter: 2em, 
  inset: (x: 1em),
  [*prior*\ $PP(Lambda)$\ the knowledge of $Lambda$\ _before_ we look at the $Alpha$.],
  grid.vline(stroke: colour.fg3),
  [*posterior*\ $PP(Lambda|Alpha)$\ the knowledge of $Lambda$\ _after_ we've looked at $Alpha$.]
))

=== For random variables
Now we generalize from events $Alpha,Lambda subset.eq Omega$ to random variables $Y, lambda : Omega -> RR$.
As above, we consider a context where
- we may *not know* the law $PP_lambda$ of $lambda$, but
- we *do know* the law $PP_(Y|lambda)$ of $Y$ given any value of $lambda$.

#let not-exactly-markov-kernel = footnote[well, not _exactly_. An additional property is required that for all
measurable $A$ within the range of $Y$, the map $lambda |-> PP(Y in A|lambda)$ is a measurable. We
take the liberty of calling it _technical_ and omit it from the main storyline.]

#let calB = $cal(B)$

#let markov-conceptually = footnote[Technically we cannot write the conditional law that way because
$PP(A|B)$ is defined only for conditions $B$ of non-zero probability, so that the definition
$PP(A|B)=P(A B)\/P(B)$ makes sense. If $lambda$ takes values in $RR$, $(lambda = a)$ may very well
be an event of zero probability.]

Mathematically, at any realization of $lambda$, $PP_(Y|lambda)$ is a distribution on the values of
$Y$., i.e. $PP_(Y|lambda)$ is a $lambda$-indexed family of probability measures.
But this is exactly#not-exactly-markov-kernel the definition of a Markov kernel. Symbolically, a
Markov kernel is
an object of shape 
$ PP_(Y|lambda) : calB times RR -> [0,1] $
that, conceptually speaking#markov-conceptually, functions like a map $ (A, a) &|-> PP(Y in A | lambda = a). $

We observe $Y$ and want to make conclusions about $lambda$.

=== Empirical Bayesian philosophy
Later we will define processes which allow us to learn about a $lambda$atent variable $lambda$. 

Under the Bayesian philosophy, the law of $lambda$ is stipulated to be known, and then $PP(lambda |
A)$ is evaluated from Bayes' formula. 

The stochastic localisation approach to sampling, though, will
not rely on knowledge of the latent variable's distribution $PP_lambda$, and so will instead employ
the Empirical Bayes philosophy, under which $PP_lambda$ is gradually estimated from observations as
they come in.

(TODO: ADD LINKS TO ROBBINS' TALKS)
