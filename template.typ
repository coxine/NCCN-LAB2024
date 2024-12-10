#import "@preview/numblex:0.1.1": numblex, circle_numbers
#import "@preview/indenta:0.0.3": fix-indent

#let font = (
  main: "Noto Serif CJK SC",
  mono: "Fira Code",
  cjk: "Noto Serif CJK SC",
)

#let problem_counter = counter("problem")
#let prob-solution_counter = counter("prob-solution")

#let prob_block(body) = {
  v(-0.5em)
  block(fill: rgb(250, 255, 250), width: 100%, inset: 8pt, radius: 4pt, stroke: rgb(31, 199, 31), body)
}

#let speci_block(title, body) = {
  v(-0.5em)
  block(
    fill: rgb("#1f84c7"),
    width: 100%,
    inset: (left: 8pt, top: 4pt, bottom: 4pt),
    radius: (top: 4pt, bottom: 0pt),
    stroke: rgb("#1f84c7"),
  )[
    #set heading(numbering: none)

    #set text(fill: white)
    #v(0.3em)
    ==== #title
    #v(-0.3em)
  ]
  v(-12pt)
  block(fill: rgb("#fcfdff"), width: 100%, inset: 8pt, radius: (top: 0pt, bottom: 4pt), stroke: rgb("#1f84c7"))[
    // #v(0.5em)
    #body
  ]
}

#let prob(text, body) = {
  [
    #set heading(numbering: none)
    === #text
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    prob_block(body)
  }
}

#let cprob(text, body) = {
  [
    #set heading(numbering: none)
    #problem_counter.step()
    === 问题 #problem_counter.display()：#text
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    prob_block(body)
  }
}

#let cqa(title, body) = {
  [
    #set heading(numbering: none)
    #prob-solution_counter.step()
    === 问题 #prob-solution_counter.display()：#title
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    speci_block([解决方式], body)
  }
}

// Some math operators
#let prox = [#math.op("prox")]
#let proj = [#math.op("proj")]
#let argmin = [#math.arg] + [#math.min]

#let assignment_class(
  size: 10.5pt,
  title,
  author,
  course_id,
  professor_name,
  semester,
  due_time,
  id,
  lang: "zh",
  region: "cn",
  body,
) = {
  set text(font: (font.main, font.cjk), size: size, lang: lang, region: region)

  set heading(numbering: numblex("一、", "1.", "(1)"))

  show heading.where(level: 1): it => {
    if (it.numbering != none) {
      block(counter(heading.where(level: 1)).display("一") + "、" + it.body)
    } else {
      it
    }
  }


  show heading: it => [
    #it
    #v(0.3em)
  ]

  // Very useful trick, special thanks to @AxiomOfChoices
  // https://github.com/typst/typst/issues/2953#issuecomment-1858823455
  show heading: current => locate(loc => {
    let elms = query(selector(heading).before(loc), loc) // Finds all previous headings, inclusive
    if elms.len() > 1 {
      // If there are at least 2
      let previous_heading = elms.at(-2) // Take the previous one
      if (
        // If it is close enough to the current one
        previous_heading.location().position().y + 35pt > current.location().position().y
      ) {
        return [#v(-0.3em) #current]
      }
    }
    return current
  })


  set raw(tab-size: 4)
  show link: it => {
    set text(fill: blue)
    underline(it)
  }

  set list(indent: 6pt)
  set enum(indent: 6pt)
  set enum(numbering: numblex(numberings: ("1.", "a)", circle_numbers)), full: true)

  set bibliography(title: [参考], style: "ieee")

  set document(title: title, author: author)
  set page(
    paper: "a4",
    header: locate(loc => if (counter(page).at(loc).first() == 1) {
      none
    } else {
      [
        #h(1fr)
        *#author* | *#title*
      ]
    }),
    footer: locate(loc => {
      let page_number = counter(page).at(loc).first()
      let total_pages = counter(page).final(loc).last()
      align(center)[
        #set text(size: 8pt)
        #page_number / #total_pages
      ]
    }),
  )

  // Title and Header

  let make_header(name, width: 453.5pt, max: 17pt, step: 0.1pt) = {
    context {
      if max == none {
        max = text.size
      }
      let textsize = max
      let size = measure(align(left, text(textsize)[#name]))
      while size.width > width {
        textsize = textsize - step
        size = measure(align(left, text(textsize)[#name]))
      }
      return align(left, text(textsize)[#name])
    }
  }

  let left_text = [
    *#author* #id
  ]
  let comma = ","
  if lang == "zh" {
    comma = "，"
  }
  let right_text = [*#professor_name*] + [#comma*#semester* ] + [| *日期：*#due_time]

  if due_time == none or due_time == "" {
    right_text = [*#professor_name*] + [#comma*#semester* ]
  }

  line(length: 100%)
  make_header[*#course_id* | *#title*]
  left_text
  h(1fr)
  right_text
  line(length: 100%)

  set raw(tab-size: 4)

  show raw: set text(font: (font.mono, font.cjk))
  // Display inline code in a small box
  // that retains the correct baseline.
  show raw.where(block: false): box.with(fill: luma(240), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)

  let cjk-markers = regex("[“”‘’．，。、？！：；（）｛｝［］〔〕〖〗《》〈〉「」【】『』─—＿·…\u{30FC}]+")
  show cjk-markers: set text(font: font.cjk)
  show raw: it => {
    show cjk-markers: set text(font: font.cjk)
    it
  }

  // Display block code in a larger block
  // with more padding.
  // and with line numbers.
  // Thank you @Andrew15-5 for the idea and the code!
  // https://github.com/typst/typst/issues/344#issuecomment-2041231063
  let style-number(number) = text(gray)[#number]
  show raw.where(block: true): it => block(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[#grid(columns: (1em, 1fr), align: (
        right,
        left,
      ), column-gutter: 0.7em, row-gutter: 0.6em, ..it.lines.enumerate().map(((i, line)) => (
        style-number(i + 1),
        line,
      )).flatten())]


  set par(first-line-indent: 2em)
  show: fix-indent()


  body
}