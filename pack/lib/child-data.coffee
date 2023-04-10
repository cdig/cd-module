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

  charToUpper = (match, char)->
    char.toUpperCase()

  cleanAttrName = (name)->
    name.replace("x-", "").replace /-(.)/g, charToUpper

  # INIT ##########################################################################################

  window.addEventListener "message", (e)->

    # Vimeo will sometimes fire a message event on the window, with a different data field format.
    # So, do a quick check to avoid null accesses.
    return unless e.data?.split?

    parts = e.data.split(":")
    messageType = parts[0]
    id = parts[1]

    if messageType is "Channel"
      for obj in document.querySelectorAll "object" when cleanId(obj.getAttribute "data") is cleanId id
        channel = getChannelForElement obj
        channel.port = e.ports[0]
        channel.outbox[cleanAttrName attr.name] = attr.value for attr in obj.attributes
        channel.port.postMessage "#{k}:#{v}" for k,v of channel.outbox
        channel.port.postMessage "INIT"
        channel.port.addEventListener "message", makeChannelListener channel
        channel.port.start()
        return
