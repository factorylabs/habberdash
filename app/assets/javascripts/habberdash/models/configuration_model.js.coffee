class Habberdash.ConfigurationModel extends Spine.Model
  @configure 'ConfigurationModel', 'config'
  @hasMany 'dashboards', 'Habberdash.DashboardModel'
  @extend Spine.Model.Ajax

  resourceUrl: -> '/configuration'
  recordUrl: -> '/configuration'

  constructor: ->
    super
    @speed = 1

    return unless @id

    @dashboards().create(Habberdash.defaultDashboard) unless @dashboards().count()

    @activeDashboard = @storedDashboard()

    Habberdash.DashboardModel.bind 'save', => @save()
    Habberdash.DashboardModel.bind 'destroy', => @save()


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
    attrs['id'] = attrs['title']?.toSlug()
    if attrs['clone_id']
      dashboard = @dashboards().find(attrs['clone_id']).dup()
      dashboard.updateAttributes(attrs)
    else
      delete(attrs.id) if attrs['id'] && Habberdash.DashboardModel.findByAttribute('id', attrs['id'])
      dashboard = new Habberdash.DashboardModel(attrs)
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


  addWidget: (name, options) ->
    @dashboard().addWidget(name, options)


  toJSON: ->
    for dashboard in @dashboards().all()
      dashboard.toJSON()
