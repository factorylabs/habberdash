class Habberdash.ControlsController extends Spine.Controller

  events:
    'tap h1': 'toggle'
    'tap [data-action]': 'onAction'


  constructor: ->
    @attributes = {id: 'controls'}
    super

    @options = @dashboard.options()
    @html(@view('controls', @options))

    @$control = @$('h1')
    @$navigation = @$('ul').hide()
    @opened = false
    

  toggle: ->
    if @opened
      @$navigation.stop().animate({bottom: -@$navigation.height()}, 200 * Habberdash.config.speed, 'easeOutQuad')
      @opened = false
    else
      @$navigation.css({bottom: -@$navigation.height()}).show()
      @$navigation.stop().animate({bottom: @$control.height()}, 200 * Habberdash.config.speed, 'easeOutQuad')
      @opened = true


  onAction: (event) ->
    action = $(event.target).closest('[data-action]').data('action')
    if Habberdash["#{action}Controller"]
      new Habberdash["#{action}Controller"]()
    else
      throw "#{action}Controller not found."
