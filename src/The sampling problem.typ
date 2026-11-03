#import "lib/colour.typ": colour
#import "lib/wide.typ": wide
#import "lib/misc.typ": *
#import "symbols.typ": *

#heading-with-quote[The sampling problem][or, _making something out of nothing_]

The _sampling problem_ is generally the problem of producing a sample from a probability
distribution. In this thesis we develop the theory around a couple sampling algorithms based on the
stochastic localization approach.

And if the term "sampling from a probability distribution" sounds boring, let us briefly mention
that this is just mathspeak for "generating [cool stuff]", where [cool stuff] stands for anything
from from images and audio to weather and financial data, i.e. any type of objects that can be
modelled as living in (a subset of) $RR^N$ and the likelihood of each instance thereof occurring is a well-defined
probability distribution.

Depending on what is known, more specific sampling problems can be considered. Our base reference paper,
@Andrea, outlines three such classes: we either "know" the target distribution or not, and if we
"know" it, it might be only up to a parameter.

#let pr(x,i) = $#box($(#x _#i)$)_#i$
#let desc(c, d) = c + block(text(size: 9pt, d), above: 7pt)

#let iperp = box($~^#scale(x: 120%, box($perp$, baseline: 13pt))$, baseline: 25%)

#align(center, grid(
  // Know/not know table
  columns: 3, inset: if wide { .8em } else { (x: .5em, y:.8em) },
  // align: (x, y) => if x > 0 { center + top } else { right },
  align: center + horizon,
  grid.hline(stroke: colour.fg4, y: 1, start: 1),
  grid.hline(stroke: colour.fg1, y: 2),
  grid.hline(stroke: colour.fg3, y: 3),
  grid.hline(stroke: colour.fg3, y: 4),
  grid.vline(stroke: colour.fg3, x: 2, start: 1),

  grid.cell(colspan: 3)[Task: *produce a sample* $x$ from a distribution $mu$ where],

  [],
  grid.cell(colspan: 1, [we know]),
  [but do not know],

  [Case I.],
  desc($mu$, [the distribution]),
  grid.cell(line(start: (0em,1em),end: (4em, 0em),stroke: 0.5pt)), 

  [Case II.],
  desc(
    [$pr(mu,theta)$ and $pr(x,i) iperp mu_theta$/* , for some $theta$ */],
    [a family of distributions\ and a sample i.i.d. sequence]),
    [the parameter $theta$,\ and hence which $mu_theta$\ is the true one], 

    [Case III.],
    desc(
      [$pr(x,i) iperp mu$/* , for some $mu$ */],
      [a sample sequence only]),
      [the distribution $mu$]
))

A sampling algorithm is then packaged in different ways depending on which case we fall in: if $mu$
is known, the algorithm is run directly, otherwise $mu$ has to be estimated first.

Being an object of shape#footnote[$cal(B)(RR^N)$ is the set of measurable subsets of $RR^N$.]
#box($cal(B)(RR^N)->RR$) (so really a point in an infinitely dimensional space), a probability
distribution is hard to be estimated directly. We know, however, how to approximate functions of
shape $RR^N->RR$ via neural networks, and fortunately it will turn out that this is sufficient as a
sampling algorithm won't require to know the full $mu:cal(B)(RR^N) -> RR$.

#heading(level: 2, numbering: none)[Reduction to a Score]

Instead, the sampling algorithms we discuss here will depend on the target distribution $mu$ only through a
real-valued function on (finitely many) real arguments, $m_mu (t,y_1,...,y_n)$, so of shape $ m_mu :
RR^(n+1) -> RR, $ in some contexts called a _score_, that we will define later (#text(fill: red, "where?")).

This means that to implement the algorithm, it suffices get a hold on $m_mu$. This indirectness of
the algorithm's dependence on $mu$ allows us to work even in cases where $mu$ is not known (but
assumed to exist), as then $m_mu$ will be estimated from a dataset, e.g. by means of an
artificial neural network. 

In this article, instead of the standalone problem of constructing a sampling algorithm for a given
distribution $mu$, we consider the reduction

#let squeeze(c) = box(par(c), baseline: horizon)
$ (star) std.math.wide 
#squeeze[an estimator\ of a particular\ function $m_mu$]quad|=>quad#squeeze[a sampling\ algorithm for $mu$\ based on $m_mu$]quad |=>quad x. $

The prototype of such a reduction technique was proposed in @DeepUnsupNonEquilibrium, where the
sampling algorithm runs a Markov chain whose transitions are learned from data. A more particular
instance of this technique, though, comes from using _stochastic localizations_ as sampling algorithms
as described in @Andrea.

Before we close this high-level overview, we stress that in our work we will _assume_ that the
respective estimator job has been done, and will only focus on the sampling algorithm that _uses_
said estimator. 
In terms of $(star)$ the conceptual chain above illustrating the reduction from sampling to
estimation, we only construct the middle link. We will not tackle estimation of $m_mu$ --- this is
a non-trivial task on its own; problems arising there have been explored in practice for example in
@GenModByGradients.
