Take ["cdHUD", "BackendLocalStorage", "Backend"], (cdHUD, BLS, Backend)->
  
  # Only show the reset button if we're using BackendLocalStorage
  if BLS is Backend

    reset = document.createElement("backend-reset-button")
    reset.textContent = "Reset"
    
    reset.addEventListener "click", (e)->
      window.localStorage.clear()
      document.location.reload(true)
    
    cdHUD.addElement(reset)
