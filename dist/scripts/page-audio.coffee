# Page Audio
# Loads and plays audio corresponding to the current page whenever the page changes.
# Exposes an API for enabling/disabling/toggling audio, and being notified of changer.
# Audio is disabled by default.
# None of this works in IE, or iOS / Android

unless (window.AudioContext? or window.webkitAudioContext?)
  console.log "No WebAudio support — skipping page-audio"

else
  Take ["PageScrollWatcher"], (PageScrollWatcher)->
    audioEnabled = false
    updateCallbacks = []
    currentPageName = null
    requestPending = false
    context = null
    source = null
    request = new XMLHttpRequest()
    
    
    Make "PageAudio", PageAudio =
      
      onUpdate: (callback)->
        updateCallbacks.push(callback)
      
      isEnabled: ()->
        return audioEnabled
      
      toggle: ()->
        if audioEnabled then PageAudio.disable() else PageAudio.enable()
      
      enable: ()->
        unless audioEnabled
          audioEnabled = true
          context ?= new (window.AudioContext or window.webkitAudioContext)()
          loadAudioForCurrentPage()
          update()
      
      disable: ()->
        if requestPending
          request.abort()
          requestPending = false
        if audioEnabled
          audioEnabled = false
          stopAudio()
          update()
    
    
    PageScrollWatcher.onPageChange ()->
      currentPage = PageScrollWatcher.getCurrentPage()
      currentPageName = currentPage.id
      loadAudioForCurrentPage()
    
    
    loadAudioForCurrentPage = ()->
      if currentPageName? and audioEnabled
        request.abort() if requestPending
        request.open("GET", "audio/#{currentPageName}.mp3", true)
        request.responseType = "arraybuffer" # Must set this AFTER opening the request, or FF breaks
        requestPending = true
        request.send()
    
    
    setBuffer = (buffer)->
      stopAudio()
      source = context.createBufferSource()
      source.connect context.destination
      source.buffer = buffer
      source.start 0
    
    
    stopAudio = ()->
      try source.stop 0 if source?
    
    
    update = ()->
      callback() for callback in updateCallbacks


# EVENT HANDLERS

    loadSuccess = (e)->
      requestPending = false
      if request.status is 200
        context.decodeAudioData request.response, setBuffer, decodeFailure
      else
        loadStatusIsSuspect(request.status, e)

    
    loadError = (e)->
      console.log "PageAudio: XMLHttpRequest load error", e
      requestPending = false
      PageAudio.disable()


    loadAborted = (e)->
      console.log "PageAudio: XMLHttpRequest load aborted", e
      requestPending = false
      PageAudio.disable()


    loadStatusIsSuspect = (status, e)->
      console.log "PageAudio load may have failed, status: #{status}", e
      PageAudio.disable()
    
    
    decodeFailure = (e)->
      console.log "PageAudio: Error decoding audio data", e
      PageAudio.disable()

    
# POPUPS
    
    Take "ModalPopup", (ModalPopup)->
      # Wrap loadStatusIsSuspect so that it shows a popup if we can't find audio for the current page.
      originalLoadStatus = loadStatusIsSuspect
      loadStatusIsSuspect = (status, e)->
        originalLoadStatus(status, e)
        if status is 404
          # We are assuming that if any page doesn't have voice-over, that the whole module doesn't have it.
          ModalPopup.open("Sorry", "This module does not include voice-over narration.")
      

# SETUP
    
    request.addEventListener("load", loadSuccess)
    request.addEventListener("error", loadError)
    request.addEventListener("abort", loadAborted)
    
