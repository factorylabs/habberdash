class Habberdash.DashboardsController extends Habberdash.Modal

  events:
    'submit form': 'create'
    'tap [data-path]': 'switch'


  constructor: ->
    @attributes = {class: 'dashboards'}
    super({title: 'Dashboards'})

    @html(@view('dashboards', Habberdash.config))
    @show()


  initialize: ->
    @$(".sortable-list").disableSelection().sortable {
      axis: 'y'
      placeholder: "placeholder"
    }


  switch: (e) ->
    path = $(e.target).closest('[data-path]').data('path')
    @navigate(path)


  create: (e) ->
    e.preventDefault()
    form = $(e.target)
    params = form.serializeObject()

    dashboard = Habberdash.config.createDashboard(params)
    return @displayErrors(form, dashboard.validate()) unless dashboard.save()

    @navigate("/#{dashboard.id}")
