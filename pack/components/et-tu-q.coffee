Take ["Shuffle", "DOMContentLoaded"], (Shuffle)->

  setup = (activity)->
    timeoutId = null
    
    multiple = activity.querySelectorAll("[x-correct]").length > 1
    noShuffle = activity.querySelector("[no-shuffle]")?
    
    subtitle = activity.querySelector ".subtitle"
    answers = activity.querySelector ".answers"
    labels = answers.querySelectorAll "label"
    inputs = answers.querySelectorAll "input"
    submit = activity.querySelector "button"
    
    # Shuffle the answers
    unless noShuffle or labels[0].textContent.toLowerCase().trim() is "true"
      Shuffle labels
      answers.appendChild label for label in labels
      # Rebuild this array now that stuff has moved
      inputs = answers.querySelectorAll "input"
    
    totalAnswerLength = 0
    
    for input, i in inputs
      # This is used to style incorrect answers as faded out once the game ends
      labels[i].setAttribute("x-incorrect", "true") unless input.hasAttribute "x-correct"
      
    # This styles answers differently when they're short
    for label, i in labels
      totalAnswerLength += label.textContent.length
    
    # The limit of 120 is set to accomodate a quiz in the Open Circuit TSTP lesson
    answers.setAttribute (if totalAnswerLength < 120 then "x-short" else "x-long"), ""
    
    # Set up the subtitle
    if multiple
      subtitle.textContent = "Select all that apply"

    # Set up the one-at-a-time behaviour
    else
      activeAnswer = null
      for input in inputs
        input.addEventListener "change", (e)->
          activeAnswer?.checked = false if activeAnswer isnt e.target
          activeAnswer = e.target

    success = ()->
      activity.className += " complete"
      submit.textContent = "Correct"
      submit.disabled = true
      for input, i in inputs
        input.disabled = true

    failure = ()->
      submit.textContent = "Not Quite"
      timeoutId = setTimeout (()-> submit.textContent = "Submit"), 2000

    submit.addEventListener "click", ()->
      victory = true
      for input in inputs
        victory = false if input.checked isnt input.hasAttribute "x-correct"
      
      clearTimeout timeoutId
      if victory then success() else failure()

  setup activity for activity in document.querySelectorAll "cd-activity[type='Et Tu, Q?']"
