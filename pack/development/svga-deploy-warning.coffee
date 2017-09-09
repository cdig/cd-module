Take ["Config", "DOMContentLoaded"], (Config)->
  return unless Config "dev"
  
  for obj in document.querySelectorAll "object"
    if obj.data.indexOf("https://cdn.lunchboxsessions.com") >= 0
      obj.data = ""
      obj.textContent = "For security reasons, this SVGA will only be visible when the cd-module is deployed to LunchBox Sessions."
      obj.setAttribute "svga-deploy-warning", ""
