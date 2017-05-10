Take ["Env", "PureDom", "Vector", "DOMContentLoaded"], (Env, PureDom, Vector)->
  
  return unless Env.dev
  return unless document.querySelector("[editable]")?
  
# LOCALS / STATE
  
  editableElements = document.querySelectorAll("[editable]")
  manipulatedElements = {}
  
  mouse =
    pos: null
    last: null
    delta: null

  isShiftDown = false
  isDragging = false
  isResizing = false
  
  dragTarget = null
  targetEditorPos = null
  targetParentSize = null
  
  hoverElm = null
  
  resizeDirectionVec = null
  
  containerShowing = false
  
  
# ELEMENT SETUP
  
  outputField = document.createElement("textarea")
  outputField.setAttribute("placeholder", "Editor Output")
  outputContainer = document.createElement("editor-container")
  outputContainer.className = "selectable glass"
  outputContainer.appendChild(outputField)
  document.body.appendChild(outputContainer)
  
  
# (ALMOST) PURE FUNCTIONS
  
  extractLastClass = (elm)->
    return "." + elm.className.split(" ").pop()
  
  computeCSSRules = ()->
    selectors = Object.keys(manipulatedElements).sort() # Alphabetical by class name
    rules = for selector in selectors
      elm = manipulatedElements[selector]
      left = styleValToNumWithPrecision(elm.style.left, 2)
      marginTop = styleValToNumWithPrecision(elm.style.marginTop, 2)
      width = styleValToNumWithPrecision(elm.style.width, 2)
      toFormattedCSSRule(selector, left, marginTop, width)
    return rules.join("\n")
    
  styleValToNumWithPrecision = (n, p)->
    return parseFloat(n).toFixed(p).replace(/\0+$/, "").replace(/\.$/, "")
  
  toFormattedCSSRule = (selector, left, marginTop, width)->
    s = "#{selector} {\n"
    s += "\tleft: #{left}%;\n" unless isNaN(left)
    s += "\tmargin-top: #{marginTop}%;\n" unless isNaN(marginTop)
    s += "\twidth: #{width}%;\n" unless isNaN(width)
    s += "}\n"
    return s
  
  extractTranslate = (transformString)->
    matches = transformString.match(/matrix\(1, 0, 0, 1, (.+), (.+)\)/)
    if matches.length is 3
      x = parseInt(matches[1])
      y = parseInt(matches[2])
      return Vector.create(x, y)
    else
      return Vector.create()
  
  extractTransform = ()->
    style = window.getComputedStyle(dragTarget)
    webkit = style.getPropertyValue("-webkit-transform")
    standard = style.getPropertyValue("transform")
    return standard or webkit
  
  vecFromBoundingClientPos = (elm)->
    return Vector.fromRectPos(elm.getBoundingClientRect())
  
  vecFromBoundingClientSize = (elm)->
    return Vector.fromRectSize(elm.getBoundingClientRect())
  
  vecFromEventGlobal = (e)->
    return Vector.add(Vector.create(e.clientX, e.clientY), Vector.fromPageOffset())
  
  vecFromElmPosWindow = (elm)->
    return Vector.screenToWindow(vecFromBoundingClientPos(elm))

  vecFromTargetTranslation = (elm)->
    transformString = extractTransform(dragTarget)
    translationVec = extractTranslate(transformString)
    return translationVec
  
  normalizedRectRelativePos = (rectPos, rectSize, vec)->
    relativePos = Vector.subtract(vec, rectPos)
    normalizedPos = Vector.divide(relativePos, rectSize)
    return normalizedPos
  
  normalizedElmRelativePos = (elm, vec)->
    elmRectPos = vecFromElmPosWindow(elm)
    elmRectSize = vecFromBoundingClientSize(elm)
    normalizedMousePos = normalizedRectRelativePos(elmRectPos, elmRectSize, vec)
  
  dot = (p)-> (v)-> v[p]
  
  
# GENERAL MUTATION

  applyPosToElement = (pos, elm)->
    elm.style.left = pos.x + "%"
    elm.style.marginTop = pos.y + "%"
  
  applyScaleToElement = (scale, elm)->
    elm.style.width = scale + "%"
  
  updateField = (value)->
    outputField.value = value
    initializeOutput()
  
  toggleContainer = (enable)->
    console.log containerShowing = if enable? then enable else !containerShowing
    outputContainer.style.display = if containerShowing then "block" else "none"
  
  initializeOutput = ()->
    toggleContainer true
  
# CURSOR MANAGEMENT
  
  updateCursor = ()->
    switch
      when isDragging
        setCursor("drag")
      when hoverElm? and isShiftDown
        setCursor(computeResizeCursor())
      else
        setCursor(null)
  
  
# CURSOR WORK
  
  computeResizeCursor = ()->
    normalizedMousePos = normalizedElmRelativePos(hoverElm, mouse.pos)
    adjustedMousePos = Vector.subtract(Vector.multiply(normalizedMousePos, 2), 1)
    resizeDirectionVec = Vector.map(Math.round, adjustedMousePos)
    resizeIndex = Vector.add(resizeDirectionVec, 1)
    xName = ["l", "c", "r"][resizeIndex.x]
    yName = ["t", "c", "b"][resizeIndex.y]
    return xName + yName
  
  setCursor = (val = "")->
    document.body.setAttribute("editor", val)
  

# DRAG MANAGEMENT
  
  beginDrag = ()->
    isDragging = true
    isResizing = isShiftDown
  
  updateDrag = ()->
    if isResizing
      updateResize()
    else
      updateReposition()
  
  endDrag = ()->
    isDragging = false
    updateField(computeCSSRules())
  
  
# DRAG WORK
  
  updateDragTarget = (mouseTarget)->
    dragTarget = PureDom.querySelectorParent(mouseTarget, "[editable]")
  
  prepareDragTarget = ()->
    targetParentPos = vecFromElmPosWindow(dragTarget.offsetParent)
    targetParentSize = vecFromBoundingClientSize(dragTarget.offsetParent)
    targetEditorPosGlobal = vecFromElmPosWindow(dragTarget)
    targetEditorPos = Vector.subtract(targetEditorPosGlobal, targetParentPos)
    
    # Reverse the effect of any transform translation
    targetEditorPos = Vector.subtract(targetEditorPos, vecFromTargetTranslation())

    # Reverse the contribution of [pin] { top: 50%; }
    targetEditorPos.y -= targetParentSize.y/2
    
    targetName = extractLastClass(dragTarget)
    manipulatedElements[targetName] ?= dragTarget
  
  updateReposition = ()->
    targetEditorPos = Vector.add(targetEditorPos, mouse.delta) # Mutation!!
    percentPos = Vector.normalize(targetEditorPos, targetParentSize.x / 100)
    applyPosToElement(percentPos, dragTarget)
  
  updateResize = ()->
    currentSize = vecFromBoundingClientSize(dragTarget)
    relativeMouseDelta = Vector.divide(mouse.delta, currentSize)
    relativeScaleFactor = Vector.add(relativeMouseDelta, 1)
    newSize = Vector.multiply(currentSize, relativeScaleFactor)
    percentSize = Vector.normalize(newSize, targetParentSize.x / 100)
    applyScaleToElement(percentSize.x, dragTarget)


# EVENT HELPERS
  
  isLeftClick = (e)->
    return e.button is 0
  
  isShiftKey = (e)->
    return e.keyCode is 16
    
  checkForDrop = (e)->
    return isLeftClick(e) and isDragging
  
  updateMousePos = (e)->
    mouse.pos = vecFromEventGlobal(e)
    mouse.delta = Vector.subtract(mouse.pos, mouse.last)
    mouse.last = mouse.pos
  
  updateHoverElm = (e)->
    overElm = document.elementFromPoint(e.clientX, e.clientY)
    if overElm?
      hoverElm = PureDom.querySelectorParent(overElm, "[editable]")
    else
      hoverElm = null

  
# EVENT HANDLING

  downHandler = (e)->
    updateMousePos(e)
    if isLeftClick(e)
      updateDragTarget(e.target)
      if dragTarget?
        beginDrag()
        prepareDragTarget()
        updateDrag()
        e.preventDefault()
    updateCursor()
  
  moveHandler = (e)->
    updateMousePos(e)
    if isDragging
      updateDrag()
      e.preventDefault()
    else
      updateHoverElm(e)
    updateCursor()
  
  upHandler = (e)->
    if checkForDrop(e)
      endDrag()
      e.preventDefault()
    updateCursor()
  
  keyDownHandler = (e)->
    if isShiftKey(e)
      isShiftDown = true
      e.preventDefault()
    updateCursor()
  
  keyUpHandler = (e)->
    if isShiftKey(e)
      isShiftDown = false
      e.preventDefault()
    updateCursor()
  
  
  # EVENT LISTENING
  
  window.addEventListener("mousedown", downHandler)
  window.addEventListener("mousemove", moveHandler)
  window.addEventListener("mouseup", upHandler)
  window.addEventListener("keydown", keyDownHandler)
  window.addEventListener("keyup", keyUpHandler)
  
