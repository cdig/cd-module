Take ["ChildData", "DOOM", "DOMContentLoaded"], (ChildData, DOOM)->

  bail = ()->
    Make "AdventureMode", false

  pageContainer = document.querySelector "#page"
  module = pageContainer?.querySelector "cd-module"
  adventurePage = module?.querySelector "#adventure"
  return bail() unless adventurePage?

  mains = (main for main in adventurePage.querySelectorAll "cd-main")
  return bail() unless mains.length > 0

  adventureControls = document.querySelector("adventure-controls")
  nextButton = adventureControls.querySelector("[next-page]")
  prevButton = adventureControls.querySelector("[previous-page]")
  progressBar = adventureControls.querySelector("progress-bar")
  progressFill = progressBar.querySelector("[progress-fill]")
  progressText = progressBar.querySelector("[progress-text]")

  currentPage = (window.location.hash.replace("#","") or 1) - 1
  historyDirty = false

  setVisibility = (elm, visible = true)->
    elm.style.display = if visible then "block" else "none"
    for obj in elm.querySelectorAll "object"
      ChildData.send obj, "disabled", !visible

  hideAll = ()->
    setVisibility main, false for main in mains

  updateProgress = ()->
    if mains.length > 1
      progressText.textContent = "#{currentPage+1}"
      barWidth = progressBar.getBoundingClientRect().width
      textWidth = progressText.getBoundingClientRect().width
      fillWidth = barWidth - textWidth
      progressFill.style.width = "#{textWidth + fillWidth * currentPage / (mains.length-1)}px"
    else
      progressBar.style.display = "none"

  requestHistoryUpdate = ()->
    # Safari throws a SecurityError if we update history more than 100 times in 30 seconds,
    # so we throttle history updates to once per second
    return if historyDirty
    historyDirty = true
    setTimeout updateHistory, 1000

  updateHistory = ()->
    if historyDirty
      url = new URL(window.location)
      url.hash = if currentPage is 0 then "" else currentPage+1
      history.replaceState(null, document.title, url)
      historyDirty = false

  goToPage = (n)->
    hideAll()
    currentPage = Math.max 0, Math.min mains.length-1, n
    nextButton.disabled = currentPage is mains.length-1
    prevButton.disabled = currentPage is 0
    setVisibility mains[currentPage]
    updateProgress()
    requestHistoryUpdate()

  nextPage = ()-> goToPage currentPage + 1
  prevPage = ()-> goToPage currentPage - 1

  keydown = (e)->
    switch e.keyCode
      when 39 # Right
        nextPage()
      when 37 # Left
        prevPage()

  resize = ()->
    headerHeight = 48
    controlBounds = adventureControls.getBoundingClientRect()
    w = window.innerWidth
    outerH = window.innerHeight - headerHeight
    controlHeight = controlBounds.height
    h = outerH - controlHeight
    scale = Math.min w/960, h/540
    scaledW = Math.round scale * 960
    scaledH = Math.round scale * 540
    DOOM pageContainer,
      width: "#{scaledW}px"
      height: "#{scaledH + controlHeight}px"
      marginTop: "#{outerH/2 - (scaledH + controlHeight)/2}px"
    DOOM module, height: "#{scaledH}px"
    DOOM object, height: "#{scaledH}px" for object in adventurePage.querySelectorAll "object"
    updateProgress()


  # INIT

  document.body.parentElement.setAttribute "adventure-mode", ""

  nextButton.addEventListener "click", nextPage
  prevButton.addEventListener "click", prevPage
  window.addEventListener "keydown", keydown

  window.addEventListener "resize", resize
  resize()

  goToPage currentPage

  Make "AdventureMode", true
