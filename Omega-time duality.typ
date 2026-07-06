= Separating the Dynamics from the initialisation of a stochastic process

Fix a domain for stochastic processes $D subset RR^N $ and a time index set $I subset [0, infinity)$
(so $I$ can be discrete as well, $I = NN$).

#let calF = $cal(F)$
On a measurable space $( Omega, calF )$ a *stochastic process* is an $I$-indexed sequence of random variables with values in $D$, i.e. a map $X : I times Omega -> D $ where $X(t, dot)$ is measurable at each fixed time $t in I$.

This setup already fixes a starting position --- the random variable $X_0$ with its law $PP_(X_0)$.
So there are two aspects to this definition that we need to separate conceptually.

Recall that a Markov chain is a stochastic process $X$ satisfying the simple Markov property 
$ forall t_1 < ... < t_(k+1) in I: quad PP_(X_(t_k+1) | X_(t_1), ..., X_(t_k)) = PP_(X_(t_k+1) | X_(t_k)). $

A Markov process induces a kernel (_transition matrix_ if $D$ is discrete) 
$ "for any" t in I, quad #box(baseline: 50%, align(left, $P_t : D times calF -> [0,1] \
  P_t (x, A) := P(X_t in A | X_0 = x),$)) $
but a kernel on its own does not determine a stochastic process, not at least until a _starting
point_ (or distribution) is specified --- different processes started at different points can share
the same kernel (dynamics). In discrete time and space, it is known that a transition matrix with a
choice of a starting point induces a Markov chain.

A stochastic differential equation of the form $d X_t = b(t,X) d t + sigma(t, X) d  w_t, X_0 = x_0$
may be solved by a stochastic process.
While the equation + the starting point are what determine the solution, and we are used to saying
that the expression $d X_t = b(t,X) d t + sigma(t,X) d W_t$ is meaningless on its own, it is useful
to treat the two as conceptually standalone pieces of the definition --- akin to how the Markov
kernel is a standalone object paired with each Markov chain. After all, the same $b, sigma$ induce
different solutions for different starting points $x_0$. 

= Markov chain action on the space of distributions

