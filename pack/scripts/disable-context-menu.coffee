Take "Config", (Config)->
  if not Config("dev")
    # Disable the content menu, so that we can use long-press on touch Windows
    window.addEventListener "contextmenu", (e)-> e.preventDefault()
