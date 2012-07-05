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
    return @displayErrors(form, dashboard.validate()) unless dashboard.isValid()

    @navigate("/#{dashboard.id}", false)
    @hide()


  destroy: (e) ->
    e.preventDefault()
    if Habberdash.config.dashboards().count() == 1
      alert("You can't delete your last dashboard.")
    else
      return unless confirm('Are you sure?')
      Habberdash.config.destroyDashboard()

    @navigate("/#{Habberdash.config.dashboard().id}")
