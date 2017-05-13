Make "Shuffle", (arr)->
  for item, i in arr by -1 when i > 0
    r = Math.random() * i |0
    [arr[i], arr[r]] = [arr[r], arr[i]]
  return arr
