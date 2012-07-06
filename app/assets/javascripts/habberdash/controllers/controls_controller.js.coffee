class Habberdash.ControlsController extends Spine.Controller

  events:
    'tap h1': 'toggle'
    'tap [data-action]': 'onAction'
    'tap [data-modal]': 'onModal'


  constructor: ->
    @attributes = {id: 'controls'}
    super

    @options = $.extend(@options, Habberdash.config.dashboardAttributes())

    @html(@view('controls', @options))
    @initialize()

    @opened = false
    @$control = @$('h1')
    @$navigation = @$('ul').hide()

    Habberdash.Dashboard.bind 'save', =>
      @options = $.extend(@options, Habberdash.config.dashboardAttributes())
      @initialize()


  initialize: ->
    @addCss {
      '#controls h1 i': {color: @options.color, opacity: 0.5}
      '#controls h1:hover i, #controls.open h1 i': {color: '#FFF', opacity: 1}
      '#controls h1:hover, #controls.open h1': {backgroundColor: @options.color}
      '#controls li:hover i': {color: @options.color}
    }


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


  hide: ->
    Habberdash.flash('Press ESC to show the controls again')
    @$el.stop().animate {left: -(@$el.outerWidth() + 50)}, 200 * Habberdash.config.speed, 'easeInOutSine', =>
      @toggle()


  show: (e = null) =>
    if e
      return unless e.keyCode == 27
      $(document).off('keydown', @show)
    @$el.stop().animate {left: 0}, 200 * Habberdash.config.speed, 'easeInOutSine', =>


  onAction: (e) ->
    action = $(e.target).closest('[data-action]').data('action')
    switch action
      when 'hide'
        $(document).on('keydown', @show)
        @hide()


  onModal: (e) ->
    modal = $(e.target).closest('[data-modal]').data('modal')
    if Habberdash["#{modal}Controller"]
      new Habberdash["#{modal}Controller"]()
    else
      throw "#{modal}Controller not found."
