class Habberdash.WidgetTreeController extends Spine.Controller

  constructor: ->
    @attributes = {id: 'widgets'}
    super

    @html(@view('widget_tree'))


