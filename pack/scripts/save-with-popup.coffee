# Save With Popup
# An asynchronous saving service with a nice UI.
# Call us, and we'll show a popup and attempt to save.
# Don't call us if you need synchronous saves!

Take ["KVStore", "ModalPopup"], (KVStore, ModalPopup)->
  
  saving = false
  savingDoneCallbacks = []
  
  
  runSave = ()->
    success = KVStore.save()
    
    if success
      ModalPopup.close()
    else
      ModalPopup.open("Saving Failed", "Check your internet connection and try again.")
    
    for callback in savingDoneCallbacks
      setTimeout ()-> # Don't call immediately, since they might want to retry saving or something
        callback(success)
    
    savingDoneCallbacks = []
    saving = false
    
  
  Make "SaveWithPopup", (callback)->
    savingDoneCallbacks.push(callback)
    
    if not saving
      saving = true
      ModalPopup.open("Saving", "", false)
      setTimeout(runSave, 500)
