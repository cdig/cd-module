Take "DOMContentLoaded", ()->
  
  hydraulicLegend = document.querySelector("[cd-legend-hydraulic]")
  electricalLegend = document.querySelector("[cd-legend-electrical]")
  lastClickedButtons = {}
  
  hide = (type)-> (e)->
    unless lastClickedButtons[type]?
      e.currentTarget.setAttribute "cd-legend-hide", ""
  
  setup = (button, legend, type)->
    button.addEventListener "click", (e)->
      if button is lastClickedButtons[type]
        lastClickedButtons[type] = null
        legend.removeAttribute "cd-legend-show"
        legend.addEventListener "transitionend", hide(type)
      else
        lastClickedButtons[type] = button
        rect = button.getBoundingClientRect()
        legend.style.left = (rect.left + document.body.scrollLeft + document.documentElement.scrollLeft + rect.width/2) + "px"
        legend.style.top = (rect.top + document.body.scrollTop + document.documentElement.scrollTop + rect.height) + "px"
        legend.removeEventListener "transitionend", hide
        legend.removeAttribute "cd-legend-hide"
        legend.removeAttribute "cd-legend-show"
        legend.setAttribute "cd-legend-reset", ""
        setTimeout ()->
          legend.removeAttribute "cd-legend-reset"
          legend.setAttribute "cd-legend-show", ""
  
  setup btn, hydraulicLegend, "hydraulic" for btn in document.querySelectorAll "[hydraulic-legend]"
  setup btn, electricalLegend, "electrical" for btn in document.querySelectorAll "[electrical-legend]"
