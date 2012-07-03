# TODO: Use ActiveSupport callbacks and delegation apis for #errors, #get, and
# #update
#
module Habberdash

  class DataAdapter

    class << self
      attr_accessor :persistence_strategy
    end
    self.persistence_strategy = Habberdash::Persistence::ActiveRecord

    attr_accessor :persistence

    def initialize(persistence_strategy = self.class.persistence_strategy.new)
      @errors = []
      @persistence = self.class.persistence_strategy.new
    end

    def errors
      ensure_persistence_strategy
      persistence.errors
    end

    def get
      ensure_persistence_strategy
      persistence.get
    end

    def update(*args)
      ensure_persistence_strategy
      persistence.update(*args)
    end

    def to_json(options = {})
      %Q{[{"id": "habberdash", "readonly": false, "dashboards": #{get}}]}
    end

    private

    def ensure_persistence_strategy
      raise 'No persistence strategy set!' unless persistence
    end

  end

end
