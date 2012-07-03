require 'redis'
module Habberdash

  module Persistence

    class Redis < Habberdash::Persistence::Base
      REDIS_KEY = "habberdash:dashboard_configuration"

      class << self
        attr_accessor :client
      end

      self.client = if redis_url = ENV['REDISTOGO_URL']
        u = URI.parse(redis_url)
        ::Redis.new host: u.host, port: u.port, password: u.password
      else
        ::Redis.new
      end

      def get
        self.class.client.get REDIS_KEY
      end

      def update(dashboard_config)
        begin
          self.class.client.set REDIS_KEY, dashboard_config
        rescue Exception => e
          add_error "Couldn't persist via Redis: #{e.message}" and return false
        end
      end

    end

  end

end
