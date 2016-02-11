# Mains
# Frozen (immutable-ish) array of the mains in the module.

Take ["PureDom", "DOMContentLoaded"], (PureDom)->
  Make "Mains", Object.freeze PureDom.querySelectorAll document, "cd-main"
