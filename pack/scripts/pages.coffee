# Pages
# Frozen (immutable-ish) array of the pages in the module.

Take ["PureDom", "load"], (PureDom)->
  
  pages = PureDom.querySelectorAll document, "cd-page"
  Object.freeze pages
  
  Make "Pages", pages
