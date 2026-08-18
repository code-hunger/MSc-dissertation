#import "lib/thm-blocks.typ": *
#import "symbols.typ": *

= Unstarted Markov processes

It is said that to move forward, one should first know their roots. In this first chapter, we will
do exactly the opposite, and delete the past all up to the present. This thesis is all about going
back.

#meta-prop[
We will live in a measurable space $(Omega, calF)$, see the world on a Borel screen $D subset.eq
RR^N $ and our clocks will tick with values in a set $I subset [0, infinity)$ (so $I$ or $D$ can be
discrete as well, e.g. $I = NN$ or $D=NN$).

Additionally, our luck will be controlled by a probability measure $PP:calF -> [0,1]$.
]

But even before having a probability measure, we can have a

#definition[A *stochastic process* is an $I$-indexed sequence of random
variables with values in $D$, i.e. a map $X : I times Omega -> D $ where $X(t, dot)$ is measurable
at each fixed time $t in I$.
]

A stochastic process defines what _can_ happen. The law of $X_t$ denoted by $PP_Xt$ then defines what is _likely_ to happen.

This setup already fixes a starting position --- the random variable $X_0$ with its law $PP_(X_0)$.
As we will want to forget that, we focus our attention to processes with erasable past: 

#definition[A _Markov chain_ is a stochastic process $X$ satisfying the simple Markov property:
$ PP(X_(t_(k+1)) in A given X_(t_1) in A_1, ..., X_(t_k) in A_k) 
\ #h(3em) = PP(X_(t_(k+1)) in A given X_(t_k) in A_k). $
for all times $t_1 < ... < t_(k+1) in I$ and Borel $A,A_1,dots,A_k subset.eq D$.
]

The philosophy being that knowing the past of $X$ (at points $t_1...t_k$) does not reveal any more
information about the future of $X$, at any $t_(k+1)$, than its present at $t_k$.

In a sense, this is a _negative_ definition: it tells how to filter out Markov processes from
general processes. For our purposes, though, we need a _positive_ definition, which tells what
Markov chains _are_, not what they are not.

A Markov process induces#footnote[We define it properly later.] what is called a _kernel_ #footnote[Called a _transition matrix_ if $D$ is discrete, $I=NN$ and $t=s+1$.]
$ "for any" s<=t in I, 
quad #box(baseline: -30%,
    $ P_(s,t) : D times calB &-> [0,1] \
      P_(s,t) (x, A) &:= PP(X_t in A | X_s = x), $) $
but a kernel on its own does not determine a stochastic process, not at least until a _starting
point_ (or distribution) is specified --- different processes started at different points may share
the same kernel (dynamics). In discrete time and space, it is known that a transition matrix with a
choice of a starting point induces a Markov chain.

The kernels $PP(X_t in A given X_s = x)$ describe $X$'s evolution when started from almost any
possible point $x in D$. In that way, they gather $X$'s present state + future behaviour, without
any reference to the past.

Conceptually then we can decompose a Markov process $pr(X,t)$ into two orthogonal pieces:
#align(center, grid(columns: 5, align: horizon, column-gutter: 5pt,
[A Markov\ chain $pr(X,t)$],
$=$,
[an initial\ condition $X_0$],
$plus.o$,
[all its Markov\ kernels, $P_(s,t)$.]
))

Whether such a decomposition formally holds for general Markov chains is out of our scope, and
instead we focus on Ito processes.

#heading(level: 2, numbering: none)[Unstarted Ito processes]
#meta-prop[
  Let time run smoothly $I=RR_(>=0)$ now and let a Wiener process $pr(W,t)$ land on our probability
  space. 

  Pick also functions $b,sigma: I times D -> D$ satisfying the usual linear growth and local
  Lipschitz conditions to guarantee existence of solutions to SDEs.
]

An *Ito process* is a solution of a stochastic differential equation of the form 
$ d X_t &= b(t,X_t) d t + sigma(t, X_t) d W_t
  \ X_0 &= x_0, $
which is defined to mean that the following equality holds:
$ X_t = x_0 + integral_0^t b(s,X_s)ds + integral_0^t sigma(s,Xs)dWs. $

While the equation $d Xt=b dt + sigma dWt$ plus the starting point $x_0$ are what determine the
solution, and we are used to saying that the expression $d X_t = b(t,X) d t + sigma(t,X) d W_t$ is
meaningless on its own, it is useful to treat the two as conceptually standalone pieces of the
definition --- akin to how the Markov kernels are standalone objects paired with each Markov chain.

After all, the same $b, sigma$ induce different solutions for different starting points $x_0$. So
what does a standalone expression $ d Xt= b(t,X_t) dt + sigma(t,Xt)dWt $ mean? It is a map 
$ x |-> "a solution" pr(X^((x)),t) "to the SDE started at" x. $

#let X0 = $X^((x_0))$
#let X0t = $X0_t$
#let X0s = $X0_s$
Now, each solution $X0$ on its own induces Markov kernels 
$ x_0 |-> P^((x_0))_(s,t) (x,A) = PP(X0_t in A given X0_s = x), $
which we expect (but do not prove here) to actually _not depend_ on $x_0$ (as long as $s > 0$),
because the $|X0s=x)$ condition already contains as much information as previous history does about
the future: essentially it _restarts_ the process.

The point is, we can think of the laws of an Ito process in the Markov context as an independent
pair of an initial condition and all its kernels. The latter is what we have in mind by the
adjective "Unstarted" in this section's title.
