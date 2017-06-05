# A) We want to use iframes to load our modules on LBS
# B) We want to use height-responsive CSS to control things like image sizes
# If you do both of these, then iOS 9 & 10 (possibly others) cut off the bottom of the content in
# the iframe. To fix it, we figure out how big the module content is, and then set our min-height
# to be at least that big. This seems to solve the problem nicely enough. Naturally, it'd be better
# to solve this issue purely with CSS, but nothing I tried (in June 2017) worked.

Take "load", ()->
  
  html = document.documentElement
  module = document.querySelector "cd-module"
  
  resize = ()->
    html.style["min-height"] = null
    html.style.minHeight = module.getBoundingClientRect().height + "px"

  window.addEventListener "resize", resize
  resize()
