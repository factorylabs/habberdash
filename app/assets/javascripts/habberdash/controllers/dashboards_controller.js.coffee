class Habberdash.DashboardsController extends Habberdash.Modal

  constructor: ->
    @attributes = {class: 'dashboards'}
    super({title: 'Dashboards'})

    @html(@view('dashboards'), Habberdash.config)
    @show()
