class Habberdash.Configuration extends Spine.Model
  @configure 'Configuration', 'config'
  @hasMany 'dashboards', 'Habberdash.Dashboard'
  @extend Spine.Model.Ajax

  constructor: ->
    super
    @activeDashboard = @dashboards().first()
    console.debug(@activeDashboard)


  dashboard: (id = null) ->
    @activeDashboard = @dashboards().find(id) if id
    @activeDashboard


  dashboardName: ->
    @dashboard().id
