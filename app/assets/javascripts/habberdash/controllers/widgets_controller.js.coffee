class Habberdash.WidgetsController extends Habberdash.Modal

  events:
    'tap .install': 'configure'
    'tap .back': 'back'
    'submit form': 'create'


  constructor: ->
    @attributes = {class: 'widgets'}
    super({title: 'Add a Widget'})

    @html(@view('widget_list', Habberdash.config))
    @show()


  back: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @loadContent(@view('widget_list', Habberdash.config))


  configure: (e) ->
    e.preventDefault()
    @widgetName = $(e.target).closest('[data-name]').data('name')
    @loadContent(@view('widget_details', Habberdash.Widgets[@widgetName]))


  create: (e) ->
    return unless $(e.target).attr('type') == 'submit'
    e.preventDefault()
    Habberdash.config.addWidget(@widgetName)
