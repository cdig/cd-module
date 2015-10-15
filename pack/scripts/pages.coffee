# Pages
# Frozen (immutable-ish) array of the pages in the module.

Take ["PureDom", "DOMContentLoaded"], (PureDom)->
  Make "Pages", Object.freeze PureDom.querySelectorAll document, "cd-page"
