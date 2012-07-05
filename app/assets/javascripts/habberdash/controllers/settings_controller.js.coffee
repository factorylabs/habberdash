class Habberdash.SettingsController extends Habberdash.Modal

  events:
    'submit form': 'update'
    'tap .destroy': 'destroy'


  constructor: ->
    @attributes = {class: 'settings'}
    super({title: 'Settings'})

    @html(@view('settings', Habberdash.config.dashboardAttributes()))
    @show()


  update: (e) ->
    e.preventDefault()
    form = $(e.target)
    params = form.serializeObject()

    dashboard = Habberdash.config.updateDashboard(params)
    return @displayErrors(form, dashboard.validate()) unless dashboard.save()

    @navigate("/#{dashboard.id}", false)
    @hide()


  destroy: (e) ->
    e.preventDefault()
    Habberdash.config.destroyDashboard()

    @navigate("/#{Habberdash.config.dashboard().id}")
