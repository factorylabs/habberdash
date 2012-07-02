class Habberdash.WidgetsController extends Habberdash.Modal

  constructor: ->
    @attributes = {class: 'widgets'}
    super({title: 'Add a Widget'})

    @html(@view('widgets'), Habberdash.config)
    @show()
