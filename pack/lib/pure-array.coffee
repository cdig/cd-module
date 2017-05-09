Make "PureArray", PureArray =
  
  clone: (input)->
    return Array.prototype.slice.call(input)
  
  getRandom: (input)->
    return input[input.length * Math.random() |0]
  
  shuffle: (input)->
    # Yes, this is inefficient as fuck
    # If you can come up with a better random that preserves the distribution of fisher-yates,
    # then please improve this function
    output = PureArray.clone(input)
    
    # Coffeescript-ified Fisher-Yates!
    for item, i in output by -1 when i > 0
      r = Math.random() * i |0
      [output[i], output[r]] = [output[r], output[i]]
    return output
  
  swapItem: (input, item1, item2)->
    output = for i in input
      switch i
        when item1 then item2
        when item2 then item1
        else i
    return output
      
  swapIndex: (input, index1, index2)->
    return PureArray.swapItem(input, input[index1], input[index2])
