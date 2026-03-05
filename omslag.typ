#import "layouts.typ": *

#let pagewidth = 562mm;
#let pageheight = 220mm;
#let spine = 8mm;
#let vouwrand = 22mm;
#let kneep = 10mm;
#let coverwidth = (pagewidth - vouwrand * 2 - spine - kneep * 2) / 2

#set page(
  width: pagewidth,
  height: pageheight,
  margin: (inside: 0pt, outside: 0pt, top: 0pt, bottom: 0pt),
  fill: rgb(49, 111, 59),
)

#set text(font: "Source Sans Pro", size: 12pt)

// comment this to remove the guide lines.
#let guide-color = rgb(255, 0, 0)
#let guide-stroke = 0.5pt
#let guide-positions-x = (
  vouwrand,
  vouwrand + coverwidth,
  vouwrand + coverwidth + kneep,
  vouwrand + coverwidth + kneep + spine,
  vouwrand + coverwidth + 2 * kneep + spine,
  pagewidth - vouwrand,
)
#let guide-positions-y = (vouwrand, pageheight - vouwrand)

#for x in guide-positions-x {
  place(dx: x, dy: 0mm)[
    #line(length: pageheight, angle: 90deg, stroke: (paint: guide-color, thickness: guide-stroke))
  ]
}

#for y in guide-positions-y {
  place(dx: 0mm, dy: y)[
    #line(length: pagewidth, stroke: (paint: guide-color, thickness: guide-stroke))
  ]
}

#place(dx: vouwrand, dy: vouwrand)[
  #block(width: pagewidth - 2 * vouwrand, height: pageheight - 2 * vouwrand)[
    #grid(
      columns: (coverwidth, spine, coverwidth),
      rows: 1fr,
      gutter: 10mm,
      align: center,

      // Back cover
      align(center + horizon)[

        #pad(left: 8mm, right: 16mm, grid(
          columns: (1fr, 2fr),
          rows: 1fr,
          gutter: 8mm,
          align: center,

          // Back cover image
          box(image("fotos/groep const.jpg")),

          // Short description
          text(fill: white, align(left)[
            In 2017 namen William, Tijs, Wouter, Karen en Wouter de taak als bestuurders van de ETV op zich. Hierbij hebben zij zich een jaar lang ingezet voor de vereeniging. Zo werden er activiteiten georganiseerd, lunchlezingen gehost, boeken verkocht, sponsoring binnengehaald, onderwijs verbeterd en nog veel meer.

            Zo klinkt het net alsof er alleen maar serieus gedaan werd, maar dat klopt niet. Een goede balans van nuttige en het prettige werd altijd in stand gehouden. Met de bak reed het 146#super[ste] het buitenland in voor bijvoorbeeld galas, feestjes, constitutie\-borrels.

            Dit fotoboek geeft een inkijkje in al deze avonturen van deze groep helden.
          ]),
        ))

      ],

      // Spine with vertical text
      align(horizon)[
        #rotate(90deg)[
          #text(size: 10pt, weight: "bold", fill: white)[Fotoboek~146]
        ]
      ],

      // Front cover (existing content moved here)
      align(center + horizon)[
        #pad(top: 16mm, bottom: 16mm, grid(
          columns: 1fr,
          rows: (5fr, 1fr),
          gutter: 10mm,
          align: center,

          box(image("fotos/groep const liggend.jpg")),

          align(center)[
            #text(size: 36pt, weight: "bold", fill: white)[Fotoboek 146]\
            #text(size: 18pt, fill: white)[Het evenwichtige bestuur]
          ],
        ))
      ],
    )
  ]
]
