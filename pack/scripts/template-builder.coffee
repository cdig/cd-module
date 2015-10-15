# TemplateBuilder
#
# HTML Imports and the <template> element are not cross-browser yet.
# I'm not sure what the right approach to polyfilling their behaviour is yet,
# so this is a first attempt. We'll see how painful this is, and re-design in the future.

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
