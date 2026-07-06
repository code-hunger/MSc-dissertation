#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let Fokker-Planck-illustration(fill, stroke) = cetz.canvas(x: 1cm, {
  import cetz.draw: line, content, group, floating, circle
  import calc: sqrt, pi, exp

  let normal-pdf(x, var) = {
    let s = sqrt(var)
    1 / (sqrt(2 * pi) * s) * exp(-(x * x) / (2 * var))
  }

  let gauss-plot(var, n: 4) = {
    let std = sqrt(var)
    let N = 10
    let xs = range(-N,N+1).map(x => 1.8/calc.pi*calc.tan(x/N))
    return line(stroke: stroke, ..xs.map(x => (x, normal-pdf(n * x * std, var))))
  }

  let times = (0.1, 0.3, 0.7, 0.9)
  let plots = (group({cetz.draw.scale(x: .5);gauss-plot(0.2, n: 4)}), gauss-plot(0.3), gauss-plot(0.9, n: 3), gauss-plot(3, n: 2.5))

  let offset = 2
  content((-offset, .5), align(center)[*Diffuse*\ $d X=b d t + sigma d W$])
  content((+offset, .5), align(center)[*Denoise*\ $d Y=tb d t + tsigma d W$])

  for (i, t) in array.enumerate(times) {
    let xt = 10 * t

    cetz.draw.translate((0, -1))

    if i == 2 { cetz.draw.translate((0, -1)) }

    group({
      cetz.draw.translate((-offset, 0))
      plots.at(i)
      content((1.2, 0), $p_(.#xt)$)
    })

    group({
      cetz.draw.translate((offset, 0))
      plots.at(times.len() - i - 1)
      content((-1.2,0), $q_(.#xt)$)
    })
  }

  content((0,2), align(center)[Both evolve by Fokker-Planck.\ But want $p_t = q_r$!])
})

#let Fokker-Planck-illustration(fill, stroke) = {
  let sqrt = calc.sqrt
  let pi = calc.pi
  let normal-pdf(x, var) = {
    let s = sqrt(var)
    1 / (sqrt(2 * pi) * s) * calc.exp(-(x * x) / (2 * var))
  }

  let gauss-plot(var, n: 4) = {
    let std = sqrt(var)
    let N = 10
    let xs = range(-N,N+1).map(x => 1.8/calc.pi*calc.tan(x/N))
    return fletcher.cetz.draw.line(stroke: stroke, ..xs.map(x => (x, normal-pdf(n * x * std, var))))
  }

  let times = (0.1, 0.3, 0.7, 0.9)

  let labl(i) = label("graph-left-" + str(i))
  let labr(i) = label("graph-right-" + str(i))

  let labl1(i) = label("graph-p-left-" + str(i))
  let labr1(i) = label("graph-q-right-" + str(i))

  let offset = 2
  return diagram(
    edge-stroke: stroke,
    spacing: (.5em, 1em),
    node((-1, -1), align(center)[*Diffuse*\ $d X=b d t + sigma d W$]),
    node((+1, -1), align(center)[*Denoise*\ $d Y=tilde(b) d r + tilde(sigma) d W$]),

    array.enumerate(times).map(((i,t)) => {
      fletcher.hide(node((-1,i), inset: 1em, name: labl(i), [=]))
      fletcher.hide(node((+1,i), inset: 1em, name: labr(i), [=]))
      let angle = 25deg
      node(
        (rel: (angle, 3em), to: labl(i)),
        name: labl1(i),
        align(horizon,$p_(.#t)$)
      )
      if i < 3 { edge("d", "=>") }
      node(
        (rel: (180deg - angle, 3em), to: labr(i)),
        name: labr1(i),
        $q_(.#t)$
      )
      if i < 3 { edge("d", "=>") }
    }),

    render: (grid, nodes, edges, opts) => {
      let draw = fletcher.cetz.draw

      let plots = (draw.group({draw.scale(x: .4);gauss-plot(0.2, n: 4)}), gauss-plot(0.3), gauss-plot(0.9, n: 3), gauss-plot(3, n: 2.5))
      fletcher.cetz.canvas({
        fletcher.draw-diagram(grid, nodes, edges, debug: opts.debug)
        for (i,t) in array.enumerate(times) {
          import cetz.draw: content, group

          let p = fletcher.find-node(nodes, labl(i))
          let q = fletcher.find-node(nodes, labr(i))

          draw.group({ 
            draw.translate(p.pos.xyz);
            plots.at(i) 
          })

          draw.group({ 
            draw.translate(q.pos.xyz);
            plots.at(times.len() - i - 1) 
          })
        }
      })
    }
  )
}
