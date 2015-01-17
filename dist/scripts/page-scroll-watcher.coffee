# Compatability:
#	pageYOffset is an IE-compatable version of scrollY

do ()->
  EVENTS =
    scroll: "scroll"
  
  pageChangeCallbacks = []
  prevPageIndex = null
  prevPage = null
  
  
  Take "Pages", (pages)->
    setupScrollWatching(pages)
    
    Make "PageScrollWatcher",
      getCurrentPage: ()->
        return prevPage
      
      getCurrentPageIndex: ()->
        return prevPageIndex
        
      onPageChange: (callback)->
        pageChangeCallbacks.push(callback)
        setTimeout ()->
          callback(prevPage, prevPageIndex)
    
    
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
    scrollHandlerFn()
  
  
  pageIsCurrent = (page)->
    pageTop = page.offsetTop
    pageBottom = page.offsetTop + page.offsetHeight
    scrollPosition = window.pageYOffset + document.body.clientHeight / 2
    return pageTop < scrollPosition and scrollPosition < pageBottom
  
  
  pageChange = (page, pageIndex, previousPage, previousPageIndex)->
    for callback in pageChangeCallbacks
      callback(page, pageIndex, previousPage, previousPageIndex)
