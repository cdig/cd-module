if Element and not Element.prototype.matches
  Element.prototype.matches = Element.prototype.matchesSelector or Element.prototype.msMatchesSelector
