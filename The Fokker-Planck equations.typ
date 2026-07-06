#import "lib/references.typ": myref

= Chapman Kolmogorov

Here I follow #myref("Zaragoza")
Assume a reference measure exists with respect to which the laws $PP_(Y_i), i in I$ have densities $p_i$.
I assume it is the Lebesgue measure that works, but maybe this discussion works for other reference
measures too?

#let grid_section(c) = grid.cell(colspan: 3, align: center, heading(level: 3,c))
#grid(columns: 3, column-gutter: 1em, row-gutter: 1em,
grid_section[Kolmogorov equations],
[
Denote $p_(i|j) (y | z) = p_(i j)(y, z) \/ p_j (z)$ the conditional density.

The Chapman-Kolmogorov equation states that the probability density of getting from $y_1$ to $y_3$
is

$ p_(3|1)(y_3 | y_1) = integral p_(3|2)(y_3 | y) p_(2|1)(y | y_1) dif y $

The meaning is clear.

The Master equation is 
$ partial_t p_(t|t_0) (y|y_0) = integral &(W^"in"_(y|y') dot p_(t|t_0) (y'|y_0)
                                     \ &- W^"out"_(y'|y) dot p_(t|t_0) (y|y_0)) dif y' $
Now expand the right hand side as a function of $r:=y'-y$ around $r=0$.

For diffusions we can drop higher order terms and get Fokker-Planck

$ partial_t p_t (y) = &-partial_y (a^((1))(y,t)p_t (y))
                   \ &+ 1/2 partial_y^2 (a^((2))(y,t) p_t (y)) $
],
grid.vline(),
none,
[
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
],
)

