class Habberdash.Configuration extends Spine.Model
  @configure 'Configuration', 'config'
  @hasMany 'dashboards', 'Habberdash.Dashboard'
  @extend Spine.Model.Ajax

  resourceUrl: -> '/configuration'
  recordUrl: -> '/configuration'


  constructor: ->
    super
    @speed = 1
    @activeDashboard = @storedDashboard()


  dashboard: (id = null) ->
    if id
      @activeDashboard = @dashboards().find(id)
      document.cookie = "dashboard=#{id}"
    return @activeDashboard


  dashboardName: ->
    @dashboard().id


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
