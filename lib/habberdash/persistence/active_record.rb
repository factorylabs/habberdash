require 'active_record'

module Habberdash

  module Persistence

    # The persistence adapter for ActiveRecord.
    #
    # This is the default, so to use this adapter in a Rails app, run:
    #
    #     rake habberdash:install:migrations
    #     rake db:migrate
    #
    class ActiveRecord < Habberdash::Persistence::Base

      # @api private
      #
      # The ActiveRecord model used by this persistence adapter.
      #
      class Dashboard < ::ActiveRecord::Base
        self.table_name = "habberdash_dashboard"
        attr_accessible :configuration
      end

      # Gets the configuration from ActiveRecord.
      #
      def get
        record.configuration
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
          record.update_attributes! configuration: dashboard_config
        rescue Exception => e
          add_error "Couldn't persist via ActiveRecord: #{e.message}" and return false
        end
      end

      private

      # @api private
      #
      # Gets the first record from the AR store or instantiates a new one.
      #
      def record
        Dashboard.first || Dashboard.new
      end

    end

  end

end
