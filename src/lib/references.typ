#let page_refs(lab) = (
  query(lab)
  .filter(el => el.location().page() == here().page())
)

#let myfooter = context {
  let refs = page_refs(<ref-mention>).map(i => i.value)
  if refs.len() > 0 {
    [References on this page: #refs]
  }
  let dirak-notation = page_refs(<dirak-notation>)
  if dirak-notation.len() > 0 {
    [This page uses Dirak-delta notation for laws]
  }
}

#let myref(x) = [[#x]#metadata(x)<ref-mention>]
