// =============================================================================
// VIBE CODING PRESENTATION - CYBERNETIC STYLE (TOUYING)
// =============================================================================

#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/nerd-icons:0.2.0": nf-icon

// Touying theme configuration with cybernetic colors
#show: simple-theme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary: rgb("#2DD4BF"),          // accent-teal
    secondary: rgb("#A78BFA"),        // accent-purple
    tertiary: rgb("#F472B6"),         // accent-pink
    neutral-lightest: rgb("#0B0F19"), // bg-dark
    neutral-darkest: rgb("#cbd5e1"),  // text-body
  ),
  config-page(
    fill: rgb("#0B0F19"),
    margin: (x: 1.5cm, top: 1.5cm, bottom: 1cm),
  ),
)

#set text(size: 14pt, font: "Inter", fill: rgb("#cbd5e1"))

// =============================================================================
// CYBERNETIC COLOR PALETTE
// =============================================================================

#let bg-dark = rgb("#0B0F19")        // Dark background
#let text-body = rgb("#cbd5e1")      // Body text (light gray)
#let accent-teal = rgb("#2DD4BF")    // Primary accent - teal
#let accent-purple = rgb("#A78BFA")  // Secondary accent - purple
#let accent-pink = rgb("#F472B6")    // Tertiary accent - pink
#let text-muted = rgb("#64748b")     // Muted/secondary text
#let border-dark = rgb("#1e293b")    // Subtle borders
#let surface = rgb("#111827")        // Elevated surface

// =============================================================================
// HEADING STYLES
// =============================================================================

#show heading.where(level: 1): it => {
  text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 28pt)[#it.body]
  v(0.5em)
}

#show heading.where(level: 2): it => {
  text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 20pt)[#it.body]
  v(0.3em)
}

#show heading.where(level: 3): it => {
  text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 16pt)[#it.body]
  v(0.2em)
}

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

// Title slide with gradient
#let title-slide(title, subtitle: none, author: none, date: none) = {
  slide[
    #v(0.5em)
    #set align(center + horizon)
    #block(width: 100%)[
      #text(
        font: "JetBrains Mono",
        size: 48pt,
        weight: "bold",
        fill: gradient.linear(accent-purple, accent-teal, angle: 90deg),
      )[#title]

      #if subtitle != none {
        v(0.5em)
        text(fill: text-body, size: 20pt)[#subtitle]
      }

      #if author != none or date != none {
        v(2em)
        text(fill: text-muted, size: 16pt)[
          #if author != none [#author]
          #if author != none and date != none [ · ]
          #if date != none [#date]
        ]
      }
    ]
  ]
}

// Section divider slide
#let section-slide(title, icon: none, subtitle: none, speaker-name: none) = {
  slide[
    #if speaker-name != none [
      #place(bottom + left)[
        #block(
          fill: accent-teal.transparentize(85%),
          stroke: 1.5pt + accent-teal,
          inset: (x: 10pt, y: 6pt),
          radius: 6pt,
        )[
          #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[#speaker-name]
        ]
      ]
    ]
    
    #set align(center + horizon)
    #block(
      fill: gradient.linear(accent-purple, accent-teal, angle: 90deg),
      inset: 2em,
      radius: 12pt,
    )[
      #if icon != none {
        text(fill: bg-dark, size: 48pt)[#nf-icon(icon)]
        v(0.5em)
      }
      #text(
        font: "JetBrains Mono",
        size: 36pt,
        weight: "bold",
        fill: bg-dark,
      )[#title]
      #if subtitle != none {
        v(0.3em)
        text(fill: bg-dark.lighten(20%), size: 16pt)[#subtitle]
      }
    ]
  ]
}

// Standard content slide
#let content-slide(title, body, speaker-name: none, demo-label: none) = {
  slide[
    #if speaker-name != none [
      #place(bottom + left)[
        #block(
          fill: accent-teal.transparentize(85%),
          stroke: 1.5pt + accent-teal,
          inset: (x: 10pt, y: 6pt),
          radius: 6pt,
        )[
          #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[#speaker-name]
        ]
      ]
    ]
    #if demo-label != none [
      #place(bottom + left, dx: 140pt)[
        #block(
          fill: accent-pink.transparentize(85%),
          stroke: 1.5pt + accent-pink,
          inset: (x: 10pt, y: 6pt),
          radius: 6pt,
        )[
          #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 11pt)[Demo: #demo-label]
        ]
      ]
    ]

    #block(
      fill: accent-teal.transparentize(90%),
      inset: (x: 12pt, y: 8pt),
      width: 100%,
    )[#text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[#title]]

    #v(0.6em)
    #body
  ]
}

// Quote slide
#let quote-slide(quote, attribution: none) = {
  slide[
    #set align(center + horizon)
    #block(
      fill: surface,
      stroke: (left: 4pt + accent-purple),
      inset: 2em,
      radius: 8pt,
      width: 90%,
    )[
      #text(fill: text-body, size: 22pt, style: "italic")[#quote]
      #if attribution != none {
        v(1em)
        text(fill: text-muted, size: 14pt)[— #attribution]
      }
    ]
  ]
}

// Info box
#let info-box(content, type: "info") = {
  let styles = (
    info: (color: accent-teal, label: "INFO"),
    note: (color: accent-purple, label: "NOTE"),
    warning: (color: accent-pink, label: "WARNING"),
    tip: (color: accent-teal, label: "TIP"),
  )
  let s = styles.at(type)

  block(
    fill: s.color.transparentize(90%),
    stroke: 1pt + s.color.transparentize(50%),
    inset: 8pt,
    radius: 6pt,
    width: 100%,
  )[
    #text(fill: s.color, weight: "bold", font: "JetBrains Mono", size: 9pt)[#s.label]
    #h(0.5em)
    #text(fill: text-body, size: 12pt)[#content]
  ]
}

// Gradient badge
#let badge(label) = {
  box(
    fill: gradient.linear(accent-purple, accent-teal, angle: 90deg),
    inset: (x: 12pt, y: 6pt),
    radius: 4pt,
  )[#text(fill: bg-dark, weight: "bold", font: "JetBrains Mono", size: 10pt)[#label]]
}

// Status badge
#let status(label, type: "active") = {
  let colors = (
    active: accent-teal,
    pending: accent-purple,
    warning: accent-pink,
    default: text-muted,
  )
  let color = colors.at(type, default: text-muted)

  box(
    fill: color.transparentize(80%),
    stroke: 1pt + color,
    inset: (x: 10pt, y: 4pt),
    radius: 12pt,
  )[#text(fill: color, weight: "bold", font: "JetBrains Mono", size: 10pt)[#label]]
}

// Icon with color
#let icon(name, color: accent-teal) = {
  text(fill: color, size: 20pt)[#nf-icon(name)]
}

// Bullet list styling
#let cyber-list(..items) = {
  for item in items.pos() {
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.4em,
      text(fill: accent-teal, size: 12pt)[#nf-icon("nf-md-chevron_right")],
      text(fill: text-body, size: 13pt)[#item],
    )
    v(0.3em)
  }
}

// Numbered list styling
#let cyber-numbered(..items) = {
  for (i, item) in items.pos().enumerate() {
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.6em,
      box(
        fill: accent-teal.transparentize(80%),
        stroke: 1pt + accent-teal,
        inset: (x: 6pt, y: 3pt),
        radius: 4pt,
      )[#text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[#str(i + 1)]],
      text(fill: text-body, size: 14pt)[#item],
    )
    v(0.4em)
  }
}

// Two-column layout
#let two-columns(left, right, ratio: (1fr, 1fr)) = {
  grid(
    columns: ratio,
    column-gutter: 2em,
    left,
    right,
  )
}

// Feature card
#let feature-card(title, items, accent: accent-teal) = {
  block(
    fill: surface,
    stroke: 1pt + accent.transparentize(50%),
    inset: 1em,
    radius: 8pt,
    width: 100%,
  )[
    #text(fill: accent, weight: "bold", font: "JetBrains Mono", size: 14pt)[#title]
    #v(0.5em)
    #for item in items {
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.5em,
        text(fill: accent)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 13pt)[#item],
      )
      v(0.3em)
    }
  ]
}

// Fixed-height card for consistent grid layouts
#let card(body, accent: accent-teal, height: auto, centered: true) = {
  box(
    height: height,
    width: 100%,
    block(
      fill: surface,
      stroke: 1pt + accent.transparentize(50%),
      inset: 1em,
      radius: 6pt,
      width: 100%,
      height: 100%,
    )[
      #if centered {
        set align(center + horizon)
        body
      } else {
        body
      }
    ]
  )
}

// Icon card for "Where do we vibe code" style
#let icon-card(icon-name, title, subtitle, accent: accent-teal, height: auto) = {
  box(
    height: height,
    width: 100%,
    block(
      fill: surface,
      stroke: 1pt + accent.transparentize(50%),
      inset: 1em,
      radius: 6pt,
      width: 100%,
      height: 100%,
    )[
      #set align(center + horizon)
      #text(fill: accent, size: 28pt)[#nf-icon(icon-name)]
      #h(0.4em)
      #text(fill: accent, weight: "bold", font: "JetBrains Mono", size: 14pt)[#title]
      #v(0.3em)
      #text(fill: text-muted, size: 12pt)[#subtitle]
    ]
  )
}

// Concept card for "Vibe Coding 101" style
#let concept-card(title, description, accent: accent-teal, note: none, height: auto) = {
  box(
    height: height,
    width: 100%,
    block(
      fill: accent.transparentize(90%),
      stroke: 1pt + accent.transparentize(50%),
      inset: 1em,
      radius: 6pt,
      width: 100%,
      height: 100%,
    )[
      #set align(center + horizon)
      #text(fill: accent, weight: "bold", font: "JetBrains Mono", size: 13pt)[#title]
      #v(0.3em)
      #text(fill: text-body, size: 12pt)[#description]
      #if note != none {
        v(0.2em)
        text(fill: text-muted, size: 11pt)[#note]
      }
    ]
  )
}

// LLM power card with icon
#let power-card(icon-name, label, accent: accent-teal, height: auto) = {
  box(
    height: height,
    width: 100%,
    block(
      fill: accent.transparentize(90%),
      stroke: 1pt + accent.transparentize(50%),
      inset: 1em,
      radius: 6pt,
      width: 100%,
      height: 100%,
    )[
      #align(center + horizon)[
        #stack(
          dir: ttb,
          spacing: 1em,
          text(fill: accent, size: 36pt)[#nf-icon(icon-name)],
          text(fill: text-body, weight: "bold", size: 14pt)[#label],
        )
      ]
    ]
  )
}

// Speaker indicator
#let speaker(..names) = {
  place(bottom + left)[
    #block(
      fill: accent-teal.transparentize(85%),
      stroke: 1.5pt + accent-teal,
      inset: (x: 10pt, y: 6pt),
      radius: 6pt,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[
        #names.pos().join(" & ")
      ]
    ]
  ]
}

// Demo/action indicator (positioned next to speaker)
#let demo(label) = {
  place(bottom + left, dx: 140pt)[
    #block(
      fill: accent-pink.transparentize(85%),
      stroke: 1.5pt + accent-pink,
      inset: (x: 10pt, y: 6pt),
      radius: 6pt,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 11pt)[Demo: #label]
    ]
  ]
}

// Breadcrumb navigation (top-right, doesn't affect layout)
#let breadcrumb(section, subsection: none) = {
  place(top + right)[
    #text(fill: text-muted, font: "JetBrains Mono", size: 12pt)[
      #section
      #if subsection != none [ > #subsection]
    ]
  ]
}

// =============================================================================
// PRESENTATION CONTENT
// =============================================================================

// -----------------------------------------------------------------------------
// SLIDE 1: Title
// -----------------------------------------------------------------------------
#slide[
  #place(center + horizon)[
    #block(
      clip: true,
      radius: 12pt,
      width: 100%,
      height: 85%,
    )[
      #box(
        width: 100%,
        height: 100%,
      )[
        #image("Assets/Vibe-Coding Conference Big Stage.png", width: 100%, height: 100%, fit: "cover")
      ]
      #place(bottom)[
        #block(
          fill: gradient.linear(accent-purple, accent-teal, angle: 90deg),
          width: 100%,
          inset: (x: 1em, y: 0.6em),
        )[
          #set align(center)
          #text(
            font: "JetBrains Mono",
            size: 36pt,
            weight: "bold",
            fill: bg-dark,
          )[Vibe Coding]
          #h(1em)
          #text(fill: bg-dark.lighten(20%), size: 16pt)[Kilian & Leo]
        ]
      ]
    ]
  ]
]

// -----------------------------------------------------------------------------
// SLIDE 2: The Origin - Karpathy Quote
// -----------------------------------------------------------------------------
#slide[
  #speaker("Leopold")
  #breadcrumb("Intro")

  #grid(
    columns: (auto, 1fr),
    column-gutter: 1.5em,
    align: horizon,
    box(
      clip: true,
      radius: 50%,
      image("Assets/karpathy.jpg", width: 100pt),
    ),
    block(
      fill: surface,
      stroke: (left: 4pt + accent-purple),
      inset: 1em,
      radius: 8pt,
    )[
      #text(fill: text-body, size: 14pt, style: "italic")[
        "There's a new kind of coding I call 'vibe coding', where you fully give in to the vibes, embrace exponentials, and forget that the code even exists."
      ]
      #v(0.5em)
      #text(fill: text-muted, size: 11pt)[— Andrej Karpathy, February 2025]
      #v(0.2em)
      #text(fill: text-muted.lighten(20%), size: 9pt)[Co-founder of OpenAI, former Director of AI at Tesla]
    ],
  )

  #v(0.8em)

  #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[WHY HE THINKS AGI IS FAR OUT]
  #v(0.3em)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    [
      #text(fill: accent-purple, size: 10pt)[#nf-icon("nf-md-alert_circle")]
      #h(0.3em)
      #text(fill: text-body, size: 11pt)[*Reliability:* Models hallucinate, aren't consistently truthful]
      #v(0.3em)
      #text(fill: accent-purple, size: 10pt)[#nf-icon("nf-md-brain")]
      #h(0.3em)
      #text(fill: text-body, size: 11pt)[*Memory & Agency:* Poor long-term memory, fragile tool use]
    ],
    [
      #text(fill: accent-purple, size: 10pt)[#nf-icon("nf-md-database")]
      #h(0.3em)
      #text(fill: text-body, size: 11pt)[*Data:* High-quality feedback is expensive, a bottleneck]
      #v(0.3em)
      #text(fill: accent-purple, size: 10pt)[#nf-icon("nf-md-shield_check")]
      #h(0.3em)
      #text(fill: text-body, size: 11pt)[*Evaluation:* Hard to measure real understanding & safety]
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 3: Vibe Coding Definition
// -----------------------------------------------------------------------------
#content-slide("What is Vibe Coding?", speaker-name: "Leopold")[
  #breadcrumb("Intro")
  #set align(center)

  #block(
    fill: surface,
    inset: 0.8em,
    radius: 8pt,
    width: 90%,
  )[
    #text(fill: text-body, size: 16pt, style: "italic")[
      "Generating content by describing what you want in natural language and letting LLMs do the heavy lifting of generation."
    ]
  ]

  #v(0.5em)
  #set align(left)

  #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[TYPES OF CONTENT WE CAN GENERATE]
  #v(0.2em)

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    rows: (2.8cm,),
    column-gutter: 0.8em,
    power-card("nf-md-code_braces", "Code", accent: accent-teal, height: 100%),
    power-card("nf-md-text", "Text", accent: accent-purple, height: 100%),
    power-card("nf-md-image", "Images", accent: accent-pink, height: 100%),
    power-card("nf-md-music", "Audio", accent: accent-teal, height: 100%),
  )
]

// -----------------------------------------------------------------------------
// SLIDE 4: Vibe Code Architecture
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")
  #breadcrumb("Intro")

  #set align(center)
  #v(2em)
  #image("Assets/AI flow.png", height: 80%)

  #place(top + center)[
    #v(0.3em)
    #text(
      font: "JetBrains Mono",
      size: 28pt,
      weight: "bold",
      fill: gradient.linear(accent-purple, accent-teal, angle: 90deg),
    )[Vibe Coding Technical Architecture]
  ]
]

// -----------------------------------------------------------------------------
// SLIDE 5: Vibe Coding Super-Powers
// -----------------------------------------------------------------------------
#slide[
  #speaker("Leopold")
  #breadcrumb("Intro")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[Vibe Coding Super-Powers]
    #h(0.5em)
    #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 16pt)[— Limited by Context]
  ]

  #v(0.6em)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    [
      #image("Assets/Vibe Coder Kim in Action.png", width: 100%)
    ],
    [
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 14pt)[LLMs can assist in generating anything.]
      #v(0.5em)
      
      #cyber-list(
        [*Any image* you can think of],
        [*Any text* you can think of],
        [*Any codebase* you can think of],
        [*Any audio*],
      )

      #v(1em)

      #block(
        fill: accent-purple.transparentize(90%),
        stroke: 1pt + accent-purple.transparentize(50%),
        inset: 1em,
        radius: 8pt,
        width: 100%,
      )[
        #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[THE MAIN LIMITATION]
        #v(0.3em)
        #text(fill: text-body, size: 13pt)[The means of giving the model the right information so that it knows exactly what to do.]
        #v(0.5em)
        #text(fill: text-body, size: 13pt)[This is called the ]
        #underline(
          stroke: 2pt + accent-teal,
          text(
            fill: accent-teal,
            weight: "bold",
            font: "JetBrains Mono",
            size: 18pt,
          )[context]
        )
        #text(fill: text-body, size: 13pt)[, and ]
        #underline(
          stroke: 2pt + accent-pink,
          text(
            fill: accent-pink,
            weight: "bold",
            font: "JetBrains Mono",
            size: 18pt,
          )[context engineering]
        )
        #text(fill: text-body, size: 13pt)[.]
      ]
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 6: Agenda
// -----------------------------------------------------------------------------
#slide[
  #speaker("Leopold")
  #breadcrumb("Intro")

  #place(top + right)[
    #box(
      clip: true,
      radius: 8pt,
      width: 55%,
      height: 90%,
    )[
      #image("Assets/Vibe-Coding Conference Speakers.png", width: 100%, height: 100%, fit: "cover")
    ]
  ]

  #block(width: 42%)[
    #block(
      fill: accent-teal.transparentize(90%),
      inset: (x: 12pt, y: 8pt),
      width: 100%,
    )[#text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[Agenda]]

    #v(0.8em)

    #cyber-numbered(
      [*Pick Your Playground* #linebreak() #text(fill: text-muted, size: 11pt)[The tools and interfaces]],
      [*Vibe Coding 101* #linebreak() #text(fill: text-muted, size: 11pt)[Context is everything]],
      [*How We Use It* #linebreak() #text(fill: text-muted, size: 11pt)[Real-world applications]
        #v(0.3em)
        #h(0.5em) #text(fill: accent-teal, size: 9pt)[▸] #text(fill: text-muted, size: 9pt)[Execution]
        #h(0.5em) #text(fill: accent-purple, size: 9pt)[▸] #text(fill: text-muted, size: 9pt)[Strategy]
      ],
    )
  ]
]

// -----------------------------------------------------------------------------
// SLIDE 7: Pick Your Playground
// -----------------------------------------------------------------------------
#content-slide("1. Pick Your Playground", speaker-name: "Leopold & Kilian", demo-label: "Cursor & Claude")[
  #breadcrumb("1. Playground")
  #text(fill: text-muted, size: 12pt)[Anywhere we have an interface to communicate with an LLM]

  #v(0.3em)

  #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[INTERFACES]
  #v(0.2em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (2.4cm,),
    column-gutter: 0.8em,
    [
      #box(
        height: 100%,
        width: 100%,
        block(
          fill: surface,
          stroke: 1pt + accent-teal.transparentize(50%),
          inset: 0.7em,
          radius: 6pt,
          width: 100%,
          height: 100%,
        )[
          #set align(center + horizon)
          #text(fill: accent-teal, size: 22pt)[#nf-icon("nf-md-microsoft_visual_studio_code")]
          #h(0.3em)
          #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[IDE]
          #v(0.2em)
          #text(fill: text-muted, size: 10pt)[VS Code · Cursor · Antigravity]
        ]
      )
    ],
    [
      #box(
        height: 100%,
        width: 100%,
        block(
          fill: surface,
          stroke: 1pt + accent-purple.transparentize(50%),
          inset: 0.7em,
          radius: 6pt,
          width: 100%,
          height: 100%,
        )[
          #set align(center + horizon)
          #text(fill: accent-purple, size: 22pt)[#nf-icon("nf-md-console")]
          #h(0.3em)
          #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[TERMINAL]
          #v(0.2em)
          #text(fill: text-muted, size: 10pt)[Claude Code · Codex]
        ]
      )
    ],
    [
      #box(
        height: 100%,
        width: 100%,
        block(
          fill: surface,
          stroke: 1pt + accent-pink.transparentize(50%),
          inset: 0.7em,
          radius: 6pt,
          width: 100%,
          height: 100%,
        )[
          #set align(center + horizon)
          #text(fill: accent-pink, size: 22pt)[#nf-icon("nf-md-web")]
          #h(0.3em)
          #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[WEB / MOBILE]
          #v(0.2em)
          #text(fill: text-muted, size: 10pt)[ChatGPT · Claude · API Wrappers]
        ]
      )
    ],
  )

  #v(0.4em)

  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 11pt)[SPECIAL POWERS]
  #v(0.2em)
  #text(fill: text-muted, size: 10pt)[Features that interfaces can provide]
  #v(0.2em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (2.4cm,),
    column-gutter: 0.8em,
    [
      #box(
        height: 100%,
        width: 100%,
        block(
          fill: surface,
          stroke: 1pt + accent-teal.transparentize(50%),
          inset: 0.7em,
          radius: 6pt,
          width: 100%,
          height: 100%,
        )[
          #set align(center + horizon)
          #text(fill: accent-teal, size: 22pt)[#nf-icon("nf-md-eye")]
          #h(0.3em)
          #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[Multimodal]
          #v(0.2em)
          #text(fill: text-muted, size: 10pt)[Text + Images + Audio]
        ]
      )
    ],
    [
      #box(
        height: 100%,
        width: 100%,
        block(
          fill: surface,
          stroke: 1pt + accent-purple.transparentize(50%),
          inset: 0.7em,
          radius: 6pt,
          width: 100%,
          height: 100%,
        )[
          #set align(center + horizon)
          #text(fill: accent-purple, size: 22pt)[#nf-icon("nf-md-monitor")]
          #h(0.3em)
          #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[Live rendering]
          #v(0.2em)
          #text(fill: text-muted, size: 10pt)[See changes instantly]
        ]
      )
    ],
    [
      #box(
        height: 100%,
        width: 100%,
        block(
          fill: surface,
          stroke: 1pt + accent-pink.transparentize(50%),
          inset: 0.7em,
          radius: 6pt,
          width: 100%,
          height: 100%,
        )[
          #set align(center + horizon)
          #text(fill: accent-pink, size: 22pt)[#nf-icon("nf-md-presentation")]
          #h(0.3em)
          #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[Output visualization]
          #v(0.2em)
          #text(fill: text-muted, size: 10pt)[PowerPoint · Web app · etc.]
        ]
      )
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 8: Vibe Coding 101 - Context is Everything
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #box[#text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[2. Vibe Coding 101]]
    #box[#h(0.5em)#text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 16pt)[— context is everything]]
  ]

  #v(0.3em)

  #grid(
    columns: (1fr, 2fr),
    column-gutter: 1em,
    [
      #grid(
        columns: (1fr,),
        rows: (0.75cm, 0.75cm, 0.75cm, 0.75cm, 0.75cm, 0.75cm),
        row-gutter: 0.15em,
        box(width: 100%, height: 100%, block(fill: accent-teal.transparentize(90%), stroke: 1pt + accent-teal.transparentize(50%), inset: 0.3em, radius: 4pt, width: 100%, height: 100%)[
          #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 9pt)[AGENTS]
        ]),
        box(width: 100%, height: 100%, block(fill: accent-purple.transparentize(90%), stroke: 1pt + accent-purple.transparentize(50%), inset: 0.3em, radius: 4pt, width: 100%, height: 100%)[
          #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 9pt)[MCP]
        ]),
        box(width: 100%, height: 100%, block(fill: accent-pink.transparentize(90%), stroke: 1pt + accent-pink.transparentize(50%), inset: 0.3em, radius: 4pt, width: 100%, height: 100%)[
          #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 9pt)[RULES]
        ]),
        box(width: 100%, height: 100%, block(fill: accent-teal.transparentize(90%), stroke: 1pt + accent-teal.transparentize(50%), inset: 0.3em, radius: 4pt, width: 100%, height: 100%)[
          #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 9pt)[SKILLS]
        ]),
        box(width: 100%, height: 100%, block(fill: accent-purple.transparentize(90%), stroke: 1pt + accent-purple.transparentize(50%), inset: 0.3em, radius: 4pt, width: 100%, height: 100%)[
          #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 9pt)[PLAN MODE]
        ]),
        box(width: 100%, height: 100%, block(fill: accent-pink.transparentize(90%), stroke: 1pt + accent-pink.transparentize(50%), inset: 0.3em, radius: 4pt, width: 100%, height: 100%)[
          #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 9pt)[VOICE]
        ]),
      )
    ],
    [
      #box(
        clip: true,
        radius: 8pt,
        width: 100%,
        height: 11cm,
      )[
        #image("Assets/Context.png", width: 100%, height: 100%, fit: "cover")
      ]
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 9: Agents
// -----------------------------------------------------------------------------
#content-slide("2.1 Agents", speaker-name: "Kilian")[
  #breadcrumb("2. Vibe Coding 101", subsection: "Agents")
  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[CONNECTION + SYSTEM PROMPT]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (3.5cm,),
    column-gutter: 1em,
    card(
      accent: accent-teal,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[Model Connection]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Direct link to an LLM]
      #v(0.2em)
      #text(fill: text-muted, size: 10pt)[Claude, GPT, Gemini, etc.]
    ],
    card(
      accent: accent-purple,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[System Prompt]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Sophisticated instructions defining personality, capabilities, constraints]
    ],
    card(
      accent: accent-pink,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[Autonomy]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Execute multi-step tasks, use tools, make decisions]
    ],
  )

  #v(0.5em)
  #info-box([*Example:* Claude Code agent that reads files, writes code, runs tests, and iterates until complete], type: "tip")

  #v(0.3em)

  #block(
    fill: surface,
    stroke: (left: 4pt + accent-purple),
    inset: 1em,
    radius: 8pt,
    width: 100%,
  )[
    #text(fill: text-body, size: 12pt, style: "italic")["Agents are brilliant, but they miss expertise."]
    #h(1em)
    #text(fill: text-muted, size: 10pt)[— Anthropic]
  ]
]

// -----------------------------------------------------------------------------
// SLIDE 10: Skills
// -----------------------------------------------------------------------------
#content-slide("2.2 Skills", speaker-name: "Leopold")[
  #breadcrumb("2. Vibe Coding 101", subsection: "Skills")
  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[REUSABLE INSTRUCTIONS]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (3.5cm,),
    column-gutter: 1em,
    card(
      accent: accent-teal,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[Predetermined]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Step-by-step guidance for specific tasks]
    ],
    card(
      accent: accent-purple,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[On Demand]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Activated via slash commands or keywords]
    ],
    card(
      accent: accent-pink,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[Domain Expertise]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Encapsulates best practices for a task]
    ],
  )

  #v(0.5em)
  #info-box([*Example:* `/pptx` skill that knows how to structure slides, use proper layouts, and generate PowerPoint files], type: "tip")
]

// -----------------------------------------------------------------------------
// SLIDE 10b: Skills Examples
// -----------------------------------------------------------------------------
#slide[
  #speaker("Leopold")
  #breadcrumb("2. Vibe Coding 101", subsection: "Skills")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[2.2 Skills]
    #h(0.5em)
    #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 16pt)[— Anthropic's Big Bet]
  ]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    [
      #box(radius: 8pt, width: 100%, height: 10cm)[
        #image("Assets/Skills 1.png", width: 100%, height: 100%, fit: "contain")
      ]
    ],
    [
      #box(radius: 8pt, width: 100%, height: 10cm)[
        #image("Assets/Skills 2.png", width: 100%, height: 100%, fit: "contain")
      ]
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 11: MCP (Model Context Protocol)
// -----------------------------------------------------------------------------
#content-slide("2.3 MCP", speaker-name: "Kilian")[
  #breadcrumb("2. Vibe Coding 101", subsection: "MCP")
  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[CONNECT TO EVERYTHING]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (3.5cm,),
    column-gutter: 1em,
    card(
      accent: accent-teal,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[Tool Connections]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Access to external services and APIs]
    ],
    card(
      accent: accent-purple,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[Data Sources]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Databases, file systems, web services]
    ],
    card(
      accent: accent-pink,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[Extended Capabilities]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Give the model "hands" to interact with the world]
    ],
  )

  #v(0.5em)
  #info-box([*Examples:* File system access, GitHub integration, database queries, web search], type: "tip")
]

// -----------------------------------------------------------------------------
// SLIDE 12: Plan Mode
// -----------------------------------------------------------------------------
#content-slide("2.4 Plan Mode", speaker-name: "Leopold")[
  #breadcrumb("2. Vibe Coding 101", subsection: "Plan Mode")
  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[THINK BEFORE YOU ACT]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (3.5cm,),
    column-gutter: 1em,
    card(
      accent: accent-teal,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[To-Do List]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Well-structured breakdown of tasks]
    ],
    card(
      accent: accent-purple,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[Research First]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Explore codebase before making changes]
    ],
    card(
      accent: accent-pink,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[User Approval]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Review plan before execution]
    ],
  )

  #v(0.5em)
  #set align(center)
  #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 14pt)[Understand → Explore → Plan → Approve → Execute]
]

// -----------------------------------------------------------------------------
// SLIDE 13: Rules
// -----------------------------------------------------------------------------
#content-slide("2.5 Rules", speaker-name: "Kilian")[
  #breadcrumb("2. Vibe Coding 101", subsection: "Rules")
  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[BOUNDARIES & GUIDELINES]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (3.5cm,),
    column-gutter: 1em,
    card(
      accent: accent-teal,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[Boundaries]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[What the model should NOT do]
    ],
    card(
      accent: accent-purple,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[Conventions]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Coding style, naming, patterns to follow]
    ],
    card(
      accent: accent-pink,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[Context]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Project-specific knowledge]
    ],
  )

  #v(0.5em)
  #info-box([*Examples:* `.cursorrules`, `CLAUDE.md`, system prompts with constraints], type: "tip")
]

// -----------------------------------------------------------------------------
// SLIDE 14: Voice
// -----------------------------------------------------------------------------
#content-slide("2.6 Voice", speaker-name: "Leopold")[
  #breadcrumb("2. Vibe Coding 101", subsection: "Voice")
  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[NATURAL EXPRESSION]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (3.5cm,),
    column-gutter: 1em,
    card(
      accent: accent-teal,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 12pt)[Richness]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Tone, emphasis, pauses convey meaning]
    ],
    card(
      accent: accent-purple,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 12pt)[Speed]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Faster than typing, more natural flow]
    ],
    card(
      accent: accent-pink,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 12pt)[Nuance]
      #v(0.3em)
      #text(fill: text-body, size: 11pt)[Models appreciate the expressiveness]
    ],
  )

  #v(0.5em)
  #info-box([*Karpathy's approach:* SuperWhisper for voice input, barely touching the keyboard], type: "tip")
]

// -----------------------------------------------------------------------------
// SLIDE 15: How Does Vibe Coding Create Value?
// -----------------------------------------------------------------------------
#section-slide("3. How We Use It", icon: "nf-md-rocket_launch", subtitle: "Real-world applications", speaker-name: "Kilian & Leopold")

// -----------------------------------------------------------------------------
// SLIDE 16: Value Creation Overview
// -----------------------------------------------------------------------------
#content-slide("Value Creation", speaker-name: "Kilian & Leopold")[
  #breadcrumb("3. How We Use It")
  #v(1em)

  #grid(
    columns: (1fr, 1fr),
    rows: (6cm,),
    column-gutter: 3em,
    box(
      height: 100%,
      width: 100%,
      block(
        fill: accent-teal,
        inset: 1.5em,
        radius: 12pt,
        width: 100%,
        height: 100%,
      )[
        #set align(center + horizon)
        #text(fill: bg-dark, size: 32pt)[#nf-icon("nf-md-cog")]
        #v(0.5em)
        #text(fill: bg-dark, weight: "bold", font: "JetBrains Mono", size: 20pt)[EXECUTION]
      ]
    ),
    box(
      height: 100%,
      width: 100%,
      block(
        fill: accent-purple,
        inset: 1.5em,
        radius: 12pt,
        width: 100%,
        height: 100%,
      )[
        #set align(center + horizon)
        #text(fill: bg-dark, size: 32pt)[#nf-icon("nf-md-brain")]
        #v(0.5em)
        #text(fill: bg-dark, weight: "bold", font: "JetBrains Mono", size: 20pt)[STRATEGY]
      ]
    ),
  )
]

// -----------------------------------------------------------------------------
// SLIDE 17: EXECUTION Section Divider
// -----------------------------------------------------------------------------
#section-slide("3.1 Execution", icon: "nf-md-cog", speaker-name: "Kilian")

// -----------------------------------------------------------------------------
// SLIDE 18: Ping Pong Development
// -----------------------------------------------------------------------------
#content-slide("3.1.1 Ping Pong Development", speaker-name: "Kilian")[
  #breadcrumb("3.1 Execution", subsection: "Ping Pong")
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    [
      #cyber-list(
        [*Product Requirements / PO* #linebreak() #text(fill: text-muted, size: 12pt)[Clear specs from stakeholders]],
        [*Environment Setup* #linebreak() #text(fill: text-muted, size: 12pt)[Cursor rules & configuration]],
        [*Test Driven Development* #linebreak() #text(fill: text-muted, size: 12pt)[Tests first, code second]],
      )
    ],
    [
      #cyber-list(
        [*Code Review* #linebreak() #text(fill: text-muted, size: 12pt)[AI-assisted quality checks]],
        [*Parallel Agents* #linebreak() #text(fill: text-muted, size: 12pt)[Multiple agents in Cursor]],
      )

      #v(1em)
      #info-box([Iterative back-and-forth between human intent and AI implementation], type: "tip")
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 19: Ping Pong: Het Doel
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")
  #breadcrumb("3.1 Execution", subsection: "Het Doel")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[3.1.2 Ping Pong: Het Doel]
  ]

  #v(0.5em)

  #block(
    fill: surface,
    stroke: (left: 4pt + accent-purple),
    inset: 1em,
    radius: 8pt,
    width: 100%,
  )[
    #text(fill: text-body, size: 16pt, style: "italic")["Je wordt een manager, niet een typist."]
  ]

  #v(0.8em)

  // Flow diagram
  #set align(center)
  #grid(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    column-gutter: 0.5em,
    align: horizon,
    block(
      fill: accent-teal.transparentize(80%),
      stroke: 1pt + accent-teal,
      inset: 0.8em,
      radius: 6pt,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[Jij: Geef opdracht]
    ],
    text(fill: accent-teal, size: 16pt)[→],
    block(
      fill: accent-purple.transparentize(80%),
      stroke: 1pt + accent-purple,
      inset: 0.8em,
      radius: 6pt,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 11pt)[AI: Codeert]
    ],
    text(fill: accent-purple, size: 16pt)[→],
    block(
      fill: accent-purple.transparentize(80%),
      stroke: 1pt + accent-purple,
      inset: 0.8em,
      radius: 6pt,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 11pt)[AI: Lint/Test]
    ],
    text(fill: accent-pink, size: 16pt)[→],
    block(
      fill: accent-pink.transparentize(80%),
      stroke: 1pt + accent-pink,
      inset: 0.8em,
      radius: 6pt,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 11pt)[Jij: Review]
    ],
  )
  #set align(left)

  #v(0.8em)

  #cyber-list(
    [*Vibe coding* = van executor naar PO/reviewer rol],
    [*Coding* is input → output → hoe ze linken. Tests dekken de business requirement.],
    [*Explainability is control* — je moet kunnen uitleggen wat de AI gaat doen],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 20: Ping Pong: De Beperking
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")
  #breadcrumb("3.1 Execution", subsection: "De Beperking")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[3.1.3 Ping Pong: De Beperking]
  ]

  #v(0.5em)

  #block(
    fill: surface,
    stroke: (left: 4pt + accent-pink),
    inset: 1em,
    radius: 8pt,
    width: 100%,
  )[
    #text(fill: text-body, size: 16pt, style: "italic")["De AI is een runaway train. Jij bedient de remmen."]
  ]

  #v(0.8em)

  #cyber-list(
    [*LLMs mimic, they don't understand logic* — ze herkennen patronen, geen echte logica],
    [*LLMs will puke code if you let them* — zonder controle krijg je een chaos],
    [*Keep your foot on the brake* — Accept / Commit / Revert],
    [*Houd gesprekken gefocust* — start nieuwe chat bij nieuw onderwerp],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 21: Ping Pong: De Setup
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")
  #breadcrumb("3.1 Execution", subsection: "De Setup")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[3.1.4 Ping Pong: De Setup]
  ]

  #v(0.3em)

  #block(
    fill: surface,
    stroke: (left: 4pt + accent-purple),
    inset: 0.8em,
    radius: 8pt,
    width: 100%,
  )[
    #text(fill: text-body, size: 14pt, style: "italic")["Je setup bepaalt of de AI kan slagen."]
  ]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    [
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[BENEFITS]
      #v(0.3em)
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.4em,
        row-gutter: 0.25em,
        text(fill: accent-teal, size: 10pt)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 11pt)[*UV* — één config file → alles consistent],
        text(fill: accent-teal, size: 10pt)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 11pt)[*Linters* — AI krijgt directe feedback op fouten],
        text(fill: accent-teal, size: 10pt)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 11pt)[*Cursor Rules* — shortcuts → AI weet hoe te testen],
        text(fill: accent-teal, size: 10pt)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 11pt)[*.env files* — local vs live switching],
        text(fill: accent-teal, size: 10pt)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 11pt)[*Extensions* — alles binnen Cursor],
      )
    ],
    [
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 11pt)[TOOLS]
      #v(0.3em)
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.4em,
        row-gutter: 0.25em,
        text(fill: accent-purple, size: 10pt)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 11pt)[*Context7 MCP* — up-to-date docs en best practices],
        text(fill: accent-purple, size: 10pt)[#nf-icon("nf-md-chevron_right")],
        text(fill: text-body, size: 11pt)[*Jira MCP* — requirements lezen],
      )
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 22: Ping Pong: De Principes
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")
  #breadcrumb("3.1 Execution", subsection: "De Principes")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[3.1.5 Ping Pong: De Principes]
  ]

  #v(0.3em)

  #block(
    fill: surface,
    stroke: (left: 4pt + accent-purple),
    inset: 0.8em,
    radius: 8pt,
    width: 100%,
  )[
    #text(fill: text-body, size: 14pt, style: "italic")["Dit is waar je als reviewer op focust."]
  ]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    [
      #cyber-list(
        [*DRY is THE principle* — building blocks, separation of concerns],
        [*Append, don't modify* — nieuwe functies toevoegen, niet bestaande aanpassen],
        [*Scenario-based testing* — niet class-based, direct van requirements naar tests],
      )
    ],
    [
      #cyber-list(
        [*Setup close to real situation* — geen test-only logic in productie code],
        [*Show don't tell* — geef voorbeeld files om te volgen],
        [*Keep what you use, delete the rest*],
      )
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 23: Ping Pong: Review Checklist
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")
  #breadcrumb("3.1 Execution", subsection: "Review Checklist")

  #block(
    fill: accent-teal.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 20pt)[3.1.6 Ping Pong: Review Checklist]
  ]

  #v(0.3em)

  #block(
    fill: surface,
    stroke: (left: 4pt + accent-purple),
    inset: 0.8em,
    radius: 8pt,
    width: 100%,
  )[
    #text(fill: text-body, size: 14pt, style: "italic")["Dit check ik elke keer."]
  ]

  #v(0.6em)

  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.6em,
    row-gutter: 0.5em,
    box(
      fill: accent-teal.transparentize(80%),
      stroke: 1pt + accent-teal,
      inset: 6pt,
      radius: 4pt,
    )[#text(fill: accent-teal, size: 12pt)[#nf-icon("nf-md-checkbox_blank_outline")]],
    text(fill: text-body, size: 13pt)[Heeft hij *NIEUWE* functies toegevoegd of *BESTAANDE* gewijzigd?],

    box(
      fill: accent-purple.transparentize(80%),
      stroke: 1pt + accent-purple,
      inset: 6pt,
      radius: 4pt,
    )[#text(fill: accent-purple, size: 12pt)[#nf-icon("nf-md-checkbox_blank_outline")]],
    text(fill: text-body, size: 13pt)[Vangt hij exceptions in plaats van ze te throwen?],

    box(
      fill: accent-pink.transparentize(80%),
      stroke: 1pt + accent-pink,
      inset: 6pt,
      radius: 4pt,
    )[#text(fill: accent-pink, size: 12pt)[#nf-icon("nf-md-checkbox_blank_outline")]],
    text(fill: text-body, size: 13pt)[Zit er test-only logic in productie code?],

    box(
      fill: accent-teal.transparentize(80%),
      stroke: 1pt + accent-teal,
      inset: 6pt,
      radius: 4pt,
    )[#text(fill: accent-teal, size: 12pt)[#nf-icon("nf-md-checkbox_blank_outline")]],
    text(fill: text-body, size: 13pt)[Doet één functie te veel?],

    box(
      fill: accent-purple.transparentize(80%),
      stroke: 1pt + accent-purple,
      inset: 6pt,
      radius: 4pt,
    )[#text(fill: accent-purple, size: 12pt)[#nf-icon("nf-md-checkbox_blank_outline")]],
    text(fill: text-body, size: 13pt)[Kan ik het pad E2E uitleggen?],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 24: DEMO - Ping Pong Live
// -----------------------------------------------------------------------------
#slide[
  #speaker("Kilian")
  #demo("Ping Pong Live")
  #breadcrumb("3.1 Execution", subsection: "Demo")

  #block(
    fill: accent-pink.transparentize(90%),
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 20pt)[DEMO: Ping Pong Live]
  ]

  #v(0.3em)

  #grid(
    columns: (1.4fr, 1fr),
    column-gutter: 1em,
    [
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 10pt)[DE FLOW]
      #v(0.2em)
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.4em,
        row-gutter: 0.15em,
        text(fill: accent-teal, weight: "bold", size: 9pt)[1.],
        text(fill: text-body, size: 9pt)[*Jira MCP* → story + requirements lezen],
        text(fill: accent-teal, weight: "bold", size: 9pt)[2.],
        text(fill: text-body, size: 9pt)[*Context geven* → tests, code/services, voorbeelden],
        text(fill: accent-teal, weight: "bold", size: 9pt)[3.],
        text(fill: text-body, size: 9pt)[*Extra info* → API docs, etc.],
        text(fill: accent-teal, weight: "bold", size: 9pt)[4.],
        text(fill: text-body, size: 9pt)[*Context7 MCP* → best practices (als nodig)],
        text(fill: accent-teal, weight: "bold", size: 9pt)[5.],
        text(fill: text-body, size: 9pt)[*Test scenario* → "Hoe toon ik dat dit werkt?"],
        text(fill: accent-purple, weight: "bold", size: 9pt)[6.],
        text(fill: text-body, size: 9pt)[*Vraag implementatie* → `uv run pytest`],
        text(fill: accent-purple, weight: "bold", size: 9pt)[7.],
        text(fill: text-body, size: 9pt)[*AI werkt* → code → lint → fix → test → groen ✓],
        text(fill: accent-pink, weight: "bold", size: 9pt)[8.],
        text(fill: text-body, size: 9pt)[*Review* → checklist doorlopen],
        text(fill: accent-pink, weight: "bold", size: 9pt)[9.],
        text(fill: text-body, size: 9pt)[*Commit* → met duidelijke message],
        text(fill: accent-pink, weight: "bold", size: 9pt)[10.],
        text(fill: text-body, size: 9pt)[*Deploy* → .env switch naar live],
      )
    ],
    [
      #v(1em)
      #block(
        fill: accent-pink.transparentize(85%),
        stroke: 1pt + accent-pink,
        inset: 0.8em,
        radius: 6pt,
        width: 100%,
      )[
        #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 10pt)[ALS HET MISGAAT]
        #v(0.3em)
        #text(fill: text-body, size: 10pt)[Ga terug in chat history, probeer opnieuw met andere instructies.]
      ]
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 25: STRATEGY Section Divider
// -----------------------------------------------------------------------------
#section-slide("3.2 Strategy", icon: "nf-md-brain", speaker-name: "Leopold & Kilian")

// -----------------------------------------------------------------------------
// SLIDE 26: App Prototyping
// -----------------------------------------------------------------------------
#content-slide("3.2.1 App Prototyping", speaker-name: "Leopold & Kilian", demo-label: "Various Apps")[
  #breadcrumb("3.2 Strategy", subsection: "App Prototyping")
  #text(fill: text-muted, size: 14pt)[Quickly create apps that demonstrate specific functionality]

  #v(0.5em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (4.5cm,),
    column-gutter: 1em,
    card(
      accent: accent-teal,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 14pt)[MGX VALUATION AGENT]
      #v(0.4em)
      #text(fill: text-body, size: 12pt)[Calculate valuations]
      #v(0.3em)
      #text(fill: text-muted, size: 11pt)[Built on Claude Agent SDK]
      #v(0.3em)
      #text(fill: text-muted, size: 9pt)[Vite · Electron · SQLite]
    ],
    card(
      accent: accent-purple,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 14pt)[MGX DOCUMENT EXTRACTION]
      #v(0.4em)
      #text(fill: text-body, size: 12pt)[Data extraction from docs]
      #v(0.3em)
      #text(fill: text-muted, size: 11pt)[With Landing.ai]
      #v(0.3em)
      #text(fill: text-muted, size: 9pt)[Vite · Electron · SQLite]
    ],
    card(
      accent: accent-pink,
      height: 100%,
      centered: false,
    )[
      #text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 14pt)[KROEGEN APP]
      #v(0.4em)
      #text(fill: text-body, size: 12pt)[Case study example]
      #v(0.3em)
      #text(fill: text-muted, size: 11pt)[Rapid prototype to validate concept]
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 27: Productivity
// -----------------------------------------------------------------------------
#content-slide("3.2.2 Productivity", speaker-name: "Kilian", demo-label: "Obsidian")[
  #breadcrumb("3.2 Strategy", subsection: "Productivity")
  #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 14pt)[KNOWLEDGE MANAGEMENT]

  #v(0.5em)

  #grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    row-gutter: 0.8em,
    box(
      fill: accent-teal.transparentize(80%),
      stroke: 1pt + accent-teal,
      inset: (x: 8pt, y: 4pt),
      radius: 4pt,
    )[#text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 11pt)[1]],
    text(fill: text-body, size: 14pt)[Business provides requirements #sym.arrow document them automatically],

    box(
      fill: accent-purple.transparentize(80%),
      stroke: 1pt + accent-purple,
      inset: (x: 8pt, y: 4pt),
      radius: 4pt,
    )[#text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 11pt)[2]],
    text(fill: text-body, size: 14pt)[During meetings: check comments against codebase or emails],

    box(
      fill: accent-pink.transparentize(80%),
      stroke: 1pt + accent-pink,
      inset: (x: 8pt, y: 4pt),
      radius: 4pt,
    )[#text(fill: accent-pink, weight: "bold", font: "JetBrains Mono", size: 11pt)[3]],
    text(fill: text-body, size: 14pt)[Personal assistant for future reference],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 28: Report Generation
// -----------------------------------------------------------------------------
#content-slide("3.2.3 Report Generation", speaker-name: "Leopold")[
  #breadcrumb("3.2 Strategy", subsection: "Report Generation")
  #grid(
    columns: (1fr, 1fr),
    rows: (5cm,),
    column-gutter: 2em,
    card(
      accent: accent-teal,
      height: 100%,
    )[
      #text(fill: accent-teal, size: 28pt)[#nf-icon("nf-md-file_document")]
      #v(0.3em)
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 14pt)[TYPST]
      #v(0.3em)
      #text(fill: text-body, size: 12pt)[Professional document generation]
      #v(0.2em)
      #text(fill: text-muted, size: 11pt)[Automated reports & presentations]
    ],
    card(
      accent: accent-purple,
      height: 100%,
    )[
      #text(fill: accent-purple, size: 28pt)[#nf-icon("nf-md-chart_bar")]
      #v(0.3em)
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 14pt)[INFOGRAPHICS]
      #v(0.3em)
      #text(fill: text-body, size: 12pt)[Nana Banana example]
      #v(0.2em)
      #text(fill: text-muted, size: 11pt)[Visual data storytelling]
    ],
  )

  #v(0.6em)

  #info-box([AI-generated documents maintain consistent branding and quality at scale], type: "info")
]
