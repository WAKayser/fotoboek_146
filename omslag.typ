#import "layouts.typ": *
#set page(
  width: 504mm,
  height: 180mm,
  margin: (inside: 0pt, outside: 0pt, top: 40pt, bottom: 12pt),
  fill: rgb(49, 111, 59),
)

#set text(font: "Source Sans Pro", size: 12pt)

#let spine = 4mm
#let cover = (504mm - spine) / 2

#block(width: 100%, height: 100%)[
  #grid(
    columns: (cover, spine, cover),
    rows: 1fr,
    gutter: 0mm,
    align: center,

    // Back cover
    align(center + horizon)[

      #pad(left: 20pt, right: 40pt, grid(
        columns: (1fr, 2fr),

        rows: 1fr,
        gutter: 8mm,
        align: center,

        // Back cover image

        box(image(photo("groep const.jpg"))),

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
        #text(size: 8pt, weight: "bold", fill: white)[Fotoboek~146]
      ]
    ],

    // Front cover (existing content moved here)
    align(center + horizon)[
      #grid(
        columns: 1fr,
        rows: (4fr, 2fr),
        gutter: 2cm,
        align: center,

        box(image(photo("groep const liggend.jpg"))),

        align(center)[
          #text(size: 36pt, weight: "bold", fill: white)[Fotoboek 146]\
          #text(size: 18pt, fill: white)[Het evenwichtige bestuur]
        ],
      )
    ],
  )
]
