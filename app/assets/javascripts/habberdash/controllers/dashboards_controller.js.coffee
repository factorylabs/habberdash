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
    serialized = form.serializeObject()
    id = serialized['title'].toDash()
    serialized['id'] = id unless Habberdash.config.dashboards().findByAttribute('id', id)

    if clone = form.find('#dashboard_clone').val()
      dashboard = Habberdash.config.dashboards().find(clone).dup()
      dashboard.updateAttributes(serialized)
    else
      dashboard = Habberdash.config.dashboards().create($.extend(Habberdash.Dashboard.defaults, serialized))

    return @displayErrors(form, dashboard.validate()) unless dashboard.save()
    @navigate("/#{dashboard.id}")
