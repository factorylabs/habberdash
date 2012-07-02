#= require_self
#= require_tree ./lib
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

# Spine Application
class @Habberdash extends Spine.Controller

  @baseConfig:
    speed: 1


  constructor: ->
    super

    # load configuration / dashboard data and initialize when done
    Habberdash.loadingIndicator()
    Habberdash.Configuration.bind('refresh', (configuration) => @initialize(configuration[0]))
    Habberdash.Configuration.fetch()


  initialize: (configuration) ->
    Habberdash.config = $.extend(Habberdash.baseConfig, configuration)
    Habberdash.loadingIndicator.hide()

    # setup routes
    @routes
      # base route - display a dashboard based on id
      '/:id': (params = {}) ->
        try
          @initializeDashboard(configuration.dashboard(params['id']))
        catch e
          if e == 'Unknown record' then @navigate("/#{configuration.dashboardName()}", true) else throw e
      # glob route - redirects to the last dashboard
      '*glob': -> @navigate("/#{configuration.dashboardName()}", true)

    # initialize routing
    Spine.Route.setup()


  initializeDashboard: (@dashboard) ->
    @$el.html('')
    Habberdash.Modal.instance?.hide()

    # initialize base controllers
    @append(@background = new Habberdash.BackgroundController({dashboard: @dashboard}))
    @append(@controls = new Habberdash.ControlsController({dashboard: @dashboard}))
#    @append(@widgetTree = new Habberdash.Widget(@configuration.widgets))
