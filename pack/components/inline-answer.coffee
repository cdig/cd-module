Take ["DOOM", "DOMContentLoaded"], (DOOM)->

  setup = (elm)->
    timeout = null

    type = DOOM(elm, "type") or "number"
    hintText = DOOM elm, "hint"
    unitText = DOOM elm, "unit"
    labelText = DOOM elm, "label"
    answerText = DOOM elm, "answer"

    DOOM elm, answer: null

    if labelText?.length > 0
      top = DOOM.create "div", elm,
        top: ""
        textContent: labelText
    else
      DOOM elm, noLabel: ""

    bottom = DOOM.create "div", elm,
      bottom: ""

    hintElm = DOOM.create "div", bottom,
      hint: ""
      innerHTML: hintText

    unitElm = DOOM.create "div", bottom,
      unit: ""
      innerHTML: unitText

    input = DOOM.create "input", bottom,
      type: "text"

    button = DOOM.create "button", bottom,
      textContent: "Submit"

    resize = ()->
      hintWidth = hintElm.getBoundingClientRect().width
      unitWidth = unitElm.getBoundingClientRect().width
      width = hintWidth + 12 + unitWidth
      DOOM input, width: width + "px"

    reset = ()->
      clearTimeout timeout
      DOOM elm, correct: null, incorrect: null
      DOOM button, textContent: "Submit"

    submit = ()->
      reset()
      v = input.value
      hasInput = v.length > 0
      isCorrect = if type is "number" then +v is +answerText else v is answerText
      if hasInput and isCorrect
        DOOM elm, correct: ""
        DOOM button, textContent: "Correct"
      else
        DOOM elm, incorrect: ""
        DOOM button, textContent: "Not Quite"
        timeout = setTimeout reset, 1500

    update = ()->
      reset()
      l = input.value.length
      hintElm.innerHTML = Array(l+1).join("&nbsp;") + hintText.slice(l)

    keydown = (e)->
      if e.keyCode is 13 # Enter
        e.preventDefault()
        submit()


    input.addEventListener "input", update
    input.addEventListener "change", update
    input.addEventListener "keydown", keydown
    button.addEventListener "click", submit
    window.addEventListener "resize", resize

    resize()


  # INIT

  # To give module scripts a chance to dynamically customize inline-answers,
  # and to avoid a race condition, we delay initialization by one tick to
  # guarantee that the module script has a chance to run before we grab the HTML.
  setTimeout ()->
    setup elm for elm in document.querySelectorAll "inline-answer"
