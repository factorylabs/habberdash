Habberdash.loadingIndicator = (options = {}) ->
  Habberdash.loadingIndicator.show(options)
  return Habberdash.loadingIndicator

$.extend Habberdash.loadingIndicator,

  show: (@options = {}) ->
    @initialize()
    @loadContent(@options.content)
    @appear() unless @visible


  initialize: ->
    return if @initialized
    @build()
    @initialized = true


  build: ->
    @el = $('<div>', {id: 'loading_indicator'}).html('<h4></h4>')
    @overlay = $('<div>', {id: 'loading_indicator_overlay'})

    @contentElement = @el.find('h4')

    @overlay.appendTo($(@options.appendTo).get(0) ? 'body')
    @el.appendTo($(@options.appendTo).get(0) ? 'body')


  appear: ->
    @overlay.show().css({opacity: 0})
    @overlay.stop().animate {opacity: 1}, 200, 'easeInOutSine', =>
      @el.show().css({opacity: 0})
      @el.stop().stop().animate {opacity: 1}, 200, 'easeInOutSine', =>
        @visible = true


  loadContent: (content) ->
    @contentElement.html(content || '')


  hide: ->
    @options = {}
    @visible = false

    @overlay.stop().hide()
    @el.stop().hide()
