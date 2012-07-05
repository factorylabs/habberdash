#= require_self
#= require_tree ./lib
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

# Spine Application
class @Habberdash extends Spine.Controller

  @Widgets: {}

  @widgets: ->
    for name, configuration of Habberdash.Widgets
      console.debug(Habberdash.Widgets[name].spec.name)


  constructor: ->
    super

    # load configuration / dashboard data and initialize when done
    Habberdash.loadingIndicator()
    Habberdash.Configuration.bind('refresh', (configuration) => @initialize(configuration[0]))
    Habberdash.Configuration.fetch()


  initialize: (configuration) ->
    Habberdash.config = configuration
    Habberdash.loadingIndicator.hide()

    # setup routes
    @routes
      # base route - display a dashboard based on id
      '/:id': (params = {}) ->
        @navigate("/#{configuration.dashboardName()}", true) unless params['id']
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
    @append(@background = new Habberdash.BackgroundController())
    @append(@controls = new Habberdash.ControlsController())
#    @append(@widgetTree = new Habberdash.Widget(@configuration.widgets))


Habberdash.defaultDashboards = [
  {
    id: "intro",
    title: "Habberdash",
    color: "#222",
    image: "/assets/backgrounds/standard-dark.jpg",
    backgroundType: 'center-scale',
  },
  {
    id: "welcome",
    title: "Welcome",
    color: "#ddd",
    image: "/assets/backgrounds/standard-light.jpg",
    backgroundType: 'center-scale',
  }
]
