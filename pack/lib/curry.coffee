do ()->
  Make "Curry", (nArguments, functionToCurry)->
    
    # Allow the first argument to be optional
    if not functionToCurry?
      functionToCurry = nArguments
      nArguments = functionToCurry.length
    
    return curriedFn = (args...)->
      
      if args.length < nArguments
        
        # We don't yet have enough arguments to run our functionToCurry.
        # Return a new function so we can take some more arguments.
        return (moreArgs...)->
          
          # Call ourselves again, with all the arguments we've received so far,
          # so we can see if we now have enough arguments to run functionToCurry.
          return curriedFn(args..., moreArgs...)
          
      else
        
        # We have enough arguments, so we can finally call functionToCurry()
        return functionToCurry(args...)
