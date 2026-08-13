#import "lib/colour.typ": colour

= The sampling problem
As described in [Andrea], we consider 3 classes of sampling problems depending on what is known:

#let pr(x,i) = $#box($(#x _#i)$)_#i$
#let desc(c, d) = block(text(size: 9pt, d), below: 7pt) + c

#let iperp = box($~^#scale(x: 120%, box($perp$, baseline: 13pt))$, baseline: 25%)

#align(center, grid(columns: 3, inset: .8em,
// align: (x, y) => if x > 0 { center + top } else { right },
align: center + horizon,
grid.hline(stroke: colour.fg4, y: 1, start: 1),
grid.hline(stroke: colour.fg1, y: 2),
grid.hline(stroke: colour.fg3, y: 3),
grid.hline(stroke: colour.fg3, y: 4),
grid.vline(stroke: colour.fg3, x: 2, start: 2),

[], grid.cell(colspan: 2)[Task: *produce a sample* $x ~ mu$ where],

[],
grid.cell(colspan: 1, [we know]),
[but do not know],

[Case I.],
desc($mu$, [the distribution]),
grid.cell(line(start: (0em,1em),end: (4em, 0em),stroke: 0.5pt)), 

[Case II.],
desc(
  [$pr(mu,theta)$ and $pr(x,i) iperp mu_theta$/* , for some $theta$ */],
  [a family of distributions\ and a sample sequence]),
[the parameter $theta$,\ and hence which $mu_theta$], 

[Case III.],
desc(
  [$pr(x,i) iperp mu$/* , for some $mu$ */],
  [a sample sequence only]),
[the distribution $mu$]
))

We will work in case I. for now and assume we know the distribution $mu$. Diffusion based sampling
is the approach of approximating $mu$ by a sequence $pr(nu,t)$
