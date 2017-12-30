do ()->
  
  idCounter = 0
  channels = {}
  
  getElementChannelId = (elm)->
    id = elm.getAttribute "channel-id"
    elm.setAttribute "channel-id", id = "Channel#{idCounter++}" unless id?
    id
  
  getElementChannel = (elm)->
    id = getElementChannelId elm
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
    sendAll: (k, v)->
      sendToChannel channel, k, v for id, channel of channel
    
    send: (elm, k, v)->
      sendToChannel getElementChannel(elm), k, v
    
    get: (elm, k)->
      channel = getElementChannel elm
      channel.inbox[k]
    
    listen: (elm, cb)->
      channel = getElementChannel elm
      channel.listeners.push cb
      cb channel.inbox
  
  
  # INIT ##########################################################################################
  
  window.addEventListener "message", (e)->
    
    # TODO: Add origin checks
    # return unless e.origin is window.origin or e.origin.indexOf("https://cdn.lunchboxsessions.com") is 0
    
    if e.data is "Handshake"
      # TODO: Restrict the origin
      e.source.postMessage "RequestChannel", "*"
    
    if e.data is "Channel"
      channel = getElementChannel e.source.frameElement
      channel.port = e.ports[0]
      channel.port.postMessage "#{k}:#{v}" for k,v of channel.outbox
      channel.port.start()
      channel.port.addEventListener "message", (e)->
        parts = e.data.split ":"
        channel.inbox[parts[0]] = parts[1]
        cb channel.inbox for cb in channel.listeners # How does this cb know which <object> this is?
  
  # Request a handshake from any objects that might already be ready.
  # Any objects that haven't loaded yet will reach out to us when they're ready.
  for elm in document.querySelectorAll "object"
    elm.contentDocument.defaultView.postMessage "RequestHandshake", "*" # TODO: Restrict the origin
  
