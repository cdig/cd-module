# Units

Take ["ChildData", "Config", "DOMContentLoaded"], (ChildData, Config)->

  html = document.documentElement

  apply = (units)->
    html.setAttribute "units", units
    ChildData.send elm, "units", units for elm in document.querySelectorAll "object"
    return

  Make "Units",
    get: ()-> html.getAttribute "units"
    set: apply

  apply Config("units") or html.getAttribute("units") or "imperial"
