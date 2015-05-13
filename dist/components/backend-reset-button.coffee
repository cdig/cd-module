Take ["cdHUD", "BackendLocalStorage", "Backend", "KVStore", "Env"], (cdHUD, BLS, Backend, KVStore, Env)->
  
  # Only show the reset button if we're using the LocalStorage backend
  return unless BLS is Backend
  
  # Add the reset button
  reset = document.createElement("backend-reset-button")
  reset.textContent = "Reset"
  
  reset.addEventListener "click", (e)->
    if Env.dev or Env.debug or window.confirm("Do you really want to start over?")
      document.body.scrollTop = 0
      KVStore.save() #need to save the store before we clear it to set the flag for it having unsaved changes to be false. Otherwise, the data will save before the reload happens
      window.localStorage.clear()
      document.location.reload(true)
  
  cdHUD.addElement(reset)
