#let page_refs() = (
  query(<ref-mention>)
  .filter(el => el.location().page() == here().page())
  .map(i => i.value))

#let myfooter = context {
  let refs = page_refs()
  if refs.len() > 0 {
    [References on this page: #refs]
  }
}

#let myref(x) = [ [#x] #metadata(x) <ref-mention> ]
