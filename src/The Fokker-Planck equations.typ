#import "lib/references.typ": myref
#import "lib/colour.typ": colour
#import "@preview/intextual:0.1.1": intertext-rule, intertext, centertext, flushr, flushl
#import "lib/wide.typ": wide, grid-columns-count, grid-vline-if-wide

#import "@preview/cetz:0.5.2"

#let eq = math.equation.with(numbering: "(1)", block: true)
#let eqB = math.equation.with(numbering: "(1)", block: true, number-align: bottom)
#let eref(r) = $(#ref(supplement: none, r))$

#let rangle = sym.chevron.r
#let ranglee = math.op(sym.chevron.r.double)
#let given = math.mid(sym.bar.v)
#let calB = $cal(B)$

#show: intertext-rule

#import "@preview/great-theorems:0.1.2": mathblock, proofblock, great-theorems-init
#show: great-theorems-init

#let meta-prop = mathblock(blocktitle: "Context", stroke: (left: colour.fg3), inset: (left: 1em, y: 5pt))
#let conclusion = mathblock(blocktitle: "Conclusion", inset: (x: 5pt,y: 7pt), fill: colour.bg1, stroke: .5pt + colour.fg3)
#let derivation = proofblock(blocktitle: "Derivation", prefix: [_Derivation_.])
#let derivation-end-here = flushr(math.square)

= The Fokker-Planck equation

#let pr(x,i) = $#box($(#x _#i)$)_#i$

#let cond = footnote[usually for an interval $I subset.eq RR_(>=0)$ and a Borel $D subset.eq RR^N$]
While we define#cond a $D$-valued stochastic process $pr(Y,t)$ on a probability space $(Omega, PP)$
as a map of shape $Y : I times Omega -> D$ measurable in the $Omega$ argument, what is _relevant_
are all its laws $PP_Y_t, t>=0$, as well as all its joint laws 

$ "for all" n "and" t_1, dots, t_n, 
  quad
  PP_((Y_t_1, dots, Y_t_n)) : cal(B)(D^n) -> [0,1]. $

So from the perspective of time flowing, what is relevant is not so much the sequence $pr(Y,t)$ of
the _variables_, but rather the sequence $\(PP_Y_t)_(t>=0)$ of their _laws_.

If $Y$ admits probability densities $ p(t,x) = dif PP_Y_t\/d x,$
it is natural to consider the sequence of densities $pr(p(t,dot), t)$ and ask if their evolution is
driven by a partial differential equation 
$ (partial p(t,x))/(partial t) = F[t, x, p,partial_x p, partial_(x x) p, ...], "for some" F, $
and in particular, *what is that $F$?*
In this section, we answer that question positively for Ito diffusions.

#let Walter-seminar = myref("Walter")
#let Zaragoza = myref("Garcia-Palacios")

== Properly generalizing $partial_t p(t,x)$
We want to construct a differential equation describing the evolution of the laws of $Y_t$. 
Inspired from PDEs on regular functions of the form $partial_t p(t,x) = F[t,x,partial_x,...]$ in
mind, we might be tempted to simply replace the function $p$ by the law $PP_Y_t$ and develop an
equation for $partial_t PP_Y_t$ (if exists). This naïve way leads to inconsistencies that we outline below.

In particular, a well-behaved generalization of $partial_t p(t,x)$ should be stable under changes to
the initial conditions (the law of $Y_0$). We now show that $partial_t PP_Y_t$ is not.

=== The problem with $partial_t PP_Y_t$

#let X1 = $X$
#let X2 = $Y$
#let xi1 = $xi$
#let xi2 = $eta$
#meta-prop[
For two random variables $xi1, xi2$ and a real (rate) $r>0$ construct the processes 
#eq($ X1_t = xi1 + r thin t " and " X2_t = xi2 + r thin t, $)<def-X1-X2>
satisfying the SDEs 
#align(center, block(inset: .5em, stack(dir: ltr, spacing: 1em,
  $d X1_t &= r med d t\ X1_0 &= xi1$,
  box(baseline: 1em)[and],
  $d X2_t &= r med d t\ X2_0 &= xi2$
)))
sharing the same dynamics $d X_t = r thin d t = d Y_t$ but having different initial conditions $xi1, xi2$.
]
So we'd want our generalization of $partial_t p$ to be the same on both processes.

#let at0 = $|_(t=0)$
#let PPP(c) = $PP lr(|#c rangle)$ // call `lr` to enlarge the surrounding brackets in |X> if needed
#let dPPP(c) = $dif PPP(#c)$ // call `lr` to enlarge the surrounding brackets in |X> if needed
#let LawX1t = $PPP(X1_t)$
#let LawX2t = $PPP(X2_t)$
#let Uniform(a,b) = $op("Unif")(#a,#b)$

#derivation(suffix: none)[
Evaluate $partial_t LawX1t#at0$ on $[a, infinity)$ for $a in RR$:

#eqB($ partial_t med PP(X1_t >= a)#at0 &= lim_(epsilon->0) 1/epsilon (PP(X1_epsilon >= a) - PP(X1_0 >= a))
                                \ &=^#eref(<def-X1-X2>) lim_(epsilon->0) 1/epsilon (PP(xi1 + r epsilon >= a) - PP(xi1 >= a))
\ #intertext[(express#footnote[Having the usual notation for events in mind, $(xi>=a) equiv {omega in Omega | xi(omega)>=a}$] $(xi + r epsilon>=a)=(xi>=a) union (a-r epsilon<=xi<a)$)]
                                      &= lim_(epsilon->0) 1/epsilon PP(a - r epsilon <= xi1 < a), $) <partial_t-law-limit>
And similarly for $X2$:
$ partial_t med PP(X2_t in [a, infinity))#at0 &= lim_(epsilon->0) 1/epsilon PP(a - r epsilon <= xi2 < a).  $

It is evident now that the derivative depends directly on the laws of $xi1$ and $xi2$. If the two were
chosen according to, for example, $xi1 ~ Uniform(0,1)$ and $xi2 ~ Uniform(0.5,1)$, and we pick
$a=1$, the limits above would evaluate to
#eq($ partial_t &PP(X1_t& >=1) &=  r,
    \ partial_t &PP(X2_t& >=1) &=  2r,$)<speed-difference>
because in that case
$         &PP(1 - r epsilon <= xi1 < 1) = r epsilon
\ #derivation-end-here " but " &PP(1 - r epsilon <= xi2 < 1) = 2 r epsilon. $
]
That is, 
#conclusion[the time derivative of the laws of $X1_t,X2_t$ is not invariant to change of initial conditions.]

==== Why does $partial_t PPP(Z_t)$ vary?

It turns out we can easily visualize this phenomenon if we consider 
+ the speed at which (the laws of) $X1_t$ and $X2_t$ move through $RR$, and,
+ the speed at which individual sets $A subset.eq RR$ gain or lose weight#footnote[measure] as $t$
  varies, under $LawX1t$ and $LawX2t$,
and realize that $partial_t PPP(X_t)$ measures the latter, while the invariant quantity is the former. 

#figure(
  caption: [The densities of $X$ and $Y$ at times $t=0$ and #box($t=epsilon$). Here again $xi1 ~ Uniform(0,1)$ and $xi2 ~ Uniform(0.5,1)$.],
  placement: auto,
  cetz.canvas(x: 1.5cm, {
  import cetz.draw: line, content, group, floating, translate

  cetz.draw.set-style(stroke: colour.fg0)

  let offset = .3
  let label(x, c) = cetz.draw.content((x,-.8em), c)
  let rect-at(x, h) = cetz.draw.rect((x,0), (x+offset,h), stroke: none, fill: colour.bg3)

  let legend(solid, dashed) = group({
    translate((0,-1))

    line((-1,0),(-.5,0))
    cetz.draw.content((.5,0), [density of #solid])

    translate((0,-1.2em))
    line((-1,0),(-.5,0), stroke: (dash: "dashed"))
    cetz.draw.content((.5,0), [density of #dashed])
  })

  let tick(x) = cetz.draw.on-layer(2, line((x,.1), (x,-.1)))
  let tickY(y) = line((.1,y), (-.1,y))
  for x in (0,offset,1,1+offset) { tick(x) }

  label(0, $0$)
  label(offset, $r epsilon$)
  label(1, $1$)

  legend($X1_0$, $X1_epsilon$)

  group({ // y-axis
    translate((-.5,0))
    line((0,-.3), (0,2.1))
    tickY(1)
    tickY(2)
    content((-.6em,1), $1$)
    content((-.6em,2), $2$)
  })

  rect-at(1, 1)
  line((1+offset/2,.5), (1.5, 1.5), stroke: (thickness: 1pt, dash: "densely-dotted"))
  cetz.draw.circle((1+offset/2,.5), radius: 1pt, stroke: none, fill: colour.fg2)

  line((-.7,0), (0,0), (0,1), (1,1), (1,0), (1.7,0))
  cetz.draw.translate((offset,0))
  line((-.7,0), (0,0), (0,1), (1,1), (1,0), (1.2,0), stroke: (paint: colour.fg2, dash: "dashed"))

  cetz.draw.content((1.2,1.7), $epsilon r times 1$)

  // ------------------------------------------
  cetz.draw.translate((2.5,0))

  label(0, $0$)
  label(.5, $.5$)
  label(1, $1$)
  label(1.6, rect(stroke: none, $1 - epsilon r$ + place(horizon, dx: 7pt, $+$)))

  for x in (0,.5,.5+offset,1,1+offset) { tick(x) }

  rect-at(1, 2)
  cetz.draw.content((-.1,1.7), align(right,$epsilon r times 2$))
  line((1+offset/2, 1), (-.1, 1.5), stroke: (thickness: 1pt, dash: "densely-dotted"))
  cetz.draw.circle((1+offset/2, 1), radius: 1pt, stroke: none, fill: colour.fg2)
  
  line((-.7,0), (0.5,0), (0.5,2), (1,2), (1,0), (1.7,0))
  cetz.draw.translate((offset,0))
  line((-.7,0), (0.5,0), (0.5,2), (1,2), (1,0), (1.2,0), stroke: (paint: colour.fg2, dash: "dashed"))

  cetz.draw.translate((.3,0))
  legend($X2_0$, $X2_epsilon$)
}))<densities-figure>

In @densities-figure, the highlighted areas indicate the weight gained by $[1, infinity)$ as time progresses from $0$ on.
While both $X1_t$ and $X2_t$, as well as their plotted densities, are moving to the right at the
same rate $r$ (both driven by a shared $d X1=r thin d t= d X2$), the rate of weight gain per unit time of
$[1,infinity)$ is twice as large in the $X2$ case as in the $X1$ case.

=== The time-derivative of $PPP(X_t)$

#let rt = $r thin t$
#meta-prop[
  Fix a process $Z_t = zeta + rt$ where $zeta$ is a random variable with CDF $F_zeta$ and continuous density $p_zeta = F'_zeta$.
]

#derivation[
Pick $a in RR$ and evaluate the probability gain over $(-infinity, a)$ at $t$:
#eq($ PP(Z_t<=a) - PP(Z_0<=a) &= PP(zeta +rt <= a) - PP(zeta <=a)
                        \ &= PP(zeta <= a-rt) - PP(zeta<= a) 
                        \ &= - PP(a-rt <= zeta <= a)
                        \ &= - integral_(a- rt)^a p_zeta (a) d a
\ #intertext[(by the mean value theorem, for some $a' in (a-rt,a)$)]
                          &= - rt times p_zeta (a'). $)<increment-as-product>
This gives us a Taylor expansion arount $t=0$:
#eq($ PP(Z_epsilon<=a) = PP(Z_0<=a) - r epsilon times p_zeta (a) + o(epsilon^2). $)<taylor-with-continuous-density>

The term $r epsilon times p_zeta (a)$ corresponds to the highlighted rectangles in @densities-figure, and
where the invariant quantity $r$ is "corrupted" by the multiplier $p_zeta (a) = F'_zeta (a)$. 

#let notation-ok = footnote[No ambiguity can arise with the notation $PPP(zeta)$ and $PPP(F)$
because $zeta$ is of shape $Omega -> RR^N$, while $F$ is of shape $RR -> RR$. And we have
$PPP(zeta) = PPP(F_zeta)$ if $zeta$ is $RR$-valued.]

Recall that we can recover the law of a real random variable from its CDF $F (a)=mu (-infinity,a]$,
by the Lebesgue-Stieltjes integral $mu(A) = integral_A d F(a)$. Denote#notation-ok the measure recovered this way by
$PPP(F)$. Over all #box($a in RR$), @taylor-with-continuous-density is an equation of CDFs, so it
naturally induces an equation of _laws_. The (signed) measure induced by the first order term $r
p_zeta (a) = r F'_zeta (a)$ is then $ r PPP(F'_zeta)$, so @taylor-with-continuous-density in measure
speak reads

$ PPP(Z_epsilon) = PPP(Z_0) - epsilon r thin PPP(F'_zeta) + o(epsilon^2). $

To recover $r$ when taking the derivative $partial_t PPP(Z_t)$ now it is natural to also divide by $PPP(F'_zeta)$ in Radon-Nikodym sense:
$ r = (dif partial_t PPP(Z_t))/(dif PPP(F'_zeta)), $
or, writing it in higher-order derivative notation,
$ r = lr((partial dif PPP(Z_t))/(partial t dif PPP(F'_zeta))bar, size: #90%)_(t=0), $
which indicates how from the increment of $PPP(Z_t)$ we cancel a time $t$ and a density $PPP(F'_zeta)$ factor.
]

That is, we reach the following #conclusion[
A natural initial-distribution-invariant quantity based on the time derivative of $Z_t$'s
law is its Radon-Nikodym derivative against the signed measure induced by (the Lebesgue-Stieltjes
integral with respect to) $Z_0$'s density.]

Two problems arise in the derivation of the last expression: for it to work,
- $Z_0 = zeta$ must admit a (continuous) density $p_zeta= F'_zeta$;
- even then, the absolute continuity condition $PPP(F'_zeta) << PPP(Y_t)$ must hold.

Thus it is important to go back to @taylor-with-continuous-density and proceed in a way that does
not require canceling a $F'_zeta$ term.

=== Getting out into the box

In @densities-figure we treated the increment $PPP(Z_epsilon)-PPP(Z_0)$ to the first order in
$epsilon$ as a rectangle. We then obtained its width by dividing its mass by its height: $(epsilon r
times p_zeta) \/ p_zeta$. Now, while $zeta$'s density $p_zeta$ might not exist, its mass always does. 

And if we write $p_zeta = 1 times p_zeta$, the quantity is numerically identical but
probabilistically understandable as a unit weight of $zeta$, which we always can compute from
$PPP(zeta)$. Can we divide the area $(epsilon r times p_zeta)$ by $1 times p_zeta$ --- a unit mass of $zeta$ then, and
recover $r$? 

This would correspond to dividing the mass $(epsilon r times p_zeta)$ by the mass $(1 times
p_zeta)$, thus arriving at a _dimensionless_ quantity $epsilon r$. But that is nonsensical, because
$epsilon r$ has units of _space_: 
$ Z_epsilon = zeta + r epsilon,
\ mat(delim: #(none, "}"),
  [Z_epsilon] &= "space";
    [epsilon] &= "time") "hence" 
  mat(delim: #none,
    [r] &= "velocity, and";
      [epsilon r] &= "space.") $

That is, the "modified" division $ epsilon r= (epsilon r times p_zeta) / (1 times p_zeta) quad [=
"mass"/"mass"] $ loses a dimension of space. This suggests to add one back, to the numerator.
Conceptually this means that instead of as mass over 1D space $(epsilon r times p_zeta)$, we
consider it as a box $(1 times epsilon r times p_zeta)$ --- a mass over 2D space. Having one extra
spatial dimension in the domain of the law amounts to including the $Z_0 = zeta$ variable and
considering the _joint_ law $ PPP(Z_epsilon\,Z_0): cal(B)(RR^2) -> [0,1]. $

Let us see now how the time increment of $PPP(Z_t\,Z_0)$ looks like with the last derivation in
mind.

=== Diffusions
#meta-prop[
  Consider the diffusion process $ Z_t = zeta + r t + W_t $ for a constant $r>0$ and an initial $Z_0=zeta$ independent from the Wiener process $pr(W,t)$.
]
#derivation[
  Similarly to the diffusion-free context, for any $a in RR$ we have
$ PP(Z_t<=a) &- PP(Z_0<=a) \ &= -PP(a-rt - W_t <= zeta <= a). $

In @increment-as-product we expressed the probability as the length of the interval times the density of $zeta$ at a
point in it, but in this case, the interval is random --- its length depends on $W_t$. We can still
evaluate the joint law, though:

$ dif PPP(Z_0=x\,Z_epsilon=z)
 &= dif PPP(zeta=x\,zeta+rt+W_t=z)
\ &= dif PPP(zeta=x\,W_t = z-rt-x)
\ #intertext[#h(30%) (by independence $zeta perp W_t$))]
 &= dif PPP(zeta=x) dot dif PPP(W_t = z-rt-x)
 $

That is, the law $PPP(zeta)$ naturally falls of from $PPP(Z_0\,Z_epsilon)$, and we cancel $zeta$'s effect completely via the Radon-Nikodym derivative:
$ (dif PPP(Z_0\,Z_epsilon=y))/dPPP(Z_0) (x) = dif PPP(W_t = z-rt-x). $

On sets $(A,B)in calB(RR^2)$, the join law decomposition above acts by
$ PPP(&Z_0\,Z_epsilon)(A,B) = integral.double_((A,B)) dif PPP(Z_0\,Z_epsilon)
\ &= integral_A (integral_B dif PPP(W_t=z-rt-x)) dif PPP(zeta=x)
\ &= integral.double underbrace(1_(A,B) (x,x+rt+y) dif PPP(W_t=y), "pure evolution") dif PPP(zeta=x),
$
where we see the evolution dynamics integrated along the initial condition $zeta$. The Radon-Nikodym
derivative above then corresponds to disintegrating this expression, i.e. taking the integrand only,
which is a map
$ RR times calB (RR) &-> RR
\ (x, B) &|-> integral_B 1_(A,B) (x,x+rt+y) dif PPP(W_t=y) $
shaped precisely as a Markov kernel.
]

#conclusion[
  While the law of $Z_t$ contains the pure evolution increments in a non-trivial way, extractable
  (in the $Z_t=zeta+rt$ case) by a Radon-Nikodym derivative against the initial condition's spatial
  derivative, the joint law of $(Z_0,Z_t)$ contains the entire $Z_0$ dependence as a clean
  factor that is easily cancellable by a Radon-Nikodym derivative against $PPP(Z_0)$, resulting in
  $ dPPP(Z_t\,Z_0)/dPPP(Z_0) = PPP(Z_t given Z_0). $
]

== By Kramer-Moyal expansion

Now that we understand that the proper object to study the distribuitional evolution of an Ito
stochastic process is not $PPP(Y_t)$ but $PPP(Y_t given Y_0)$, we present the first approach to
deriving the Fokker-Planck equation.

We will derive it by Tailor-expansion of the transition densities, following the general approach in
#Walter-seminar or the referenced inside #Zaragoza, sec. 4 and 5. However, we rework it in the
language of measures and Markov kernels so that the probability distributions are not assumed to
admit densities (against the Lebesgue measure, as done in these resources). This is why we will
arrive at a PDE of distributions and not of ordinary functions.

#let Yte = $Y_(t+epsilon)$
Recall that the Dirac-delta function is the characteristic function with flipped arguments:
for all measurable $A subset.eq RR$ and all $y in RR$, $ 1_A (y) = delta_y (A).$
Evaluate that at $y:=Yte$: $ 1_A (Yte) = delta_Yte (A). $

/*
For two time points $t_1 <= t_2$ and an $epsilon>0$,
the Chapman-Kolmogorov equation for the process $Y$ states that the probability flux between times $t_1$
and $t_2 + epsilon$ goes through all possible values at the midtime $t_2$:

$ PP|Y_(t_2 + epsilon) given Y_(t_1) rangle = PP|Y_(t_2 + epsilon) given Y_(t_2) ranglee Y_(t_2) given Y_(t_1) rangle. $

Now we are interested to derive the time-evolution of the left-hand side, and so we need only two
time points. Fix $t>0$ and $epsilon>0$ and plug $t_1 = t_2 = t$ above:

$ PP|Y_(t + epsilon) given Y_t rangle &= PP|Y_(t + epsilon) given Y_t ranglee Y_t given Y_t rangle
                                    \ &= PP|Y_(t + epsilon) given Y_t rangle
$
or, if we allow ourselves to write the time indices only:
$ PP_Y|t + epsilon given t rangle = PP_Y|t + epsilon given t rangle. $
*/

We start from
$ PP[Yte given Y_t] = EE [ delta_Yte given Y_t = y ]. $

We want to Taylor-expand $delta_Yte = delta_(Y_t + (Yte - Y_t))$ around $Y_t$
We aim to apply $d/(d epsilon)|_(epsilon=0)$.

$ partial_t p_t (y) = &-partial_y (a^((1))(y,t)p_t (y))
                   \ &+ 1/2 partial_y^2 (a^((2))(y,t) p_t (y)) $

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

