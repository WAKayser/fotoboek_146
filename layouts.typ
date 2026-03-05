#import "@preview/tessera:0.1.0": *
#import "fotos.typ": fotos

#let used-photos-state = state("used-photos", ())
#let high_quality = sys.inputs.at("HQ", default: "false")
#let photos-dir = if high_quality == "false" { "thumbs" } else { "fotos" }
#let photo = name => photos-dir + "/" + name

#let render-unused-photos(used) = {
  if high_quality == "false" {
    let missing = fotos.filter(photo => not used.contains(photo))
    if missing.len() > 0 {
      pagebreak()
      heading(level: 2)[Unused fotos]

      text()[left #missing.len() of #fotos.len() ]
      grid(
        // columns: (1fr, 1fr, 1fr, 1fr),
        for photo in missing {
          grid(
            rows: (auto, auto),
            gutter: 0.3em,
            image("thumbs/" + photo, height: 40mm, fit: "cover"),
            text(size: 8pt)[#photo],
          )
        },
      )
    }
  }
}

#let fotopage(
  title,
  bovenschrift: none,
  onderschrift: none,
  datum: none,
  photos: none,
  gutter: 6pt,
) = {
  pagebreak(weak: true)
  let map-photo = item => {
    if type(item) == str {
      image(photo(item))
    } else {
      let scalable-flag = item.at("aspect", default: "false")
      let img = image(photo(item.at("path")))
      if scalable-flag != "false" { scalable(img, aspect-ratio: scalable-flag) } else { img }
    }
  }
  let entries = photos.map(item => {
    if type(item) == array { item.map(map-photo) } else { map-photo(item) }
  })

  let inner_track = item => {
    let path = if type(item) == str { item } else { item.at("path") }
    [#used-photos-state.update(list => (..list, path))]
  }

  for thing in photos {
    if type(thing) == array {
      for item in thing { inner_track(item) }
    } else {
      inner_track(thing)
    }
  }

  block(breakable: true)[
    // #if title != none {
    #context {
      let page-num = counter(page).get().first()
      if calc.rem(page-num, 2) == 0 {
        align(start)[#text(size: 24pt, weight: "bold")[#title]]
        if datum != none {
          place(top + end, dy: 5pt)[#text(size: 16pt, weight: "semibold", style: "italic", fill: rgb(
            49,
            111,
            59,
          ))[#datum]]
        }
      } else {
        align(end)[#text(size: 24pt, weight: "bold")[#title]]
        if datum != none {
          place(top + start, dy: 5pt)[#text(size: 16pt, weight: "semibold", style: "italic", fill: rgb(
            49,
            111,
            59,
          ))[#datum]]
        }
      }
    }
    // }
    #if bovenschrift != none {
      align(center)[#text(size: 12pt)[#bovenschrift]]
    }
    #masonry(
      ..entries,
      gutter: gutter,
    )
  ]

  if onderschrift != none {
    align(center)[#text(size: 14.6pt)[#onderschrift]]
  }
  context {
    let page-num = counter(page).get().first()
    if calc.rem(page-num, 2) == 0 {
      place(bottom + left, dy: -10pt)[#counter(page).display("1")]
    } else {
      place(bottom + right, dy: -10pt)[#counter(page).display("1")]
    }
  }
}
