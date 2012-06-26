#= require hamlcoffee
#= require_self
#= require_tree ./lib
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

# Spine Application
class @Habberdash extends Spine.Controller

  constructor: ->
    super

    # load configuration / dashboard data and initialize when done
    #Habberdash.Configuration.bind('refresh', (configuration) => @initialize(configuration[0]))
    #Habberdash.Configuration.fetch()

    # for a static configuration use this:
    @initialize(new Habberdash.Configuration(Habberdash.staticConfiguration))


  initialize: (configuration) ->
    # setup routes
    @routes
      # base route - display a dashboard based on id
      '/:id': (params = {}) ->
        try
          @initializeDashboard(configuration.dashboard(params['id']))
        catch e
          if e == 'Unknown record' then @navigate("/#{configuration.dashboardName()}", true) else throw e
      # glob route - redirects to the default dashboard
      '*glob': -> @navigate("/#{configuration.dashboardName()}", true)

    # initialize routing
    Spine.Route.setup()


  initializeDashboard: (@dashboard) ->
    # initialize base controllers
    @replace(@background = new Habberdash.Background(@dashboard.options()))
#    @append(@widgetTree = new Habberdash.Widget(@configuration.widgets))



Habberdash.staticConfiguration =
  readonly: false
  dashboards: [
    {
      id: 'foo'
      title: 'foo'
      color: '#DDD'
      backgroundColor: '#FFF'
      image: 'standard-light.jpg'
      centerImage: true
      widgets: [
        {
          type: 'twitter'
          title: 'widget1'
          endpoint: '/something/'
        },
        {
          type: 'twitter'
          title: 'widget2'
          endpoint: '/something/'
        },
      ]
    },
    {
      id: 'bar'
      title: 'bar'
      color: '#333'
      backgroundColor: '#111'
      image: 'standard-dark.jpg'
      centerImage: true
      widgets: []
    }
  ]
