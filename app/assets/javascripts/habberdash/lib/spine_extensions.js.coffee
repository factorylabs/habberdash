# Controller Additions
#----------------------------------------------------------------------------------------------------/
Spine.Controller.include
  view: (name, options = {}) ->
    JST["habberdash/views/#{name}"](options)

  trace: ->
    return unless App.debugMode && window.console && window.console.log
    try console.log(arguments)
    catch e

  delegateEvents: (events) ->
    @releaseEvents ||= []
    for key, method of events
      unless typeof(method) is 'function'
        method = @proxy(@[method])

      match      = key.match(@eventSplitter)
      eventName  = match[1]
      selector   = match[2]

      if selector is ''
        @el.bind(eventName, method)
      if selector is 'hotkey'
        $(document).bind('keydown', eventName, method)
        @releaseEvents.push({element: document, unbindMethod: 'unbind', eventName: 'keydown', method: method})
      else
        @el.delegate(selector, eventName, method)
