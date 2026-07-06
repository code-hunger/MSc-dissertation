
#import "lib/colour.typ": colour
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4": plot

#import "@preview/intextual:0.1.1": intertext-rule, intertext, centertext

// f(x) = Φ(x) for x<0, and Φ(x)−1 for x>0 (as requested)
// PLOT Standard normal CDF: Φ(x) = 1/2 · (1 + erf(x/√2))
#let erf(x) = calc.atan(x)/90deg
#let pi = calc.pi
#let erf(x) = calc.tanh(167*x/148 + 11*x*x*x / 109)
#let normalCDF(x) = 0.5 * (1 + erf(x / calc.sqrt(2)))

#let my-plot(..args, f) = cetz.canvas(plot.plot(
  size: (4, 2),
  axis-style: "school-book",
  x-label: none,
  y-label: none,
  x-tick-step: 3,
  y-tick-step: .5,
  plot-style: (stroke: colour.fg2),
  mark-style: (stroke: colour.fg2, fill: colour.bg1),
  ..args,
  f
))

#set page("a5")

= Wiener process invariant measure

We are looking for an invariant measure of the Wiener process $W_t$, i.e. for a solution $mu$ of the
measure equation
$ mu dot W_t = mu. $
We are looking only for _finite_ measures $mu: cal(B)(RR) -> [0, infinity)$, so that we are allowed to subtract $mu(A)$ as we wish
for any Borel $A$.

We apply both sides at the (measurable) set $(-infinity,a)$ for $a in RR$.
Evaluate $ (mu dot W_t)(-infinity,a)
        &= PP(W_t^mu < a) //= Phi^mu_t (a)
         // = integral Phi^x_t (a) dif mu(x)
         &= integral Phi_t (a-x) dif mu(x). $

Now write $mu(-infinity,a) = integral 1_( (-infinity,a) ) (x) dif mu(x) = integral 1_( (0, infinity) ) (a-x) dif mu(x).$

#let eq = math.equation.with(numbering: "(1)", block: true)

Then $mu dot W_t = mu$ at $A=(-infinity, a)$ reads, after rearranging, 
#eq($integral (Phi_t - 1_( (0,infinity) ))(a-x) dif mu(x) = 0.$) <F-1-mu-0>
Curiously this is the statement that the convolution of the function #box( $Phi_t - 1_( (0,infinity) )$ ) with the
measure $mu$ vanishes at the point $a$.

#let t = 1
#grid(columns: 3, gutter:1em,
[
  So $mu dot W_t = mu$ is equivalently#footnote[because $(-infinity,a), a in RR$ generate $cal(B)(RR)$, we are not losing information when evaluating $mu dot W_t = mu$ at $(-infinity, a)$.] written as $ (Phi_t - 1_( (0,infinity) )) * mu = 0 $ as an equality of
  functions $RR -> RR$. So an invariant measure of $W_t$ has to satisfy this convolutional equation.
],
grid.vline(stroke: colour.fg3),
[],
figure(caption: [Graph of $( Phi_(t=#t) - 1_( (0,infinity) ) )(x)$], supplement: none, my-plot({
  plot.add(domain: (-4, 0), x => normalCDF(x/t))
  plot.add(domain: (0, 4), x => normalCDF(x/t)-1)
  plot.add(mark-style: (fill: colour.fg2), mark: "o",  ((0,.5),))
  plot.add(mark: "o",  ((0,-.5),))
}))
)

#let phit=$Phi_t$
#let ua = $underline(a)$
We look now at that integral separately on $(-infinity,a)$ and#footnote[we denote the inclusion of the point $x=a$ in the integral boundary by $underline(a)$.
So $integral_a^b$ denotes the integral over $(a,b)$, and $integral_ua^b$ denotes the integral over $[a,b)$.] $[a,infinity)$:
$ forall a: quad 
  0 &=^(( #ref(supplement: none, <F-1-mu-0>) ))
       integral (Phi_t - 1_( (0,infinity) ))(a-x) dif mu(x) \
    &= integral_(-infinity)^a ( Phi_t (a-x) - 1 ) dif mu(x) + integral_ua^infinity Phi_t (a-x) dif mu(x). $

Up to this point we haven't used any knowledge about $Phi_t$ so this equality applies to the law of
any process. Now we kill the $(-1)$ in the first term by applying $Phi_t (y) - 1 = -Phi_t (-y)$,  which gets us the equality
$ forall a: integral_(-infinity)^a Phi_t ( -(a-x) ) dif mu(x) = integral_ua^infinity Phi_t (a-x) dif mu(x), $
and if we notice that the argument to the $phit$ is $-|a-x|$ in both domains:
#eq($forall a: integral_(-infinity)^a Phi_t ( -|a-x| ) dif mu(x) = integral_ua^infinity Phi_t (-|a-x|) dif mu(x). $) <super-symmetry>

#let mat = $m^a_t$
#grid(columns: 3, gutter: 1em,
[That is, any $W_t$-invariant measure $mu$ must give the same integral of $Phi$ on both
sides of any real $a$. This kind of super-symmetry indicates that $mu$ should be somehow similarly
behaved everywhere.],
grid.vline(stroke: colour.fg3),[],
cetz.canvas(plot.plot(
  size: (3,1),
  x-label: none,
  y-label: none,
  y-tick-step: .5,
  x-ticks: (),
  x-tick-step: 10,
  y-ticks: (0,0.5,1),
  //y-max: 1, y-min: 0,
  axis-style: "left",
  x-format: (x) => if x == 0 { $a$ },
  plot-style: (stroke: colour.fg2),
  mark-style: (stroke: colour.fg3, fill: colour.fg3, size: .5),
  name: "plot",
  {
    let t = 2
    let d = 6
    plot.add(sample-at: (0,), domain: (-d, d), x => normalCDF(-calc.abs(x)/t))
    //plot.add(mark: "o", ((0,.5),))
    plot.add-anchor("tr", ( 5, .6))
  }) + {
    cetz.draw.content("plot.tr" , $Phi_t (-|a-x|)$)
  }) + [The graph of the integrands in @super-symmetry[eq.]]
)

//.......... IT IS BROKEN BELOW, DOES NOT LEAD ANYWHERE :[

We can extract $mu("interval")$ expressions from the integrals above by rewriting 
$Phi(-|a-x|) = 1-Phi(|a-x|)$ in @super-symmetry[eq.]:
$ forall a: mu(-infinity,a) - m^a_t (-infinity,a) &= mu[a, infinity) - m^a_t [a,infinity), $
where $m^a_t (A) := integral_A Phi_t (|a-x|)dif mu(x)$. Or, more succinctly,
#eq($forall a: ( mu - mat )(-infinity,a) &= (mu - mat)[a,infinity). $)<super-symmetry-2>

Having an expression relating $mu$ on each pair of intervals $(-infinity,a),[a, infinity)$, it is
natural to express an interval $[a,b)$ in two ways and derive an expression for $mu[a,b)$.

Pick reals $a<b$ and instantiate @super-symmetry-2[eq.] with $a$ and $b$, and in both cases split the
measures (integrals) at the points $a$ and $b$:

#let mbt = $m^b_t$
$ ( mu - mat )(-infinity,a) = (mu - mat)( [a,b) union [b,infinity) ) \
  ( mu - mbt )((-infinity,a) union [a,b)) = (mu - mbt)[b,infinity).
$
Now subtract one equation from the other#footnote[to keep the $mu[a,b)$ terms and kill the $mu((-infinity,a)union[b,infinity))$ terms.] and solve for $mu[a,b)$:
$ 2 mu[a,b) = ( mbt - mat )(-infinity,a) + (mbt + mat)[a,b) + (mat - mbt)[b, infinity) $

#let a = -3
#let b =  3

#grid(columns: 2, gutter: 1em,
[Now we bound each term:
- on $(-infinity,a)$ we have $mbt >= mat$,
- on $[b, infinity)$ we have $mat >= mbt$,
- on $[a,b)$ we have $ mat + mbt >= c_(a b) mu$ for a constant $ c_(a b) = inf_(a<= t <b) (Phi(|a-x|)+Phi(|b-x|)). $
],
1 * cetz.canvas(plot.plot(
  size: (3,1.8),
  x-label: none, y-label: none,
  x-ticks: (a,b), x-tick-step: none,
  y-ticks: (.5,1,2), y-tick-step: none,
  y-min: 0, y-max: 2,
  axis-style: "left",
  x-format: (x) => if x < 0 { $a$ } else if (x>0) { $b$ },
  plot-style: (stroke: colour.fg2),
  mark-style: (stroke: colour.fg3, fill: colour.fg3, scale: .3),
  name: "plot",
  {
    let t = 1
    let d = 9
    let fa = x => normalCDF(calc.abs(x - a)/t)
    let fb = x => normalCDF(calc.abs(x - b)/t)
    plot.add(sample-at: (b,), domain: (-d, d), fa)
    plot.add(sample-at: (a,), domain: (-d, d), fb)

    plot.add(domain: (a, b), x => fa(x) + fb(x))

    // plot.add(mark: "o", ((2,.5),)); plot.add(mark: "o", ((-2,.5),))
    plot.add-anchor("r", (b + 3, 0.35))
    plot.add-anchor("l", (a - 3, 0.35))
    plot.add-anchor("t", (b + 4, 1.7))
  }) + {
    cetz.draw.content("plot.l" , $(d mat)/(d mu)$)
    cetz.draw.content("plot.r" , $(d mbt)/(d mu)$)
    cetz.draw.content("plot.t" , $(d (mat + mbt))/(d mu)$)
  })
)
So we bound $2 mu(a,b) >= 0 + c mu(a,b) + 0 = mu(a,b)$, forcing $mu(a,b) = 0$.

#pagebreak()
= Wiener process invariant measure

We are looking for an invariant measure of the Wiener process $W_t$, i.e. for a solution $mu$ of the
measure equation
$ mu dot W_t = mu. $
We are looking only for _finite_ measures $mu: cal(B)(RR) -> [0, infinity)$, so that we are allowed to subtract $mu(A)$ as we wish
for any Borel $A$.

Put $A=(-infinity, a)$. Write each of $mu$, $mu dot W_t$ as a $mu$-integral of a function of
argument $(a - x)$:
#grid(columns: 3, gutter: .5em,
$ (mu dot W_t) (A) 
  &= PP_(W_t^mu)(-infinity, a)
  \ &= integral PP_(W_t^x)(-infinity,a) dif mu(x) 
  \ &= integral phit(a-x) dif mu(x) 
$,
grid.vline(stroke: colour.fg3),[],
$ mu(A) 
  &= mu(-infinity, a)
  \ &= integral 1_((-infinity, a))(x) dif mu(x)
  \ &= integral 1_((0,infinity))(a-x) dif mu(x)
$)

Evaluate the difference $mu - mu dot W_t$: 
#[
  #show: intertext-rule
$ (mu - mu dot W_t)(A) 
  &= integral (1_((0,infinity)) - phit)(a-x) dif mu(x)
\ #centertext[(Partition the integral on $(-infinity,a)$ and $[a,infinity)$)]
  &= integral_(-infinity)^a (1- phit(a-x)) dif mu(x) - integral_a^infinity phit(a-x) dif mu(x)
\ #centertext[(Apply $1-phit(y)=phit(-y)$ on the left)]
  &= integral_(-infinity)^a phit(-(a-x)) dif mu(x) - integral_a^infinity phit(a-x) dif mu(x)
\ &= integral_(-infinity)^a phit(-|a-x|) dif mu(x) - integral_a^infinity phit(-|a-x|) dif mu(x)
\ &= m_t^a (-infinity,a) - m_t^a [a,infinity)
$
]
where $m_t^a (A) := integral_A phit(-|a-x|) dif mu(x)$.
