#the module wrapper sets the wrapper to the size of the inner height of the window
#the wrapper gives us the ability to have scrolling on the ipad and fixed elements

Take "load", ()->  
  wrapper = document.body.querySelector('module-wrapper')
  wrapper.style.height = window.innerHeight + "px"

  window.addEventListener "resize", ()->
    wrapper = document.body.querySelector('module-wrapper')
    wrapper.style.height = window.innerHeight + "px"
