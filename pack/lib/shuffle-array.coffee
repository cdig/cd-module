Make "Shuffle", (arr)->
  newArr = []
  
  for item, i in arr
    p = Math.round Math.random() * newArr.length
    newArr.splice p, 0, item
    null
  
  return newArr
