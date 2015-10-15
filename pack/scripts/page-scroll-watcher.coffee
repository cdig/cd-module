do ()->
  pageChangeCallbacks = []
  prevPageIndex = null
  prevPage = null
  
  Take "Pages", (pages)->
    setupScrollWatching pages
    Make "PageScrollWatcher", PageScrollWatcher =
      getCurrentPage: ()-> prevPage
      getCurrentPageIndex: ()-> prevPageIndex
      onPageChange: (callback)-> pageChangeCallbacks.push callback
  
  setupScrollWatching = (pages)->
    scrollHandlerFn = ()->
      for page, pageIndex in pages
        if pageIsCurrent(page)
          if pageIndex isnt prevPageIndex
            prevPageIndex = pageIndex
            prevPage = page
            pageChange()
          return
    document.addEventListener "scroll", scrollHandlerFn
    scrollHandlerFn()
  
  pageIsCurrent = (page)->
    pageTop = page.offsetTop
    pageBottom = page.offsetTop + page.offsetHeight
    scrollPosition = document.body.scrollTop + window.innerHeight / 2
    return pageTop < scrollPosition and scrollPosition < pageBottom
  
  pageChange = (page, pageIndex, previousPage, previousPageIndex)->
    for callback in pageChangeCallbacks
      callback()