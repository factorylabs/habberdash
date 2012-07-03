module Habberdash

  module Persistence

    class ActiveRecord < Habberdash::Persistence::Base

      class Dashboard < ::ActiveRecord::Base
        self.table_name = "habberdash_dashboard"
        attr_accessible :configuration
      end

      def get
        record.configuration
      end

      def update(dashboard_config)
        begin
          record.update_attributes! configuration: dashboard_config
        rescue Exception => e
          add_error "Couldn't persist via ActiveRecord: #{e.message}" and return false
        end
      end

      private

      def record
        Dashboard.first || Dashboard.new
      end

    end

  end

end
