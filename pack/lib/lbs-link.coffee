# lbs-link Attribute
# We'll use this to link to other stuff on the site.
# Benefits of using JS rather than just using an href are:
# * Make sure we don't specify the subdomain, or it'd break for non-www subdomains
# * A `source` param on the link, for analytics
# * An `lbs-link` param on the link, so we can catch broken links
# * Better ergonomics for content authors.

Take ["Env", "DOMContentLoaded"], (Env)->

  warn = (linkElm)->
    Take "Warning", (Warning)-> # We do this here because Warning only exists in dev
      Warning "Don't include any http / www / .com stuff in your lbs-link", linkElm

  for linkElm in document.querySelectorAll "a[lbs-link]"
    path = linkElm.getAttribute "lbs-link"
    [path, params] = path.split "?"
    warn linkElm if path.indexOf("http") >= 0 or path.indexOf("www") >= 0
    path = path.replace /^\/*/, "/" # start with exactly 1 slash
               .replace /\/+$/ # remove trailing slashes
    source = if Env.dev then "cd-module-dev" else window.location.pathname
    path = "https://www.lunchboxsessions.com" + path if Env.dev
    path = "#{path}?lbs-link=true&source=#{source}"
    path += "&" + params if params
    linkElm.setAttribute "href", path
