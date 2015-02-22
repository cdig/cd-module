# KV Store
# Provides a simple get/set k/v interface, with a save() method to persist the underlying DB.


Take "Backend", (Backend)->
  hasUnsavedChanges = false
  db = Backend.getPersistedData() or {}
  
  Make "KVStore",
    set: (k, v)->
      hasUnsavedChanges = true
      return db[k] = v
    
    get: (k)->
      return db[k]
    
    save: ()->
      if hasUnsavedChanges
        console.log "KVStore: Saving.."
        if Backend.setPersistedData(db)
          console.log "KVStore: Saved :)"
          hasUnsavedChanges = false
          return true
        else
          console.log "KVStore: Save Failed :("
          return false
      else
        return true
