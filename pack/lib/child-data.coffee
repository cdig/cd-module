do ()->
  channels = {}
  
  cleanId = (id)->
    id.replace "https://cdn.lunchboxsessions.com/", ""
  
  getChannelForElement = (elm)->
    id = cleanId elm.getAttribute "data"
    channels[id] ?=
      id: id
      elm: elm
      port: null
      inbox: {}
      outbox: {}
      listeners: []
  
  sendToChannel = (channel, k, v)->
    if channel.outbox[k] isnt v
      channel.outbox[k] = v
      channel.port.postMessage "#{k}:#{v}" if channel.port?

  Make "ChildData",
    send: (elm, k, v)->
      sendToChannel getChannelForElement(elm), k, v
    
    listen: (elm, cb)->
      channel = getChannelForElement elm
      channel.listeners.push cb
      cb channel.inbox
  
  makeChannelListener = (channel)-> (e)->
    parts = e.data.split ":"
    channel.inbox[parts[0]] = parts[1]
    cb channel.inbox for cb in channel.listeners # How does this cb know which <object> this is?
  
  
  # INIT ##########################################################################################
  
  window.addEventListener "message", (e)->
    # TODO: Add origin checks
    # return unless e.origin is window.origin or e.origin.indexOf("https://cdn.lunchboxsessions.com") is 0
    
    parts = e.data.split(":")
    messageType = parts[0]
    id = parts[1]
    
    if messageType is "Channel"
      for obj in document.querySelectorAll "object" when cleanId(obj.getAttribute "data") is cleanId id
        channel = getChannelForElement obj
        channel.port = e.ports[0]
        channel.port.postMessage "#{k}:#{v}" for k,v of channel.outbox
        channel.port.addEventListener "message", makeChannelListener channel
        channel.port.start()
        return
