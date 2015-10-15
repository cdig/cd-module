Make "TemplateBuilder", (template)->
  if document.createElement("template")?.content?
    clone = document.importNode template.content, true
    return clone
  else
    throw new Error "TemplateBuilder: Browser doesn't support templates"
