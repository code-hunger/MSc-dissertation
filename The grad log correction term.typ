#import "Fokker-Planck diagram.typ": Fokker-Planck-illustration
#import "@preview/intextual:0.1.1": intertext-rule, intertext, centertext
#import "lib/colour.typ": colour
#import "lib/wide.typ": wide

= The $nabla log p$ term

#let tb = $tilde(b)$
#let tsigma = $tilde(sigma)$

Pick an SDE $ d X_t = b_t (X_t) d t + sigma_t d W_t, quad X_0 ~ mu $
and put its distributions $p_t d x = d PP_(X_t)$.

#grid(
  columns: if wide { 3 } else { 1 },
  column-gutter: 5pt,
  row-gutter: 1em,
  align(center, Fokker-Planck-illustration(colour.bg0, colour.fg0)),
  .. if wide { (grid.vline(stroke: colour.bg4), []) } else { () },
  [
    Now let us find $tb, tsigma$ that make for a process $Y_r$ having the densities of $X_t$ in reverse order.

    So we are after $tb, tsigma$ such that $ d Y_r = tb_r (Y_r) d r + tsigma_r d W_r$ has densities 
    $d PP_(Y_r) = d PP_(X_t). $

    Let $q_r d x = d PP_(Y_r)$. Then we desire $q_r = p_t$ for all $r ~ t$.

    Both $p_t, q_r$ satisfy the respective Fokker-Plancks 
    $ dot(p_t) &= F[b_t,sigma_t,p_t] quad quad &&"for all" t in I
    \ dot(q_r) &= F[tb_r, tsigma_r, q_r]  &&"for all" r in I $
  ],
)
#let div = math.op("div")
#let grad = math.op("grad")

To connect the $tb, tsigma$ to $b,sigma$ we need to couple the two equations. Clearly we can get a
relationship between $dot(p)$ and $dot(q)$ if we $partial_r$ the equality $q_r = p_t$ (considering
$r=r(t)$, we have $dot(r)$):
// $
// dot(p)_t 
// = partial_t p_t
// =^! partial_t q_r
// = dot(q)_r partial_t r
// = dot(r) dot(q)_r. $
$
dot(q)_r 
= partial_r q_r
=^! partial_r p_t
= dot(p)_t partial_r t
= dot(t) dot(p)_r. $
Naturally, if we pick $r~t$ to be $r+t=T$, the relation is $dot(q)_r = -dot(p)_t$, meaning that $p_t$ flows oppositely to $q_t$. Applying Fokker-Planck now gives
$ F[tb_r, tsigma_r, q_r] &= dot(t) F[b_t,sigma_t,p_t]. 
\ nabla dot [tb_r q_r] - 1/2 Delta [tsigma_r^2 q_r] &= dot(t) (nabla dot [b_t p_t] - 1/2 Delta [sigma_t^2 p_t])
$
We have two terms of shape $nabla dot (p_t dot)$ and two of shape $Delta (p_t dot)$; rearrange
$
nabla dot [p_t (tb_r - dot(t) b_t)] = 1/2 Delta [p_t (tsigma_r^2 - dot(t) sigma_t^2)]
$
By recalling that $Delta = div compose grad$, pull a $div$ from both sides:
$ div [p_t (tb_r - dot(t) b_t)] = div [ 1/2 grad [p_t (tsigma_r^2 - dot(t) sigma_t^2)] ].
$
Put $s_t equiv tsigma_r^2-dot(t)sigma_t^2$ for short. Split cases $p_t=0$ and $p_t>0$ in the right hand side to pull out a $p_t$ term
#[ #show: intertext-rule
$ nabla[p_t s_t] &= (1_(p_t>0) + 1_(p_t=0)) nabla [s_t p_t] 
\ #intertext[Assuming we pick $s_t>0$, note that on $p_t=0$ we have
          #footnote[$p_t$ is non-negative, so at $x in D$ with $p_t (x)=0$, the gradient must be zero,
              otherwise $p_t (x - epsilon nabla p_t (x)) < 0$ for sufficiently small $epsilon>0$]
          $nabla s_t p_t = 0$, so the $1_(p_t=0)$ term vanishes:]
                &= p_t (nabla s_t p_t) / p_t 1_(p_t>0)
              \ &= p_t s_t 1_(p_t>0) nabla [ln s_t p_t]
$ ]
The equation has one obvious solution for $tb_r$ now if we drop the #div and divide by $p_t$:
$ tb_r = dot(t) b_t + 1/2 s_t 1_(p_t>0) nabla [ln p_t s_t] quad "for all" r~t.
$

For a saner appearance, pick $tsigma_r = sigma_t$ and $r+t=T$ so that $dot(t)=-1$ and $s_t=2 sigma_t^2$, then
$ tb_r = -b_t + sigma_t^2 1_(p_t>0) nabla [ln sigma_t^2 p_t]. $

This derivation works if $sigma_t$ is given strictly positive for all times everywhere.
If $sigma_t$ hits zero, the world shatters.

If $sigma_t (x) = sigma_t$ is constant in space, then#footnote[$nabla [ln sigma_t^2 p_t] = nabla [ln
sigma_t^2 + ln p_t] = cancel(nabla [ln sigma_t^2]) + nabla[ln p_t] = nabla [ln p_t]$] $nabla [ln
sigma_t^2 p_t] = nabla [ln p_t]$ and $ tb_r = -b_t + sigma_t^2 nabla [ln p_t] 1_(p_t>0). $
