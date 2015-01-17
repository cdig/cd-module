# Compatability:
#	pageYOffset is an IE-compatable version of scrollY

do ()->
  EVENTS =
    scroll: "scroll"
  
  pageChangeListeners = []
  prevPageIndex = null
  prevPage = null
  
  
  Take "Pages", (pages)->
    setupScrollWatching(pages)
    
    Make "PageScrollWatcher",
      getCurrentPage: ()->
        return prevPage
      
      getCurrentPageIndex: ()->
        return prevPageIndex
        
      onPageChange: (listener)->
        pageChangeListeners.push(listener)
        listener(prevPage, prevPageIndex)
    
    
  setupScrollWatching = (pages)->
    scrollHandlerFn = ()->
      for page, pageIndex in pages
        if pageIsCurrent(page)
          if pageIndex isnt prevPageIndex
            pageChange(page, pageIndex, prevPage, prevPageIndex)
            prevPageIndex = pageIndex
            prevPage = page
          return
    
    window.addEventListener(EVENTS.scroll, scrollHandlerFn)
    setTimeout(scrollHandlerFn)
  
  
  pageIsCurrent = (page)->
    pageTop = page.offsetTop
    pageBottom = page.offsetTop + page.offsetHeight
    scrollPosition = window.pageYOffset + document.body.clientHeight / 2
    return pageTop < scrollPosition and scrollPosition < pageBottom
  
  
  pageChange = (page, pageIndex, previousPage, previousPageIndex)->
    for callback in pageChangeListeners
      callback(page, pageIndex, previousPage, previousPageIndex)
