class Habberdash.WidgetsController extends Habberdash.Modal

  events:
    'tap img': 'onInstallWidget'
    'tap .back': 'back'

  constructor: ->
    @attributes = {class: 'widgets'}
    super({title: 'Add a Widget'})

    @html(@view('widgets', Habberdash.config))
    @show()


  back: ->
    @loadContent(@view('widgets', Habberdash.config))


  onInstallWidget: (event) ->
    widgetName = $(event.target).closest('[data-name]').data('name')
    @loadContent(@view('widget_details', Habberdash.Widgets[widgetName]))

