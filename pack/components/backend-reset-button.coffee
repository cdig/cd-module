Take ["cdHUD", "KVStore", "Env"], (cdHUD, KVStore, Env)->
  
  cdHUD.addButton
    text: "Reset"
    order: 3
    click: ()->
      if Env.dev or Env.debug or window.confirm "Do you really want to start over?"
        document.body.scrollTop = 0
        KVStore.save() # need to save the store before we clear it to set the flag for it having unsaved changes to be false. Otherwise, the data will save before the reload happens.
        window.localStorage.clear()
        document.location.reload true
