Take ["PageScrollWatcher"], (PageScrollWatcher)->
  PageScrollWatcher.onPageChange ()->
    currentPage = PageScrollWatcher.getCurrentPage()
    
    for object in document.querySelectorAll "object"
      object.disableSVGA = true
    
    for object in currentPage.querySelectorAll "object"
      object.disableSVGA = false
