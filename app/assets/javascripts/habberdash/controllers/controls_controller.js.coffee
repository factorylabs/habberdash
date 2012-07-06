class Habberdash.ControlsController extends Spine.Controller

  events:
    'tap h1': 'toggle'
    'tap [data-action]': 'onAction'


  constructor: ->
    @attributes = {id: 'controls'}
    super

    @options = $.extend(@options, Habberdash.config.dashboardAttributes())

    @html(@view('controls', @options))

    @addCss {
      '#controls h1 i': {color: @options.color, opacity: 0.5}
      '#controls h1:hover i, #controls.open h1 i': {color: '#FFF', opacity: 1}
      '#controls h1:hover, #controls.open h1': {backgroundColor: @options.color}
      '#controls li:hover i': {color: @options.color}
    }

    @opened = false
    @$control = @$('h1')
    @$navigation = @$('ul').hide()


  toggle: ->
    if @opened
      @$navigation.stop().animate {bottom: -@$navigation.height()}, 200 * Habberdash.config.speed, 'easeOutQuad', =>
        @$el.removeClass('open')
        @opened = false
    else
      @$el.addClass('open')
      @$navigation.css({bottom: -@$navigation.height()}).show()
      @$navigation.stop().animate({bottom: @$control.height()}, 200 * Habberdash.config.speed, 'easeOutQuad')
      @opened = true


  onAction: (event) ->
    action = $(event.target).closest('[data-action]').data('action')
    if Habberdash["#{action}Controller"]
      new Habberdash["#{action}Controller"]()
    else
      throw "#{action}Controller not found."
