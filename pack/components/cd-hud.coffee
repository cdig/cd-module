Take ["TemplateBuilder", "PureDom", "DOMContentLoaded"], (TemplateBuilder, PureDom)->
  huds = PureDom.querySelectorAll document, "cd-hud"
  
  Make "cdHUD", cdHud =
    # TODO: Calls to this function tend to depend on loading & execution order, which means the order that elements are added to the HUD is nondeterministic. We should make this more explicit somehow.
    addElement: (element)->
      for hud in huds
        hud.appendChild element.cloneNode true
  
  template = document.querySelector "template#cd-hud"
  content = TemplateBuilder template
  cdHud.addElement content
