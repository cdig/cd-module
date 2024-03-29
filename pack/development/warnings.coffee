Take ["Config", "DOMContentLoaded"], (Config)->

  return unless Config "dev"
  warningIndicator = document.querySelector "warning-indicator"

  warn = (message, violations)->
    console.log "Warning: #{message}", violations
    warningIndicator.style.display = "block"

  Make "Warning", warn

  # Existence

  assertNonexistence = (selector, message)->
    violations = document.querySelectorAll selector
    if violations.length > 0
      warn message, violations

  assertNonexistence ".framed > *", "Please use the `framed` class directly on your images, not on container elements."
  assertNonexistence ".inbl", "The inbl class has been removed."
  assertNonexistence ".width-auto", "The width-auto class has been removed. Please set precise widths, or don't set a width at all."
  assertNonexistence ":not(cd-page) > cd-main", "It looks like you're missing a closing tag"
  assertNonexistence "[col=\"1x\"],[col=\"2x\"],[col=\"3x\"],[col=\"4x\"],[col=\"5x\"]", "The col=\"1x\"-style cd-row sizes have been removed. Either delete this col=\"\" attribute to use the default content-based sizing, or specify a col=\"1/2\"-style size."
  assertNonexistence "[fit]", "You no longer need to use the 'fit' attribute."
  assertNonexistence "[onclick]", "Don't use inline JavaScript. Use external CoffeeScript for lightweight interactivity, or SVGA for richer interactivity."
  assertNonexistence "[row=\"1x\"],[row=\"2x\"],[row=\"3x\"],[row=\"4x\"],[row=\"5x\"]", "The row=\"1x\"-style cd-row sizes have been removed. Either delete this row=\"\" attribute to use the default content-based sizing, or specify a row=\"1/2\"-style size."
  assertNonexistence "[type=\"Et Tu, Q?\"] label > :not(input):not(div)", "Don't put any HTML elements directly inside a QnA <label> — wrap them in a div"
  assertNonexistence "[type=\"Et Tu, Q?\"] .answers:not([no-shuffle]) > :not(label)", "If you customize the answers list in a QnA, please disable shuffling."
  assertNonexistence "call-out:not([top]):not([left]):not([right]):not([bottom])", "You must specify either top, left, right, or bottom on your call-out."
  assertNonexistence ":not(cd-activity) > cd-map > :first-child:last-child", "Your cd-map should have more than 1 child, hey?"
  assertNonexistence "cd-page:not([id])", "All cd-pages must have an id"
  assertNonexistence "cd-map [em-width]", "Don't put an em-width on anything inside a cd-map"
  assertNonexistence "cd-row > cd-map", "Don't put cd-map as a direct child of cd-row. Wrap it with a div."
  assertNonexistence "cd-row > img", "Don't put images directly in cd-row — wrap them in a div"
  assertNonexistence "cd-row > object", "Don't put objects directly in cd-row — wrap them in a div"
  assertNonexistence "cd-row > video", "Don't put videos directly in cd-row — wrap them in a div"
  assertNonexistence "cd-row cd-row", "Don't nest cd-rows."
  assertNonexistence "cd-text-bubble > p:first-child:last-child", "If a <p> is the only child of a cd-text-bubble, don't use a <p>"
  assertNonexistence "cd-text-bubble cd-row", "Don't use cd-row inside a cd-text-bubble. If you want to put an image beside your bubble text, float it using the float-left or float-right class."
  assertNonexistence "cd-text-bubble cd-text-bubble", "Don't nest cd-text-bubbles"
  assertNonexistence "center-block cd-row", "Don't put cd-row inside a center-block"
  assertNonexistence "side-scroller[em-width]", "Don't put em-width on side-scroller, put it on the thing inside the side-scroller"
  assertNonexistence "side-scroller > * + *", "side-scroller should have only 1 direct child"
  assertNonexistence "side-scroller center-block", "Don't put a center-block inside a side-scroller, put the side-scroller inside the center-block"
  assertNonexistence "main", "Use cd-main instead of main"
  assertNonexistence "object[height]", "Don't give objects a height."
  assertNonexistence "[x-autosize]", "x-autosize is no longer needed."
  assertNonexistence "object[src]", "You used <object src=\"blah\"> instead of <object data=\"blah\">"
  assertNonexistence "p[pin]", "Don't use <p> tags as your cd-map pinned items. Use <div>."
  assertNonexistence "small-row > :not(div)", "The items in small-row must be divs (or wrapped in divs)."
  assertNonexistence "small-row > [class]", "Don't put any classes on your small-row items."
  assertNonexistence "[content-link]:not(a)", "Don't use the content-link attribute on elements other than <a>."

  # Uniqueness

  assertAttrUnique = (selector, attr, msgFn)->
    vals = {}
    for elm in document.querySelectorAll selector
      val = elm.getAttribute attr
      (vals[val] ?= []).push elm
    for val, elms of vals
      if elms.length > 1
        warn msgFn(val), elms

  assertAttrUnique "cd-activity", "name", (val)-> "You have more than one cd-activity named \"#{val}\". Each activity must have a unique name."
  assertAttrUnique "[id]", "id", (val)-> "You have more than one element with the id \"#{val}\". Each id must be unique."
  assertAttrUnique "object", "data", (val)-> "You have more than one SVGA with the data url \"#{val}\". Please make these data urls unique by adding a #hash, eg: \"#{val}#review\". See the cd-module docs section on SVGA Configuration for more info."

  Make "WarningsDone"
