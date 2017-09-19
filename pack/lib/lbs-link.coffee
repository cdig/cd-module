# lbs-link Attribute
# We'll use this to link to other stuff on the site.
# Benefits of using JS rather than just using an href are:
# * Make sure we don't specify the subdomain, or it'd break for non-www subdomains
# * A `source` param on the link, for analytics
# * An `lbs-link` param on the link, so we can catch broken links
# * Better ergonomics for content authors.

Take "DOMContentLoaded", ()->
  
  warn = (linkElm)->
    Take "Warning", (Warning)-> # We do this here because Warning only exists in dev
      Warning "Your lbs-link is malformed. Please consult the docs and use the correct format.", linkElm
  
  for linkElm in document.querySelectorAll "a[lbs-link]"
    path = linkElm.getAttribute "lbs-link"
    warn linkElm if path.indexOf("http") >= 0 or path.indexOf("www") >= 0 or path.indexOf(".com") >= 0
    path = path.replace /^\/*/, "/" # start with exactly 1 slash
               .replace /\/+$/ # remove trailing slashes
    source = window.location.pathname
    linkElm.setAttribute "href", "#{path}?lbs-link=true&source=#{source}"
