class Habberdash.WidgetTreeController extends Spine.Controller

  constructor: ->
    @attributes = {id: 'widget_tree'}
    super

    @html(@view('widget_tree'))

#    $('#widgets .row').sortable({ opacity: 0.6 })
#    $("#widgets .widget").draggable({
#      distance: 5
#      stack: '.widget'
#      opacity: 0.6,
#      grid: [20, 20]
#      containment: [-20,20,1000000,1000000]
#      scrollSensitivity: 10
#      scrollSpeed: 10
#      drag: (event, ui) ->
#        el = $(this)
#        $(this).css({left: 100}) if ui.offset.left < 100
#    })
