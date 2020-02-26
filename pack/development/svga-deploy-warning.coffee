Take ["Config", "DOMContentLoaded", "WarningsDone"], (Config)->
  return unless Config("dev") and window.top.location.href.indexOf("lunchboxsessions.com") is -1

  for obj in document.querySelectorAll "object"
    if obj.data.indexOf("lbs://") >= 0 or obj.data.indexOf("https://cdn.lunchboxsessions.com") >= 0

      obj.textContent = "(#{obj.data}) For security reasons, this SVGA will only be visible when the cd-module is deployed to LunchBox Sessions."
      obj.setAttribute "svga-deploy-warning", obj.data

      # The following code was added in https://github.com/cdig/cd-module/commit/2005bf1
      # but I can't remember why. So if we have trouble with channel comms, we know what to look at first.
      # But, it has since caused issues with CSP in Chrome when using multiple instances of the same SVGA.
      # For example, an <object data="example#2" ...> would get rewritten as <object data="2" ...>
      # That means the browser would try to load /2, which would load an error page from browser-sync,
      # with an unrecognized inline script, which would cause the CSP error.

      # if obj.data.indexOf("#") > 0
      #   obj.data.split("#")[1]
      # else
      #   ""

      # So we'll do this instead
      obj.data = ""
