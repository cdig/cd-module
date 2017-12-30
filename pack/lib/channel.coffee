do ()->
  idCounter = 0
  channels = {}
  findObjectElm = null
  
  getId = (elm)->
    unless id = elm.getAttribute "channel-id"
      id = "Channel#{idCounter++}"
      elm.setAttribute "channel-id", id
    id
  
  getChannel = (elm)->
    id = getId elm
    unless channels[id]
      channels[id] =
        id: id
        elm: elm
        port: null
        queue: {}
        listeners: {}
    channels[id]
  
  flush = (channel)->
    for k,v of channel.queue
      channel.port.postMessage "#{k}:#{v}"
  
  Make "Channel", (elm, k, v)->
    channel = getChannel elm
    channel.queue[k] = v
    flush channel
  
  # Listen for a handshake from children
  window.addEventListener "message", (e)->
    # TODO: Add origin checks
    # return unless e.origin is window.origin or e.origin.indexOf("https://cdn.lunchboxsessions.com") is 0
    
    if e.data is "Handshake"
      # TODO: Restrict the origin
      e.source.postMessage "RequestChannel", "*"
    
    if e.data is "Channel"
      channel = getChannel e.source.frameElement
      channel.port = e.ports[0]
      flush channel
      channel.port.start()
  
  # Request a handshake from any objects that might already be ready.
  # We don't need to wait for DOMContentLoaded, because any objects that haven't loaded will reach out to us when they load.
  for elm in document.querySelectorAll "object"
    elm.contentWindow?.postMessage "RequestHandshake", "*" # TODO: Restrict the origin
    
