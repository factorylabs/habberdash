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

  release: (callback) ->
    for event in @releaseEvents || []
      $(event.element)[event.unbindMethod](event.eventName, event.method)
    if typeof callback is 'function'
      @bind 'release', callback
    else
      @trigger 'release'


# Model Additions
#----------------------------------------------------------------------------------------------------/
makeArray = (args) ->
  Array::slice.call(args, 0)

class Habberdash.Model extends Spine.Model
  @options = (attributes...) ->
    @optionAttributes = attributes if attributes.length
    @optionAttributes and= makeArray(@optionAttributes)
    @optionAttributes or= []
    this

  @configure = (name, attributes...) ->
    @className  = name
    @records    = {}
    @crecords   = {}
    @attributes = attributes if attributes.length
    @attributes and= makeArray(@attributes)
    @attributes or= []
    @attributes.push(optionAttribute) for optionAttribute in (@optionAttributes || [])
    @unbind()
    this

  options: ->
    result = {}
    return result unless @constructor.optionAttributes
    for key in @constructor.optionAttributes when key of this
      if typeof @[key] is 'function'
        result[key] = @[key]()
      else
        result[key] = @[key]
    result.id = @id if @id
    result

