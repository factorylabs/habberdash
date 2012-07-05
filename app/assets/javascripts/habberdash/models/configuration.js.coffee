class Habberdash.Configuration extends Spine.Model
  @configure 'Configuration', 'config'
  @hasMany 'dashboards', 'Habberdash.Dashboard'
  @extend Spine.Model.Ajax

  resourceUrl: -> '/configuration'
  recordUrl: -> '/configuration'

  constructor: ->
    super
    @speed = 1

    unless @dashboards().count()
      @dashboards().create(dashboard) for dashboard in Habberdash.defaultDashboards

    @activeDashboard = @storedDashboard()


  dashboard: (id = null) ->
    if id
      @activeDashboard = @dashboards().find(id)
      document.cookie = "dashboard=#{id}"
    return @activeDashboard


  dashboardName: ->
    @dashboard().id


  dashboardAttributes: ->
    @dashboard().attributes()


  findDashboard: (attr, value) ->
    @dashboards().findByAttribute(attr, value)


  createDashboard: (attrs) ->
    attrs['configuration_id'] = @id
    attrs['id'] = attrs['title']?.toDash()
    if attrs['clone_id']
      dashboard = @dashboards().find(attrs['clone_id']).dup()
      dashboard.updateAttributes(attrs)
    else
      dashboard = new Habberdash.Dashboard(attrs)
    return dashboard


  updateDashboard: (attrs, options) ->
    @dashboard().updateAttributes(attrs, options)
    return @dashboard()


  destroyDashboard: ->
    @dashboard().destroy()
    @dashboard(@storedDashboard().id)


  storedDashboard: ->
    stored = document.cookie.match(/dashboard=([^;]*)/)
    if stored?[1] && @dashboards().count()
      try
        return @dashboards().find(stored[1])
      catch e
    return @dashboards().first()


  toJSON: ->
    for dashboard in @dashboards().all()
      dashboard.toJSON()
