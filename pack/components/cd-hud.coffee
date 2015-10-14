Take ["TemplateBuilder", "DOMContentLoaded"], (TemplateBuilder)->
  huds = document.querySelectorAll "cd-hud"
  
  Make "cdHUD", cdHud =
    # TODO: Calls to this function tend to depend on loading & execution order, which means the order that elements are added to the HUD is nondeterministic. We should make this more explicit somehow.
    addElement: (element)->
      hud.appendChild element for hud in huds
  
  template = document.querySelector "template#cd-hud"
  content = TemplateBuilder template
  cdHud.addElement content
