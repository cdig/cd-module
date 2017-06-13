Take "DOMContentLoaded", ()->
  
  hydraulicLegend = document.querySelector("[cd-legend-hydraulic]")
  electricalLegend = document.querySelector("[cd-legend-electrical]")
  
  state = {}
  
  setup = (button, legend, type)->
    throw "Element [cd-legend-#{type}] was not found in the DOM, and is needed by a legend button" unless legend?
    
    hide = (e)->
      e.currentTarget.setAttribute "cd-legend-hide", ""
    
    button.addEventListener "click", (e)->
      
      # Move the legend into position
      rect = button.getBoundingClientRect()
      legend.style.left = (rect.left + document.body.scrollLeft + document.body.parentNode.scrollLeft + rect.width/2) + "px"
      legend.style.top = (rect.top + document.body.scrollTop + document.body.parentNode.scrollTop + rect.height) + "px"
      
      # Toggle on
      if not legend.hasAttribute "cd-legend-show"
        legend.removeAttribute "cd-legend-hide"
        legend.removeEventListener "transitionend", hide
        setTimeout ()->
          legend.setAttribute "cd-legend-show", ""
      
      # Toggle off (if we clicked the same button twice)
      else if button is state[type]
        legend.removeAttribute "cd-legend-show"
        legend.addEventListener "transitionend", hide
      
      state[type] = button
  
  # Setup all buttons
  setup btn, hydraulicLegend, "hydraulic" for btn in document.querySelectorAll "[hydraulic-legend]"
  setup btn, electricalLegend, "electrical" for btn in document.querySelectorAll "[electrical-legend]"
