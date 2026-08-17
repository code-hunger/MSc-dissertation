#import "lib/references.typ": myref
#import "@preview/intextual:0.1.1": intertext-rule, intertext, centertext, flushr, flushl
#import "lib/wide.typ": a4, grid-columns-count, grid-vline-if-wide
#import "lib/thm-blocks.typ": *

#import "@preview/cetz:0.5.2"

#let eq = math.equation.with(numbering: "(1)", block: true)
#let eqB = math.equation.with(numbering: "(1)", block: true, number-align: bottom)
#let eref(r) = $(#ref(supplement: none, r))$

#let langle = sym.chevron.l
#let rangle = sym.chevron.r
#let ranglee = (math.mid(sym.chevron.r.double))
#let ranglee = math.op(math.mid(sym.chevron.r.double))
#let ranglee = math.mid(math.op(sym.chevron.r.double))
#let given = math.mid(sym.bar.v)
#let calB = $cal(B)$
#let ket(c) = box(math.lr($|#c rangle$)) // call `lr` to enlarge the surrounding brackets in |X> if needed
#let PPP(c) = $PP#ket(c)$
#let PPPy(c) = $PP_Y#ket(c)$
#let dPPP(c) = $dif PPP(#c)$ // call `lr` to enlarge the surrounding brackets in |X> if needed
#let derivation-end-here = flushr(math.square)

#let Yt = $Y_t$
#let Yte = $Y_(t+epsilon)$
#let ate0 = $|_(epsilon=0)$
#let partial-epsilon() = $partial_epsilon$

#show: intertext-rule

#let Walter-seminar = myref("Walter")
#let Zaragoza = myref("Garcia-Palacios")

= The Fokker-Planck equation

#let pr(x,i) = $#box($(#x _#i)$)_#i$

#let cond = footnote[usually for an interval $I subset.eq RR_(>=0)$ and a Borel $D subset.eq RR^N$]
#meta-prop[
While we define#cond a $D$-valued stochastic process $pr(Y,t)$ on a probability space $(Omega, PP)$
as a map of shape $Y : I times Omega -> D$ measurable in the $Omega$ argument, what is _relevant_
are all its laws $PPP(Y_t), t>=0$, as well as all its joint laws 

$ "for all" n "and" t_1, dots, t_n, 
  quad
  PPP(Y_t_1\, dots\, Y_t_n) : cal(B)(D^n) -> [0,1]. $

So from the perspective of time flowing, what is relevant is not so much the sequence $pr(Y,t)$ of
the _variables_, but rather the sequence $PPP(Y_t)_(t>=0)$ of their _laws_.

If $Y$ admits probability densities $ p(t,x) = dif PPP(Y_t)\/d x,$
it is natural to consider the sequence of densities $pr(p(t,dot), t)$ and ask if their evolution is
driven by a partial differential equation 
$ (partial p(t,x))/(partial t) = F[t, x, p,partial_x p, partial_(x x) p, ...], "for some" F, $
and in particular, *what is that $F$?*
In this section, we answer that question positively for Ito diffusions.

#let pr(x,i) = $#box($(#x _#i)$)_#i$
]

In @generalized-time-derivative we explained that the proper object to study the distributional
evolution of an Ito stochastic process is not $PPP(Y_t)$ but $PPP(Y_t given Y_0)$, we present one
approach to deriving the Fokker-Planck equation.

We will derive it by Tailor-expansion of the transition densities, following the general approach in
#Walter-seminar or the referenced inside #Zaragoza, sec. 4 and 5. However, we completely rework it
in the language of measures and Markov kernels so that the probability distributions are not assumed
to admit densities (against the Lebesgue measure, as done in these resources). This is why we will
arrive at a PDE of distributions (weak form) and not of ordinary functions. Only after will we
specialize to density-admitting processes (strong form).

== Weak form

#figure(placement: if a4 {bottom} else { auto }, abstr-nons[
In this block we generalize the relation $ PP[B] = EE[1_B], quad "for every event" B, $ from events $B$
to random variables $X$.

On events
regarding random variables, $B = (X in A)$, the equivalence reads 
#eq($ PP(X in A) = EE[1_(X in A)]. $)<E-P-equivalence-on-X-A>

Below we are interested in using that equality over all Borel $A$, in which case the left hand side
can be seen as the law $PPP(X)$ evaluated at $A$. Let us write the right side's dependence on $A$ as
a measure, too. 

First, realize that the randomness in the expectand in #eref(<E-P-equivalence-on-X-A>) is only
through $X$, so we should be able to write $1_(X in A) (omega)$ as a function of $X(omega)$. 
Indeed, $1_(X in A) = 1_A (X)$. 

Now recall that the characteristic function ($1_A (x)$) is the Dirac-delta function with flipped arguments: for
all Borel $A$ and all $y in RR$,
$ 1_A (y) = delta_y (A).$
Evaluating that at $y:=X$,
$ 1_A (X) = delta_X (A),$
we get #eq($ 1_(X in A) = 1_A (X) = delta_X (A) $)<1-is-delta>
and so 

$ forall med"Borel" A: quad PP(X in A) =^#eref(<E-P-equivalence-on-X-A>) EE[1_(X in A)] =^#eref(<1-is-delta>) EE[delta_X (A)], $
which in point-free style reads 
#eq($ PPP(X) = EE[delta_X] $)<P-E-equivalence-on-X>
as an equality of measures.
])

We will derive the Fokker-Planck equations by a Taylor expansion of the evolution of $PPP(Y_t)$. 

#meta-prop[
  Fix a diffusion $ d Y_t &= b(t,Y_t) d t + sigma(t, Y_t) d W_t\ Y_0 &= y_0 $
  with $b,sigma$ satisfying the relevant linear growth and local Lipschitz conditions so that a
  solution exists.
]
#derivation(suffix:none)[
We first rewrite 
#eq($ PPP(Yte given Y_t) =^#eref(<P-E-equivalence-on-X>) EE [ delta_Yte given Y_t ].
$)<Yte-P-E-equiv>

#figure(placement: if a4 { bottom } else { auto }, abstr-nons[
Since the main operation we want to perform --- take time-derivatives --- is not generally available
for measures, we turn our measures into distributions in Schwarz sense. We indicate the Schwarz
distribution corresponding to a probability law by dropping the probability sign, i.e. for each
random variable $X$ we define a distribution $|X rangle$ via $PPP(X)$ simply by
$ forall phi in C_0^infinity: quad langle phi given X rangle = integral phi(x) dPPP(X=x). $

Similarly, if $PPP(X given Y)$ is a Markov kernel for two random variables $X$ and $Y$, the induced
conditional distribution is defined as the family of distributions indexed by the range of $Y$
defined by
$ langle phi | X | Y = y rangle = integral phi(x) dPPP(X=x|Y=y), $
again for all test functions $phi in C_0^infinity$ with domain the range of $X$.
])

#let DeltaY = $Delta Y_t$
Now we Taylor-expand the expectand in weak sense
$ forall y'=y+Delta: quad delta_y' &= delta_(y + Delta)
          \ &= sum_k delta^((k))_y Delta^k/(k!)
          \ &= delta_y + delta'_y Delta + delta''_y (Delta^2)/2 + dots.c
$
which evaluated at $y=Y_t$ and $y' = Yte$ and substituted into @Yte-P-E-equiv yields#footnote[by $EE[delta^((k))_Yt given Y_t]=delta^((k))_Yt$ for all $k$.]
#eq($ ket(Yte | Y_t) = delta_Y_t 
  &+ delta'_Y_t EE[DeltaY given Y_t] 
\ &+ 1/2 delta''_Y_t EE[DeltaY^2 given Y_t] + dots.c $)<kram-expansion>

#let lime = $lim_(epsilon->0)$
Denote the coefficients behind the derivatives of $delta_Yt$ by 
$ a^((k))_t (y) = lime 1/epsilon EE[(Yte-Yt)^k given Y_t=y] $
(as almost-everywhere defined functions on $RR$, for each $k in NN$ and $t>=0$).

Glossing over details, we evaluate the coefficients to be
$ a^((1))_t &= lime 1/epsilon EE[Y_(t+epsilon)-Y_t given Y_t]
          \ &= lime 1/epsilon EE[integral_t^(t+epsilon) b d s + integral_t^(t+epsilon) sigma d W_s given Y_t ]
\ ("since" &inline(EE[integral sigma d W_s]=0 "and" 1/epsilon integral_t^(t+epsilon) b d s -> b(t)) )
          \ &= b(Y_t, t)
$
and 
$ a^((2))_t &= lime 1/epsilon EE[(Y_(t+epsilon)-Y_t)^2 given Y_t]
\ ("since" &inline((integral b d s)^2 = o(epsilon^2) "and" ()))
          \ &= lime 1/epsilon EE[inline((integral_t^(t+epsilon) sigma(s,Y_s) d W_s))^2 given Y_t]
          \ & quad quad ("Ito isometry")
          \ &= lime 1/epsilon EE[integral_t^(t+epsilon) sigma^2 (s,Y_s) d s given Y_t]
          \ &= sigma^2 (t, Y_t),
$
while higher-order coefficients $a_t^((k)), k>2$ consist of limits of expectations of linear
combinations of terms 
$ 1/epsilon (integral_t^(t+epsilon) b(t,Y_t) d s)^(k-i) (integral_t^(t+epsilon) sigma(t,Y_t) d W_s)^i
\ = 1/epsilon o(epsilon^(k-i) epsilon^(i\/2)) $
which all vanish.

Then @kram-expansion with $partial_epsilon#ate0$ applied reads $ #partial-epsilon()ket(Yte | Y_t) #ate0 = b(t,Y_t) delta'_Y_t + 1/2 sigma^2 (t,Y_t) delta''_Yt, $
or, introducing explicit variable for $Yt=y$,
$ #partial-epsilon()ket(t+epsilon given t:y) #ate0 = b(t,y) delta'_y + 1/2 sigma^2 (t,y) delta''_y, $
to signify that this is an equality of distributions parametrized by $y$ for almost every $y in RR$,
i.e. an equality of objects of shape $ RR ->_("a.e.") (C_0^infinity -> RR).$

Now we will integrate the free-hanging $y$ against $PPP(Y_t)=PPPy(t\:y)$, which on the left side turns
$ PPPy(t+epsilon|t:y ranglee t:y) = PPPy(t+epsilon) $ and so we're left with an equation of distributions
$ #partial-epsilon()ket(t+epsilon)#ate0 
  &= ket(b(t,y) delta'_y + inline(1/2) sigma^2 (t,y) delta''_y ranglee t\:y). 
\ &= ket(b(t,y) delta'_y ranglee t\:y)\ & #h(2em) + 1/2 ket(sigma^2 (t,y) delta''_y ranglee t\:y).
$
#let distributional-terms = footnote[For any $phi in C_0^infinity$, 
$ langle phi given b(t,y) delta'_y ranglee t:y rangle 
  &= langle b(t,y) phi given delta'_y ranglee t:y rangle 
\ &= - langle b(t,y) dot(phi) given t:y rangle 
\ &= langle dot(phi) given -b(t,y) given t:y rangle 
\ &= langle phi given partial given -b(t,y) given t:y rangle 
$]
As distributions, 
      $ ket(b(t,y) delta'_y  ranglee t:y) &= -partial_y   thin [       b(t,y)ket(t\:y) ]
\ ket(sigma^2(t,y) delta''_y ranglee t:y) &=  partial_y^2 thin [ sigma^2(t,y)ket(t\:y) ], $
which can be easily derived by acting on test functions#distributional-terms. The right hand sides here are the
distributional derivatives of the products of $b$ and $sigma^2$ with the distribution of $Y_t$,
$ket(t\:y)$.

And so we derived the Fokker-Planck equation:
$ #partial-epsilon()ket(t+epsilon)#ate0 
    = -partial [&b(t,y)ket(t\:y)] 
    \
    #derivation-end-here + &1/2 partial^2 [sigma^2(t,y)ket(t\:y)] $
]

We can spell the result in a less clumsy way if we leave the bound variable $y$ implicit. For
that we need to write the drift and the diffusion coefficients with the time argument as an index:
$b_t (y), sigma_t (y)$ instead of $b(t,y),sigma(t,y)$.

#conclusion[
  Let $pr(Y,t)$ be the solution of the SDE $ d Y_t &= b_t (Yt) d t + sigma_t (Yt) d W_t\ Y_0 &= y_0 $
  where $b_t (y), sigma_t (y)$ satisfy the linear growth and local Lipschitz conditions.

  Then its laws $PPP(Y_t)$ satisfy the Fokker-Planck equation:
  #eq($ #partial-epsilon()ket(Yte)#ate0 
    = -partial [&b_t#ket($Yt$)] + 1/2 partial^2 [sigma_t^2ket(Yt)]. $)<fokker-plank-eqn>
]

== Strong form

Now we specialize to the case when $pr(Y,t)$ has all densities.

#meta-prop[Let $pr(Y,t)$ be the solution of the SDE as above, and additionally assume that 
its laws admit densities against the Lebesgue measure, i.e.
$ forall t>=0: quad dPPP(Yt) = p_t (y) d y $
]

Susbstitute $ket(Yt)=p_t (y) d y$ in @fokker-plank-eqn
to get
$ #partial-epsilon()p_(t+epsilon) (y) d y#ate0 
    = -partial [&b_t p_t d y] + 1/2 partial^2 [sigma_t^2 p_t d y]. $
Now simply read out the classical PDE in fron of $d y$:

#conclusion[The Fokker-Planck equation on the densities $p_t$ of $pr(Y,t)$:
$ partial_t p_t = -partial_y (b_t  p_t)(y) + 1/2 partial_y^2 (sigma_t^2 p_t)(y) $
]

/* NO TIME to develop this section now
== By Generators
In infinitesimal form this requires a bit more machinery. We define the infinitesimal generator of
$X$ by $ scr(L)phi = (x |-> lim_(h->0) (P_h phi - phi)/h (x))\ = lr((d P_t)/(d t)|)_(t=0) (phi) $
which tells us by how much a test function $phi$ (thought as a distribution density) is pushed by
$X_t$ in an infinitesimal time. 
For a time-homogeneous $d X_t = b(X_t) d t + sigma(X_t) d W_t$ this is#footnote[using Einstein summation] 
$ scr(L) = b^i partial_i + 1/2 a^(i j)  partial_i partial_j, quad a:=sigma sigma^top. $

Then $u(t,x) := (P_t phi)(x)$ satisfies $partial_t u = scr(L)u$

Next we define the adjoint $scr(L)^*$ and forward Kolmogorov is 
$ partial_t p_t (x,y) = scr(L)^+_y p_t (x,y)
\ scr(L)^+ phi = 1/2 partial_i partial_j a^(i j) phi - partial_i b^i dot phi $
where $p_t (x,y)$ is transition density from $x$ to
$y$ in time $t$ (for time-homogeneous systems it doesn't matter at which time $t_0$ we start, only the
time difference $t$).

Then if $ rho(x) = (d PP_(X_0)) / (d x) (x),\ rho(t,y) := integral p_t (x,y)rho(x) dif x, $
Fokker-Planck is $ partial_t rho(t,y) = scr(L)^+_y rho(t,y). $
*/

=== Chapman-Kolmogorov

#meta-prop[A real-valued Markov process $pr(Y,t)$.]

For two time points $t_1 <= t_2$ and an $epsilon>0$,
the Chapman-Kolmogorov equation for the process $Y$ states that the probability flux between times $t_1$
and $t_2 + epsilon$ goes through all possible values at the midtime $t_2$:

$ PP|Y_(t_2 + epsilon) given Y_(t_1) rangle = PP|Y_(t_2 + epsilon) given Y_(t_2) ranglee Y_(t_2) given Y_(t_1) rangle. $

Now we are interested to derive the time-evolution of the left-hand side, and so we need only two
time points. Fix $t>0$ and $epsilon>0$ and plug $t_1 = t_2 = t$ above:
$ PP|Y_(t + epsilon) given Y_t rangle &= PP|Y_(t + epsilon) given Y_t ranglee Y_t given Y_t rangle $
and integrate along $ket(Y_t)$
$ PP|Y_(t + epsilon) rangle &= PP|Y_(t + epsilon) given Y_t ranglee Y_t rangle, $
or, if we allow ourselves to write the time indices only:
#conclusion[
  For any Markov $pr(Y,t)$ and times $t,t+epsilon$,
  $ PPPy(t + epsilon) = PPPy(t + epsilon given t ranglee t). $
]
