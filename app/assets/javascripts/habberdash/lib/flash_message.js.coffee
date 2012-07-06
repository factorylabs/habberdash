Habberdash.flash = (content, options = {}) ->
  Habberdash.flash.show(content, options)
  return Habberdash.flash

$.extend Habberdash.flash,

  show: (@content, @options = {}) ->
    @initialize()
    @loadContent(@content)
    @appear() unless @visible


  initialize: ->
    return if @initialized
    @build()
    @initialized = true


  build: ->
    @$el = $('<div>', {id: 'flash_message'})

    @$el.appendTo($(@options.appendTo).get(0) ? 'body')


  appear: ->
    @$el.show().css({opacity: 0})
    @$el.stop().animate {opacity: 1}, 200, 'easeInOutSine', =>
      @visible = true


  loadContent: (content) ->
    @$el.html(content || '')
    setTimeout((=> @hide()), (@options.time || 2) * 1000)


  hide: ->
    @content = ''
    @options = {}
    @visible = false
    @$el.stop().animate({opacity: 0}, 1000, 'easeInOutSine')
