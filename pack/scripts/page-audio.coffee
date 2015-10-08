# Page Audio
# Loads and plays audio corresponding to the current page whenever the page changes.
# Exposes an API for enabling/disabling/toggling audio, and being notified of changer.
# Audio is disabled by default.
# Does not work on iOS or android currently

Take ["PageScrollWatcher"], (PageScrollWatcher)->
  audioEnabled = false
  updateCallbacks = []
  currentPageName = null
  audioElement = null
  errorAttempts = 0
  
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
        loadAudioForCurrentPage()
        update()
    
    disable: ()->
      if audioEnabled
        audioEnabled = false
        stopAudio()
        update()  

  updateCurrentPage = ()->
    currentPage = PageScrollWatcher.getCurrentPage()
    currentPageName = currentPage.id
    loadAudioForCurrentPage()

  loadAudioForCurrentPage = ()->
    errorAttempts = 0
    if currentPageName? and audioEnabled
      stopAudio()
      createAudio()
      
  createAudio = ()->
    audioElement = new Audio("audio/#{currentPageName}.mp3")
    audioElement.setAttribute("autoplay", "")
    document.body.appendChild(audioElement)
    initialiseErrorHandling()

  stopAudio = ()->
    if audioElement?
      audioElement.pause()
      document.body.removeChild(audioElement)
      audioElement = null

  update = ()->
    callback() for callback in updateCallbacks

  loadStatusIsSuspect = (status, e)->
    console.log "PageAudio load may have failed, status: #{status}", e
    errorAttempts++
    if errorAttempts > 5
      PageAudio.disable()
    else
      document.body.removeChild(audioElement)
      createAudio()

  initialiseErrorHandling = ()->
    audioElement.addEventListener 'error', (e)->
      status = switch e.target.error.code
        when e.target.error.MEDIA_ERR_ABORTED 
          "Audio playback exited"
        when e.target.error.MEDIA_ERR_NETWORK
          "A network error caused the file played to not be returned."
        when e.target.error.MEDIA_ERR_DECODE
          "The audio playback was aborted due to the file being corrupt or unsupported."
        else
          "The audio file cannot be played. Please make sure the path to the file is correct."
      loadStatusIsSuspect(status, e)
  
  Take "ModalPopup", (ModalPopup)->
    # Wrap loadStatusIsSuspect so that it shows a popup if we can't find audio for the current page.
    originalLoadStatus = loadStatusIsSuspect
    loadStatusIsSuspect = (status, e)->
      originalLoadStatus(status, e)
      if errorAttempts > 5 #check for error attempts before doing a pop up, just in case failure was a simple network issue and would be resolved on another load attempt.
        ModalPopup.open("Sorry", "An error has occurred while loading voice-over narration. Please click the mute button to re-enable audio or reload the module.")      
    
# SETUP
  PageScrollWatcher.onPageChange(updateCurrentPage)
  updateCurrentPage()
    
