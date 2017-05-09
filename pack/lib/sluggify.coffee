Make "Sluggify", (input)->
  return input
    .replace(/'/g, "") # Remove apostrophes
    .replace(/[^a-zA-Z0-9]/g, " ") # Replace all non-alphanumeric chars with a space
    .replace(/\s+/g, "-") # Replace all runs of whitespace with a single dash
    .replace(/-$/, "") # Strip trailing dashes
    .replace(/^-/, "") # Strip leading dashes
    .toLowerCase()
