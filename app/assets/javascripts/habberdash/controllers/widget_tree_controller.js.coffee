class Habberdash.WidgetTreeController extends Spine.Controller

  constructor: ->
    @attributes = {id: 'widget_tree'}
    super

    @html(@view('widget_tree'))

    @makeSortable()


  makeSortable: ->
    @$('.row').sortable {
      opacity: 0.6
      tolerance: 'pointer'
      grid: [20, 20]
    }
    # todo: alternate method that we might want to look into... requires some css changes
    #@$('.widget').draggable {
    #  distance: 5
    #  stack: '.widget'
    #  opacity: 0.6,
    #  grid: [20, 20]
    #  containment: [-20,20,1000000,1000000]
    #  scrollSensitivity: 10
    #  scrollSpeed: 10
    #}
