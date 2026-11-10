// apparently many symbols are shared by many chapters so let's not copy the definitions every time

// the default Typst behaviour is to put attachments to braces on lower line. This overrides that
#let pr(x,i) = $#box($(#x _#i)$)_#i$
#let pr2(x,i,i2) = $#box($(#x _#i)$)_#i2$

#let calF = $cal(F)$
#let calB = $cal(B)$

#let given = math.mid(sym.bar.v)

#let Xs = $X_s$
#let ds = $d s$
#let dt = $d t$
#let dWs = $d W_s$
#let dWt = $d W_t$
#let Xt = $X_t$
#let Yt = $Y_t$

#let langle = sym.chevron.l
#let rangle = sym.chevron.r
#let ranglee = (math.mid(sym.chevron.r.double))
#let ranglee = math.op(math.mid(sym.chevron.r.double))
#let ranglee = math.mid(math.op(sym.chevron.r.double))
#let given = math.mid(sym.bar.v)
#let calB = $cal(B)$
#let ket(c) = box(math.lr($|#c rangle$)) // call `lr` to enlarge the surrounding brackets in |X> if needed
#let kett(c) = box(math.lr($|#c#ranglee$)) // call `lr` to enlarge the surrounding brackets in |X> if needed
#let PPP(c) = $PP#ket(c)$
#let cPPP(c) = $PP#kett(c)$
#let cPPPY(c) = $PP_Y#kett(c)$
#let PPPy(c) = $PP_Y#ket(c)$
#let dPPP(c) = $dif PPP(#c)$ // call `lr` to enlarge the surrounding brackets in |X> if needed

#let oto = box(math.arrow.long.r + place(center+horizon, math.circle.small))

#let eq = math.equation.with(numbering: "(1)", block: true)
#let eqB = math.equation.with(numbering: "(1)", block: true, number-align: bottom)
