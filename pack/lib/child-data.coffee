Take [], ()->
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


  # API ###########################################################################################

  Make "ChildData",
    send: (elm, k, v)->
      channel = getChannelForElement elm
      if channel.outbox[k] isnt v
        channel.outbox[k] = v
        channel.port?.postMessage "#{k}:#{v}"

    # Currently only used by svga-height.coffee so that the SVGA can set its own <object>'s height from inside
    listen: (elm, cb)->
      channel = getChannelForElement elm
      channel.listeners.push cb
      cb channel.inbox


  # INIT ##########################################################################################

  window.addEventListener "message", (e)->

    # Vimeo will sometimes fire a message event on the window, with a different data field format.
    # So, do a quick check to avoid null accesses.
    return unless e.data?.split?

    if e.data is "Handshake"
      e.source.postMessage "Handshake Received", "*"

    else
      [messageType, id] = e.data.split ":"
      if messageType is "Channel"
        cleanedId = cleanId id
        for elm in document.querySelectorAll "object" when cleanedId is cleanId elm.getAttribute "data"
          channel = getChannelForElement elm
          channel.port = e.ports[0]
          channel.port.addEventListener "message", makeChannelListener channel
          channel.port.postMessage "INIT"
          for attr in elm.attributes
            channel.outbox[cleanAttrName attr.name] = attr.value
          for k,v of channel.outbox
            channel.port.postMessage "#{k}:#{v}"
          channel.port.start()

  makeChannelListener = (channel)-> (e)->
    [k, v] = e.data.split ":"
    if k? and v?
      channel.inbox[k] = v
      cb channel.inbox for cb in channel.listeners # How does this cb know which <object> this is?
    else
      console.log "ChildData received an unprocessable message:", e.data

  cleanAttrName = (name)->
    name.replace "x-", ""
        .replace /-(.)/g, (match, char)-> char.toUpperCase()
