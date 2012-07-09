class Habberdash.Modal extends Spine.Controller
  minWidth: 400

  @instance: null

  constructor: (options = {}) ->
    if Habberdash.Modal.instance
      Habberdash.Modal.instance.update(options)
      return Habberdash.Modal.instance

    Habberdash.Modal.instance = @
    @attributes = $.extend(@attributes || {}, {id: 'modal'})
    super

    @$el.html(@view('modal'))
    @$el.addClass('loading')
    @contents = false

    @$overlay = @$('.modal-overlay')
    @$container = @$('.modal-container')
    @$content = @$('.modal-content-container')
    @$display = @$('.modal-content')
    @$title = @$('.modal-title')

    @bindEvents()
    @appendTo($(@options.appendTo).get(0) ? 'body')


  initialize: ->


  bindEvents: ->
    @$el.on 'ajax:beforeSend', (event, xhr, options) =>
      options.success = (content) =>
        @loadContent(content)

    @$('.modal-close').on('click', @onClose)
    @$overlay.on('click', @onClose)
    $(document).on('keydown', @onClose)
    $(window).on('resize', @position)


  onClose: (event) =>
    @hide() if event.keyCode == 27 || !event.keyCode


  update: (@options = {}) ->
    @[key] = value for key, value of @options
    @resize()
    @setTitle()
    @load()


  show: ->
    @showing = true
    @$title.hide() unless @title
    @position()

    @$overlay.show().css({opacity: 0})
    @$overlay.stop().animate {opacity: 1}, 200 * Habberdash.config.speed, 'easeInOutSine', =>
      @setTitle()
      @$container.show().css({opacity: 0})
      @$container.stop().stop().animate {opacity: 1}, 200, 'easeInOutSine', =>
        @showing = false
        @load()


  setTitle: ->
    @$('.modal-title span').html(@title)
    if @options.disallowClosing
      @$('.modal-title .modal-close').show()
#    else
#      @$('h1.modal-title .modal-close').hide()


  resize: (fadeContent = true) ->
    css = @calculatePositions()

    @$container.stop().animate css['container'], 200 * Habberdash.config.speed, 'easeInOutSine', =>
      @$content.css($.extend(css['content'], {display: 'block', visibility: 'visible', opacity: if fadeContent then 0 else 1}))
      @$paneContainer.css(css['panes']) if css['panes']
      if fadeContent
        @$content.animate({opacity: 1}, 100 * Habberdash.config.speed, 'easeInOutSine')
      else
        @$content.show().css({opacity: 1})


  position: =>
    css = @calculatePositions()

    @$content.css(css['content'])
    @$paneContainer.css(css['panes']) if css['panes']
    @$container.css($.extend(css['container'], {display: 'block', visibility: 'visible'}))


  calculatePositions: ->
    @setTitle()
    css = {
      viewport: {width: $(window).width(), height: $(window).height()}
      container: {width: @$container.outerWidth(), height: @$container.outerHeight()}
      title: {height: @$title.outerHeight()}
    }

    #@contentPane.css({height: 'auto'}) if @contentPane
    @$content.css({height: 'auto'})
    @$container.css({width: 'auto', height: 'auto', visibility: 'hidden'})

    width = @$content.outerWidth()
    height = @$content.outerHeight()

    @$container.css({width: css.container.width, height: css.container.height, visibility: 'visible'})

    width = css.viewport.width - 30 if width > css.viewport.width - 30
    height = css.viewport.height - css.title.height - 30 if height + css.title.height > css.viewport.height - 30

    width = 300 if width < 300
    height = 150 if height < 150

    if @$paneContainer?.length && $paneControls?.length
      css['controls'] = {height: @$paneControls.outerHeight()}
      css['panes'] = {height: height - title.height - css.controls.height}

    css['content'] = {height: height}
    css['container'] = {
      top: (css.viewport.height - height - css.title.height) / 2
      left: (css.viewport.width - width) / 2
      width: width
      height: height + css.title.height
    }
    return css


  load: ->
    @setTitle()
    if @content || @contents
      @loadContent(@content)
      return
    else if @url
      @$el.addClass('loading')
      if JST[@url]
        @loadContent(JST[@url](@jstOptions || {}))
      else
        jQuery.ajax @url, {
          type: @loadType || 'GET'
          data: @loadData
          success: (data) => @loadContent(data)
          error: => throw "unable to load #{@url} for the modal."
        }


  loadContent: (content) ->
    @setTitle()
    @$el.removeClass('loading')
    @$content.css({display: 'none', visibility: 'hidden'})
    @html(content) if content

    @$paneContainer = @$('.modal-pane-container')
    @$paneControls = @$('.modal-pane-controls')

    @resize()
    @initialize()


  html: (element) ->
    @contents = true
    @$display.html(element.el or element)
    @refreshElements()
    @$content.scrollTop(0, 0)
    Habberdash.translateHtml(@$el)
    @$el


  release: ->
    $(document).off('keydown', @onClose)
    $(window).off('resize', @position)
    super
    Habberdash.Modal.instance = null


  hide: ->
    return if @showing
    @$el.stop().animate {opacity: 0}, 200 * Habberdash.config.speed, 'easeInOutSine', =>
      @release()
