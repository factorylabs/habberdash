require 'mongoid'

module Habberdash

  module Persistence

    class Mongoid < Habberdash::Persistence::Base

      class Dashboard
        include ::Mongoid::Document
        field :configuration, type: String
      end

      def get
        Habberdash::Persistence::Mongoid::Dashboard.first.try(:configuration)
      end

      def update(configuration)
        begin
          record.update_attributes! configuration: configuration
        rescue Exception => e
          add_error "Couldn't persist via Mongoid: #{e.message}" and return false
        end
      end

      private

      def record
        Habberdash::Persistence::Mongoid::Dashboard.first || Habberdash::Persistence::Mongoid::Dashboard.new
      end

    end

  end

end
