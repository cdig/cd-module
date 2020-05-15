Take ["DOOM", "Shuffle", "DOMContentLoaded"], (DOOM, Shuffle)->

  finishGame = (elm)->
    for result in elm.querySelectorAll ".result"
      DOOM result, class: "finished"


  change = (elm)-> (e)->
    select = e.currentTarget
    correct = select.value is select._correctAnswer
    if correct
      select.replaceWith DOOM.create "span", null,
        textContent: select._correctAnswer
        class: "result"
        minWidth: select.offsetWidth + "px"
      rebuildAnswers elm


  rebuildAnswers = (elm)->
    selects = elm.querySelectorAll "select"
    words = (select._correctAnswer for select in selects)
    return finishGame elm if words.length is 0
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
    selects = elm.querySelectorAll "select"
    for select in selects
      select._correctAnswer = select.textContent
      select.addEventListener "change", change elm
    rebuildAnswers elm


  # INIT
  setup elm for elm in document.querySelectorAll "[type='choice-words']"
