#import "symbols.typ": *
#import "lib/thm-blocks.typ": *

== Stochastic localisation

#meta-prop[
  Pick a probability space $(Omega, PP)$, a subset $D subset RR^N$ and a probability distribution $mu : calB (D) -> [0,1]$.

  Let $x$ be a random variable whose distribution $mu$ we will want to sample, i.e. let $ x : Omega -> D $ be such that#footnote[For a $D$-valued random variable $x$ and a measure $mu : calB (D) -> [0, infinity]$, the notation $x ~ mu$ is the statement that $x$ is distributed as $mu$, i.e. that for all $A in calB(D)$ we have $PP(x in A) = mu(A)$.] $x ~ mu$.
]

The only thing about $x$ we care is its distribution. Think of $x$ as _the_ sample that we want our
algorithm to produce. In the literature $x$ is called a latent variable because we assume that we
can't directly _measure_ it but instead infer it from other variables.

The stochastic localisation approach to sampling consists of approximating the target distribution
$mu$ (from which a priori we do not know how to sample), with a sequence of ("corrupt")
distributions $pr(mu,t)$, each of which _can_ be algorithmically sampled from.

Here we will look at two characterizations, as given by @Andrea, but it's worth noting that these
are not the only ones: @PerspectivesOnStL provides an insightful overview of perspectives of this
framework.

We begin with the more hands-on one of the two.

=== Def. 1: Observation processes 
The idea is to "reach" $x$ by a sequence of random variables $pr(Y,t)$ that clear out some type of noise.

#definition[
  An *observation process* of $x$ is a sequence of $RR^N$-valued random variables $(Y_t: t in RR_+)$ such that
  + any finite sequence of the form $ x,Y_t_n,...,Y_t_1 $ forms a Markov chain, for all $t_1 < dots.c < t_n$;
  + all the $Y_t$ together determine $x$ in the sense that for any Borel $A subset.eq RR^N$, the
    following conditional probability takes only the values 0 and 1: $ PP(x in A given {Yt:t>=0}) in
    {0,1}. $
  The *stochastic localisation* of $x$'s distribution then is defined as the sequence of conditional laws 
  $ mu_t (A) := PP(x in A | {Y_s:s<=t}). $
]

$Y_t$ is what reveals more information about $x$ as time progresses, where the information being
revealed is encoded in the conditional laws $mu_t$. We will discuss this type of objects in more
detail in @bra-ket-section, but first we also give the second characterization of a stochastic
localisation.

=== Def. 2: Measure martingales

It directly describes the relationship between all $mu_t$ and $mu$, and as usually stated may appear
to be very abstract because it uses the term _random measure_. 

#heading(level: 4, numbering: none)[A word on random measures]
A measure has shape $calB -> [0,infinity]$ for some $sigma$-algebra $calB$ on some
set#footnote[we're suggestively using the symbol $calB$ for the $sigma$-algebra as we're only
interested in random measures on Borel subsets of $RR^N$.] $D subset.eq RR^N$,
and _random_ means having an $Omega$ dependence, so a _random measure_ is an object of shape
$ Omega -> (calB -> [0,infinity]). $
Thus it may appear that a random measure is a kind of higher-order probability, as there are two
randomness sources here --- $Omega$ and $calB$. 
By abstract nonsense (uncurrying) a random measure is naturally equivalent to a two-argument function,
$ Omega times calB -> [0,infinity] $

As discussed in @bayes-for-random-variables, though, this is precisely the shape of Markov kernels
(conditional laws) on $Omega$. The reason we'll look at the Markov kernels as random measures
instead is that the process they form turns out to be a martingale. One should keep in mind that we
still have just one source of randomness, $Omega$, and the $(calB->[0,infinity])$ are just
projections of the presupposed probability $PP$ on $D$.

#definition[
  Pick a random variable $x$ with values in $RR^N$ and law $mu$.

  A *stochastic localisation* on $Omega$ of $mu$ is a measure-valued martingale that converges to
  $delta_x$, i.e. a sequence $pr(mu,t)$ of objects of shape $ mu_t : Omega times calB(RR^N) -> RR $
  such that the martingale property $ EE[mu_t | calF_s] = mu_s$ holds (as an equality of measures, for all times $s<=t$) and $mu_t -> delta_x$ (again as measures, i.e. weakly).
]

The two conditions imposed are to be understood weakly, i.e.:
- The "martingale property as measures" means that fixing the last argument in $ mu : RR_(>=0) times Omega times
     calB(RR^N) -> RR $ makes for a martingale in the classical sense;
- The convergence of the conditional laws $mu_t$ to the unconditional law $mu$ is expressed by first
  lifting $mu$ to the conditional law $delta_x$. The weak limit just means fixing both
  arguments $Omega$ and $calB(RR^N)$ and then taking classical limits.

  
=== Equivalence between def. 1 and 2
The equivalence of the two definitions#footnote[under the assumption that the $sigma$-algebra that $Omega$ is endowed with is countably generated, which will allow the measures $mu_t$ to be "converted" to random variables $Y_t$] is shown in @Andrea, but it suffices to say that the two
properties in each correspond to each other:
- the Markov observation process $Y_t$ corresponds to the measure-valued martingale $pr(mu,t)$ via
  $mu_t = PP(x|{Y_t:t>=0})$;
- the second property in the first definition corresponds to $mu_t$ having $delta_x$ as a limit.

We will investigate the language used here in more detail in the next few sections, but we first
outline how stochastic localisation is used in sampling.

== Two ways to sample with Localisation
=== Diffusion time-reversal
Diffusion based sampling is the approach of time-reversal of a diffusion process.

Let $x ~ mu$ and let $W$ be a Wiener process independent from $x$. The typical process used here is
the only stationary Gaussian process: the Ornstein-Uhlenbeck process
$ d Z_t &= -Z_t d t + sqrt(2) d W_t\
  Z_0 &= x. $

#let calN01 = $cal(N)(0,1)$
#let integral0t = $integral_0^t$

From $e^(-t) d e^t Z_t = d Z + Z d t$ the solution is obtained
$ Z_t &= e^(-t) x + sqrt(2) e^(-t) integral0t e^s dif W_t \
      &= e^(-t) x + sqrt(1 - e^(-2t)) med G_t ,
      quad
      (x, G_t) &~ mu times.o calN01 $

where we rescaled the stochastic integral#footnote[i.e. we put the random variable $ G_t := (1\/2 (e^(2 t) - 1))^(-1\/2) integral0t e^s dif W_s.$] to get a unit normal#footnote[$integral0t e^s dif W_s$ is normal of variance $V = integral0t e^(2s) dif s = 1/2 (e^(2t)-1)$, thus $G_t := V^(-1\/2) integral0t e^s dif W_s$ is normal of variance 1.] $G_t ~ calN01$.

The explicit form of the solution shows that $Z$ begins as an $x=Z_0$ and then transforms exponentially
fast into a normal variable $G_t$. Hence if we can construct the backward process of $Z_t$, we
can recover $x$ by starting with a unit normal variable at $t=infinity$. It turns out that $Z_t$'s
reverse process _is_ in fact a diffusion process again.

In practice then a sample $x$ is obtained by running the reverse of $Z_t$ over $[0,T]$ for a fixed
$T$. As much as we'd want to, we cannot completely prove reversibility of diffusions here; instead
we prove the form of the reverse process by deriving the "equations of motion" of the laws of a
diffusion process - the Fokker-Planck equations in weak form.

A high-level overview of this technique is again in @Andrea where the reverse equation is written
directly: the time-reversed Ornstein-Uhlenbeck turns out to be a time-rescaled version of $t x +
W_t$, which is an observation process and so its laws induce a stochastic localisation.
As a byproduct of the derivations we will present here, though, we also see the connection to a closely
related approach to sampling via Langevin dynamics.

=== Sampling in time by a Poisson process
The second application of stochastic localisation to sampling that is of interest to us is based on
a Poisson point process. A very brief overview is again in @Andrea, sec. 4.8.

The reason we find this one curious is that it builds a sample of a _real_ random variable from a
Markov chain of _discrete_ state space. The _reality_ of the sample is encoded in time, not in
space.

The idea is to encode the sample value in the frequency of a Poisson point process. More
specifically, take a non-negative real random variable $x$ and a process $pr(Y,t)$ that
conditionally on $x$ is Poisson point process $ (Y | x) ~ "PPP"(x). $

In CHAPTER-PPP we derive how $Y$ can be run in practice, prove convergence to $x$ and develop the
sampling scheme further with a couple generalizations. Let us quickly explain here _why_ a Poisson
point process makes sense at all as a base for sampling (if it can be run as an algorithm).

Recall that a Poisson point process $pr(X,t)$ of parameter $lambda in RR$ is defined to model _ticks_ (points)
in time that on average occur $lambda$ times per unit time. As time $t$ progresses to infinity, the
total number of occurrences, $X_t$, is expected to be $lambda thin t$. Loosely speaking, $ lambda = lim_t X_t\/t$.

Now, at (almost) each random outcome $omega in Omega$, the target sample has value $x(omega)$. So if
we have a point process (with counting variable) $pr(X,t)$ of rate $x(omega)$, we can expect to recover the
rate $x(omega)$ from $lim X_t (omega)\/t$.

Of course, at individual outcomes $omega in Omega$ in isolation we cannot talk about $(X_t (omega))_t$ having rate
$x(omega)$.
The way to define a point process of such a random rate is by _mixing_ otherwise defined point
processes: take for each $lambda in RR$ a (different) process $X^((lambda)) ~ "PPP"(lambda)$, then a
process $X$ is defined to be a process of random rate $x$ if #eq($ PP(X in A) = integral PP(X^((lambda)) in A) dif PP(x=lambda), $)<poisson-mix>
i.e. if the law of $X$ is a convex combination of the laws of all $X^((lambda))$ and the $lambda$
are taken from the distribution of $x$; in more classical notation the integral is written $integral PP(X^((x)) in A) d mu_x$ with $mu$ being the law of $x$.
