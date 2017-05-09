# Params

Pull all the query params out of the URL, and make them accessible with a getter function. Also allows you to set param values.

Let's say you're looking at a page with the URL `http://cdiginc.com/example?test="fail"`

```coffee
Take "Params", (Params)->

  console.log(Params("test"))
  # You will see "fail" on the console
  
  Params("test", "success")
  # The URL is now http://cdiginc.com/example?test="success"
```

## Conversion to native values

For the sake of "least surprise", we attempt to safely parse all values as numbers or booleans. We don't coerce, though — "TRUE" is still a string. Values passed in to Params are converted from strings to native values in the following cases:

* Boolean: The string is an exact match for "true" or "false".
* Number: The string contains a valid number literal, including weird literals like "-1." and "0b10"

Otherwise, it's left as a string, and it's up to you to deal with it.

## Mutation

Note: because of the HTML history API, param values might change at runtime! We decidedly don't care about that (for now). The only values we bother with are the values present when the Params lib first executes.
