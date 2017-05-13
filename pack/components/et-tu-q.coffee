Take ["Shuffle", "DOMContentLoaded"], (Shuffle)->

  setup = (activity)->
    timeoutId = null
    
    multiple = activity.querySelectorAll("[x-correct]").length > 1
    noShuffle = activity.querySelector("[no-shuffle]")?
    
    subtitle = activity.querySelector ".subtitle"
    labels = activity.querySelectorAll ".answers label"
    answers = activity.querySelectorAll ".answers input"
    submit = activity.querySelector "button"
    
    # Shuffle the answers
    unless noShuffle or labels[0].textContent.toLowerCase().trim() is "true"
      Shuffle labels
      container = activity.querySelector ".answers"
      container.appendChild label for label in labels
      # Rebuild this array now that stuff has moved
      answers = activity.querySelectorAll ".answers input"
    
    # This is used to style incorrect answers as faded out once the game ends
    for answer, i in answers
      labels[i].setAttribute("x-incorrect", "true") unless answer.hasAttribute "x-correct"

    # Set up the subtitle
    if multiple
      subtitle.textContent = "Select all that apply"

    # Set up the one-at-a-time behaviour
    else
      activeAnswer = null
      for answer in answers
        answer.addEventListener "change", (e)->
          activeAnswer?.checked = false if activeAnswer isnt e.target
          activeAnswer = e.target

    success = ()->
      activity.className += " complete"
      submit.textContent = "Correct"
      submit.disabled = true
      for answer, i in answers
        answer.disabled = true

    failure = ()->
      submit.textContent = "Not Quite"
      timeoutId = setTimeout (()-> submit.textContent = "Submit"), 2000

    submit.addEventListener "click", ()->
      victory = true
      for answer in answers
        victory = false if answer.checked isnt answer.hasAttribute "x-correct"
      
      clearTimeout timeoutId
      if victory then success() else failure()

  setup activity for activity in document.querySelectorAll "cd-activity[type='Et Tu, Q?']"
