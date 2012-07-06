#describe "Habberdash.Configuration", ->
#
#  describe "constructor", ->
#
#    beforeEach ->
#      @configuration = new Habberdash.Configuration(testConfiguration)
#
#    it "sets @activeDashboard to the first dashboard", ->
#      expect(@configuration.activeDashboard.id).toEqual('foo')
#
#
#  describe "#dashboard", ->
#
#    beforeEach ->
#      @configuration = new Habberdash.Configuration(testConfiguration)
#
#    it "returns the active dashboard", ->
#      expect(@configuration.dashboard()).toEqual(@configuration.activeDashboard)
#
#    it "sets the active dashboard", ->
#      dashboard = @configuration.dashboard('bar')
#      expect(dashboard).toEqual(@configuration.activeDashboard)
#      expect(dashboard.id).toEqual('bar')
#
#
#  describe "#dashboardName", ->
#
#    beforeEach ->
#      @configuration = new Habberdash.Configuration(testConfiguration)
#
#    it "returns the active dashboard name", ->
#      dashboard = @configuration.dashboard('bar')
#      expect(@configuration.dashboardName()).toEqual('bar')
