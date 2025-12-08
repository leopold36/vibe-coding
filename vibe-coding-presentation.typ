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
#let section-slide(title, icon: none, subtitle: none) = {
  slide[
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
#let content-slide(title, body) = {
  slide[
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
  #set align(center + horizon)
  #grid(
    columns: (auto, 1fr),
    column-gutter: 2em,
    align: horizon,
    box(
      clip: true,
      radius: 50%,
      image("Assets/karpathy.jpg", width: 120pt),
    ),
    block(
      fill: surface,
      stroke: (left: 4pt + accent-purple),
      inset: 1.5em,
      radius: 8pt,
    )[
      #text(fill: text-body, size: 16pt, style: "italic")[
        "There's a new kind of coding I call 'vibe coding', where you fully give in to the vibes, embrace exponentials, and forget that the code even exists."
      ]
      #v(0.8em)
      #text(fill: text-muted, size: 12pt)[— Andrej Karpathy, February 2025]
      #v(0.3em)
      #text(fill: text-muted.lighten(20%), size: 10pt)[Co-founder of OpenAI, former Director of AI at Tesla]
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 3: Vibe Coding Definition
// -----------------------------------------------------------------------------
#content-slide("What is Vibe Coding?")[
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
  #set align(center + horizon)
  #image("Assets/Vibe code architecture.png", height: 90%)
]

// -----------------------------------------------------------------------------
// SLIDE 5: Vibe Coding Super-Powers
// -----------------------------------------------------------------------------
#content-slide("Vibe Coding Super-Powers")[
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
        #h(0.5em) #text(fill: accent-teal, size: 9pt)[▸] #text(fill: text-muted, size: 9pt)[Prototyping]
        #h(0.3em) #text(fill: accent-purple, size: 9pt)[▸] #text(fill: text-muted, size: 9pt)[Production]
        #h(0.3em) #text(fill: accent-pink, size: 9pt)[▸] #text(fill: text-muted, size: 9pt)[Productivity]
      ],
    )
  ]
]

// -----------------------------------------------------------------------------
// SLIDE 7: Pick Your Playground
// -----------------------------------------------------------------------------
#content-slide("1. Pick Your Playground")[
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
#content-slide("2. Vibe Coding 101")[
  #set align(center)
  #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 14pt)[CONTEXT IS EVERYTHING]
  #set align(left)

  #v(0.4em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (2.5cm, 2.5cm),
    column-gutter: 0.8em,
    row-gutter: 0.6em,
    concept-card("AGENTS", "Autonomous AI workers", accent: accent-teal, height: 100%),
    concept-card("MCP", "Model Context Protocol", accent: accent-purple, height: 100%),
    concept-card("RULES", "Behavioral guidelines", accent: accent-pink, height: 100%),
    concept-card("SKILLS", "Reusable capabilities", accent: accent-teal, height: 100%),
    concept-card("PLAN MODE", "Strategic thinking", accent: accent-purple, height: 100%),
    concept-card("VOICE", "Conversational interface", accent: accent-pink, height: 100%),
  )
]

// -----------------------------------------------------------------------------
// SLIDE 9: Agents
// -----------------------------------------------------------------------------
#content-slide("2.1 Agents")[
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
]

// -----------------------------------------------------------------------------
// SLIDE 10: Skills
// -----------------------------------------------------------------------------
#content-slide("2.2 Skills")[
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
// SLIDE 11: MCP (Model Context Protocol)
// -----------------------------------------------------------------------------
#content-slide("2.3 MCP")[
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
#content-slide("2.4 Plan Mode")[
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
#content-slide("2.5 Rules")[
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
#content-slide("2.6 Voice")[
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
#section-slide("3. How We Use It", icon: "nf-md-rocket_launch", subtitle: "Real-world applications")

// -----------------------------------------------------------------------------
// SLIDE 10: Value Creation Overview
// -----------------------------------------------------------------------------
#content-slide("Value Creation")[
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
        #v(0.3em)
        #text(fill: bg-dark.lighten(20%), size: 14pt)[Kilian]
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
        #v(0.3em)
        #text(fill: bg-dark.lighten(20%), size: 14pt)[Leo]
      ]
    ),
  )
]

// -----------------------------------------------------------------------------
// SLIDE 11: EXECUTION Section Divider
// -----------------------------------------------------------------------------
#section-slide("3.1 Execution", icon: "nf-md-cog")

// -----------------------------------------------------------------------------
// SLIDE 12: Ping Pong Development
// -----------------------------------------------------------------------------
#content-slide("3.1.1 Ping Pong Development")[
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
// SLIDE 13: STRATEGY Section Divider
// -----------------------------------------------------------------------------
#section-slide("3.2 Strategy", icon: "nf-md-brain")

// -----------------------------------------------------------------------------
// SLIDE 14: App Prototyping
// -----------------------------------------------------------------------------
#content-slide("3.2.1 App Prototyping")[
  #text(fill: text-muted, size: 14pt)[Quickly create apps that demonstrate specific functionality]

  #v(0.8em)

  #grid(
    columns: (1fr, 1fr),
    rows: (5cm,),
    column-gutter: 2em,
    card(
      accent: accent-teal,
      height: 100%,
    )[
      #text(fill: accent-teal, weight: "bold", font: "JetBrains Mono", size: 18pt)[KROEGEN APP]
      #v(0.6em)
      #text(fill: text-body, size: 14pt)[Case study example]
      #v(0.4em)
      #text(fill: text-muted, size: 12pt)[Rapid prototype to validate concept]
    ],
    card(
      accent: accent-purple,
      height: 100%,
    )[
      #text(fill: accent-purple, weight: "bold", font: "JetBrains Mono", size: 18pt)[MGX LIVE DEMO]
      #v(0.6em)
      #text(fill: text-body, size: 14pt)[Real-time demonstration]
      #v(0.6em)
      #badge("LIVE")
    ],
  )
]

// -----------------------------------------------------------------------------
// SLIDE 15: Productivity
// -----------------------------------------------------------------------------
#content-slide("3.2.2 Productivity")[
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
// SLIDE 16: Report Generation
// -----------------------------------------------------------------------------
#content-slide("3.2.3 Report Generation")[
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
