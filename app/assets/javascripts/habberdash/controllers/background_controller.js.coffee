class Habberdash.BackgroundController extends Spine.Controller

  constructor: ->
    @attributes = {id: 'background'}
    super

    @options = $.extend(@options, Habberdash.config.dashboardAttributes())

    @html(@view('background', @options))
    @initialize()

    Habberdash.Dashboard.bind 'save', =>
      @options = $.extend(@options, Habberdash.config.dashboardAttributes())
      @initialize()


  initialize: ->
    @$image = @$('img').attr('src', @options.image)
    @$el.css({color: @options.color}).find('h1').html(@options.title)

    if @options.backgroundType == 'center-scale' || @options.backgroundType == 'scale'
      @$image.show()
      @imageDimensions = {width: parseInt(@$image.attr('width'), 10), height: parseInt(@$image.attr('height'), 10)}
      @imageDimensions.ratio = @imageDimensions.width / @imageDimensions.height
      $(window).on('resize', @resize)
      @resize()
    else
      @$image.hide()
      if @options.backgroundType == 'center'
        @$el.css({background: "url(#{@options.image}) no-repeat center"})
      else
        @$el.css({background: "url(#{@options.image})"})


  resize: =>
    windowDimensions = {width: $(window).width(), height: $(window).height()}
    windowDimensions.ratio = windowDimensions.width / windowDimensions.height

    width = 0
    height = 0
    if @imageDimensions.ratio <= windowDimensions.ratio
      width = windowDimensions.width
      height = windowDimensions.width / @imageDimensions.ratio
    else
      height = windowDimensions.height
      width = windowDimensions.height * @imageDimensions.ratio

    @$el.css({position: 'absolute', top: 0, left: 0, zIndex: '-1', width: '100%', overflow: 'hidden', height: windowDimensions.height})

    @$image.css
      position: 'absolute'
      maxWidth: 'none'
      maxHeight: 'none'
      width: width
      height: height
      top: if @options.backgroundType == 'center-scale' then (-(height - windowDimensions.height) / 2) else 0
      left: if @options.backgroundType == 'center-scale' then (-(width - windowDimensions.width) / 2) else 0
