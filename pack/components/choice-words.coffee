Take ["DOOM", "Shuffle", "DOMContentLoaded"], (DOOM, Shuffle)->

  finishGame = (elm)-> ()->
    for result in elm.querySelectorAll ".result"
      DOOM result, class: "finished"


  change = (elm)-> (e)->
    selects = elm.querySelectorAll "select"
    correctSelects = []
    for select in selects
      if select.value is select._correctAnswer
        correctSelects.push select
    if correctSelects.length >= Math.min selects.length, 3
      for select in correctSelects
        select.replaceWith DOOM.create "span", null,
          textContent: select._correctAnswer
          class: "result"
          minWidth: select.offsetWidth + "px"
      rebuildAnswers elm


  rebuildAnswers = (elm)->
    selects = elm.querySelectorAll "select"
    words = (select._correctAnswer for select in selects)
    if words.length is 0
      return setTimeout finishGame(elm), 1300
    for wrong in elm.querySelectorAll "wrong-answer"
      words.push wrong.textContent
    words = words.sort()
    words = Array.from new Set [].concat words
    words.unshift ""
    words = words.map (w)-> "<option>#{w}</option>"
    maxWidth = 0
    for select in selects
      value = select.value
      DOOM select, innerHTML: words
      select.value = value if value
      maxWidth = Math.max maxWidth, select.offsetWidth
    for select in selects
      DOOM select, minWidth: maxWidth + "px"
    null


  setup = (elm)->
    for select in elm.querySelectorAll "select"
      select._correctAnswer = select.textContent
      select.addEventListener "change", change elm
    for wrong in elm.querySelectorAll "wrong-answer"
      wrong.style.display = "none"
    rebuildAnswers elm


  # INIT
  setup elm for elm in document.querySelectorAll "[type='choice-words']"
