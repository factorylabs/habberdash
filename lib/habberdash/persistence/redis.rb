require 'redis'
module Habberdash

  module Persistence

    # The persistence adapter for Redis.
    #
    # When using habberdash as a rails engine, add the following to use this
    # persistence adapter in your app:
    #
    #     require 'habberdash/redis'
    #
    class Redis < Habberdash::Persistence::Base
      REDIS_KEY = "habberdash:dashboard_configuration"

      class << self

        # The redis client used by this persistence adapter. If running on
        # Heroku, this is initialized off of the REDISTOGO_URL environment
        # variable. Otherwise the client is initialized with defaults.
        #
        attr_accessor :client

      end

      self.client = if redis_url = ENV['REDISTOGO_URL']
        u = URI.parse(redis_url)
        ::Redis.new host: u.host, port: u.port, password: u.password
      else
        ::Redis.new
      end

      # Gets the configuration from Redis.
      #
      def get
        self.class.client.get REDIS_KEY
      end

      # Updates the dashboard configuration.
      #
      # If an error occurs while saving the record, the related error(s) are
      # added to the `errors` collection
      #
      # Examples:
      #
      #     adapter.update('{"foo":"bar"}') #=> true
      #
      # or in the event of a save failure:
      #
      #     adapter.update('{"foo":"bar"}') #=> false
      #     adapter.errors #=> Array of exception messages
      #
      def update(dashboard_config)
        begin
          self.class.client.set(REDIS_KEY, dashboard_config) == 'OK'
        rescue Exception => e
          add_error "Couldn't persist via Redis: #{e.message}" and return false
        end
      end

    end

  end

end
