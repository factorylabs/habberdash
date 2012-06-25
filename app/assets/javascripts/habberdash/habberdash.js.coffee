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

    # Load configuration / dashboard data and initialize when done
    @initialize(Habberdash.defaultConfiguration)
    #Habberdash.Configuration.bind('refresh', (configuration) => @initialize(configuration[0]))
    #Habberdash.Configuration.fetch()


  initialize: (configuration) ->
    # Setup routes
    @routes
      '/': (params = {}) -> @navigate('/0')
      '/:id': (params = {}) ->
        console.debug(params)
        @configuration = configuration[params['id']]
        @initializeBase()

    # Initialize routing
    Spine.Route.setup()


  initializeBase: ->
    # Initialize base controllers
    @append(@background = new Habberdash.Background(@configuration))
#    @append(@widgetTree = new Habberdash.Widget(@configuration.widgets))


Habberdash.defaultConfiguration = {
  'something': {
    title: 'Something'
    color: '#DDD'
    backgroundColor: '#FFF'
    image: 'standard-light.jpg'
    centerImage: true
    widgets: []
  },
  'another': {
    title: 'Another'
    color: '#333'
    backgroundColor: '#111'
    image: 'standard-dark.jpg'
    centerImage: true
    widgets: []
  }
}
