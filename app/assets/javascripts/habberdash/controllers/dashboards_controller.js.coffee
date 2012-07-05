class Habberdash.DashboardsController extends Habberdash.Modal

  events:
    'submit form': 'create'


  constructor: ->
    @attributes = {class: 'dashboards'}
    super({title: 'Dashboards'})

    @html(@view('dashboards', Habberdash.config))
    @show()


  create: (e) ->
    e.preventDefault()
    form = $(e.target)
    params = form.serializeObject()

    dashboard = Habberdash.config.createDashboard(params)
    return @displayErrors(form, dashboard.validate()) unless dashboard.save()

    @navigate("/#{dashboard.id}")
