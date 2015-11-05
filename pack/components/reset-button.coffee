Take ["cdHUD", "Scoring", "Env"], (cdHUD, Scoring, Env)->
  
  cdHUD.addButton
    text: "Reset Lesson"
    order: 3
    click: ()->
      if Env.dev or Env.debug or window.confirm "Do you really want to start over?"
        document.body.scrollTop = 0
        Scoring.resetModuleScore()
        document.location.reload true
