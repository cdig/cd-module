Make "TemplateBuilder", (template)->
  if document.createElement("template")?.content?
    clone = document.importNode template.content, true
    return clone
  else
    fragment = document.createDocumentFragment()
    for child in template.childNodes
      clone = child.cloneNode true
      fragment.appendChild clone
    return fragment
