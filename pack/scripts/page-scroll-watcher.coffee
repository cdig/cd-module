Take "Pages", (Pages)->
  
  pageChangeCallbacks = []
  prevPageIndex = null
  prevPage = null
  
  
  Make "PageScrollWatcher", PageScrollWatcher =
    getCurrentPage: ()-> prevPage
    getCurrentPageIndex: ()-> prevPageIndex
    onPageChange: (callback)->
      pageChangeCallbacks.push callback
      
      # New in v2: We also run the callback immediately, because we're always on a page.
      setTimeout callback
  
  
  pageIsCurrent = (page)->
    pageTop = page.offsetTop
    pageBottom = page.offsetTop + page.offsetHeight
    top = document.body.scrollTop + document.body.parentNode.scrollTop
    scrollPosition = top + window.innerHeight / 2
    return pageTop < scrollPosition and scrollPosition < pageBottom
  
  
  pageChange = (page, pageIndex, previousPage, previousPageIndex)->
    for callback in pageChangeCallbacks
      callback()
  
  
  scrollHandlerFn = ()->
    for page, pageIndex in Pages
      if pageIsCurrent(page)
        if pageIndex isnt prevPageIndex
          prevPageIndex = pageIndex
          prevPage = page
          pageChange()
        return
  
  
  # INIT
  
  document.addEventListener "scroll", scrollHandlerFn
  scrollHandlerFn()
