Take "DOMContentLoaded", ()->
  
  huds = document.querySelectorAll("cd-hud")
  template = document.querySelector("#cd-hud")
  return unless huds.length and template?
  
  for hud in huds
    for node in template.children
      hud.appendChild(node)
  
  Make "cdHUD", cdHud =
    
    # TODO: Calls to this function tend to depend on loading & execution order, which means the order that elements are added to the HUD is nondeterministic. We should make this more explicit somehow.
    addElement: (element)->
      for hud in huds
        hud.appendChild(element)
