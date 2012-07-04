# TODO: Use ActiveSupport callbacks and delegation apis for `errors`, `get`, and
# `update`
#
module Habberdash

  # This is the adapter class that acts to provide an interface to persistence
  # via MongoDB/Mongoid, ActiveRecord, and Redis.
  #
  # Examples:
  #
  #     Habberdash::DataAdapter.persistence_strategy = Habberdash::Persistence::ActiveRecord
  #
  #     adapter = Habberdash::DataAdapter.new
  #     adapter.update('{"foo":"bar"}') #=> true
  #     adapter.get                     #=> {"foo":"bar"}
  #
  class DataAdapter

    class << self

      # The default persistence strategy used when initializing new DataAdapter
      # instances.
      #
      attr_accessor :persistence_strategy

    end

    # @api private
    #
    attr_accessor :persistence

    # Create a new DataAdapter. Optionally pass a persistence adapter instance to
    # override the default set at `DataAdapter.persistence_strategy`
    #
    def initialize(persistence_strategy = self.class.persistence_strategy.try(:new))
      @errors, @persistence = [], persistence_strategy
    end

    # Returns any errors on the persistence adapter. Delegated to the
    # persistence adapter in use.
    #
    def errors
      ensure_persistence_strategy
      persistence.errors
    end

    # Get the dashboard configuration from the persistence layer. This method
    # is delegated to the persistence adapter in use.
    #
    def get
      ensure_persistence_strategy
      persistence.get
    end

    # Update the dashboard configuration. This method is delegated to the
    # persistence adapter in use.
    #
    def update(*args)
      ensure_persistence_strategy
      persistence.update(*args)
    end

    # Overridden to wrap the result of `#get` in top-level configuration data.
    #
    def to_json(options = {})
      %Q{[{"id": "habberdash", "readonly": false, "dashboards": #{get}}]}
    end

    private

    # @api private
    #
    # Raises an error unless a persistence adapter is present.
    #
    def ensure_persistence_strategy
      raise 'No persistence strategy set!' unless persistence
    end

  end

end
