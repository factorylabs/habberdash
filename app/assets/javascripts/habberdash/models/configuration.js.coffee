class Habberdash.Configuration extends Spine.Model
  @configure 'Configuration', 'config'
  @hasMany 'dashboards', 'Habberdash.Dashboard'
  @extend Spine.Model.Ajax

  resourceUrl: -> '/configuration'


  constructor: ->
    super
    @activeDashboard = @storedDashboard()


  dashboard: (id = null) ->
    if id
      @activeDashboard = @dashboards().find(id)
      document.cookie = "dashboard=#{id}"
    @activeDashboard


  dashboardName: ->
    @dashboard().id


  storedDashboard: ->
    stored = document.cookie.match(/dashboard=([^;]*)/)
    if stored?[1] && @dashboards().count()
      return @dashboards().find(stored[1])
    @dashboards().first()
