Take "DOMContentLoaded", ()->
  
  hydraulicLegend = document.querySelector("[cd-legend-hydraulic]")
  electricalLegend = document.querySelector("[cd-legend-electrical]")
  
  state = {}
  
  setup = (button, legend, type)->
    throw "Element [cd-legend-#{type}] was not found in the DOM, and is needed by a legend button" unless legend?
    
    button.addEventListener "click", (e)->
      
      # Move the legend into position
      rect = button.getBoundingClientRect()
      legend.style.left = (rect.left + document.body.scrollLeft + document.body.parentNode.scrollLeft + rect.width/2) + "px"
      legend.style.top = (rect.top + document.body.scrollTop + document.body.parentNode.scrollTop + rect.height) + "px"
      
      # Turn off the load-time hiding
      legend.removeAttribute "cd-legend-init"
      
      # Toggle on
      if not legend.hasAttribute "cd-legend-show"
        legend.setAttribute "cd-legend-show", true
      
      # Toggle off (if we clicked the same button twice)
      else if button is state[type]
        legend.removeAttribute "cd-legend-show"
      
      state[type] = button
  
  # Setup all buttons
  setup btn, hydraulicLegend, "hydraulic" for btn in document.querySelectorAll "cd-pressure-legend-btn" # Named `pressure` for backwards compat
  setup btn, electricalLegend, "electrical" for btn in document.querySelectorAll "cd-electrical-legend-btn"
