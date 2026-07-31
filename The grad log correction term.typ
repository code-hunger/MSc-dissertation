#import "Fokker-Planck diagram.typ": Fokker-Planck-illustration
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
    So we are after $tb, tsigma$ such that $ d Y_r = tb_r (Y_r) d r + tsigma_r d W_r$ has densities 
    $d PP_(Y_r) = d PP_(X_t). $

    Let $q_r d x = d PP_(Y_r)$. Then we desire $q_r = p_t$ for all $r ~ t$.

    Both $p_t, q_r$ satisfy the respective Fokker-Plancks 
    $ dot(p_t) &= F[b_t,sigma_t,p_t] quad quad &&"for all" t in I
    \ dot(q_r) &= F[tb_r, tsigma_r, q_r]  &&"for all" r in I $
  ],
)

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
By recalling that $Delta(?) = nabla dot [nabla ?]$, pull a $nabla dot$ from both sides:
$
nabla dot [p_t (tb_r - dot(t) b_t)] = nabla dot [ 1/2 nabla [p_t (tsigma_r^2 - dot(t) sigma_t^2)] ]
$
The equation has one obvious solution for $tb_r$ now (drop $nabla dot$, divide by $p_t$ and rearrange)
$ tb_r = dot(t) b_t + 1/(2 p) nabla [p_t (tsigma_r^2 - dot(t) sigma_t^2)] quad "for all" r~t.
$
For a saner appearance, pick $tsigma_r = sigma_t$ and $r+t=T$ so that $dot(t)=-1$, then
#footnote[With the additional simplification of $nabla [p_t sigma_t^2]\/p_t = sigma_t^2 nabla [p_t sigma_t^2]\/p_t sigma_t^2 = sigma_t^2 nabla [ln p_t sigma_t^2] $.]
$ tb_r = -b_t + (nabla [p_t sigma_t^2])/p_t = -b_t + sigma_t^2 nabla [ln p_t sigma_t^2]. $

