# This might be broken. Ivan just hastily converted it to Take/Make. Someone needs to review and test it.

Take "load", ()->
  scrollAreas = []


# SETUP
  
  scrollStarts = document.querySelectorAll('[scrollStart]')
  scrollEnds = document.querySelectorAll('[scrollEnd]')
  
  return unless scrollStarts.length > 0
  
  for scrollStart in scrollStarts
    scrollGroup = scrollStart.getAttribute('scrollStart')
    for scrollEnd in scrollEnds
      scrollEndGroup = scrollEnd.getAttribute('scrollEnd')
      if scrollGroup is scrollEndGroup
        scrollAreas.push
          start: scrollStart
          stop: scrollEnd


# EVENT HANDLERS

  handleScrollAreas = ()->
    scrollTop = document.body.scrollTop
    for scrollArea in scrollAreas
      scrollAreaTop = scrollArea.start.offsetTop
      scrollAreaBottom = scrollArea.stop.offsetTop
      if scrollTop > scrollAreaTop and scrollTop <= scrollAreaBottom
        value = (scrollTop - scrollAreaTop) / (scrollAreaBottom - scrollAreaTop)
        console.log "ScrollRegions: CustomEvent has been disabled because it fails in IE10"
  
  
  handleScrollBody = ()->
    scrollAreaTop = document.body.offsetTop
    scrollAreaBottom = document.body.offsetTop + document.body.scrollHeight - document.body.offsetHeight
    scrollTop = document.body.scrollTop
    value = (scrollTop - scrollAreaTop) / (scrollAreaBottom - scrollAreaTop)
    console.log "ScrollRegions: CustomEvent has been disabled because it fails in IE10"
    
    
# EVENT LISTENERS
  document.body.addEventListener "scroll", handleScrollAreas
  document.body.addEventListener "scroll", handleScrollBody
