require 'mongoid'

module Habberdash

  module Persistence

    # The persistence adapter for MongoDB. Uses Mongoid >= v3.0.0
    #
    # When using habberdash as a rails engine, add the following to use this
    # persistence adapter in your app:
    #
    #     require 'habberdash/mongoid'
    #
    class Mongoid < Habberdash::Persistence::Base

      # @api private
      #
      # The Mongoid model used by this persistence adapter.
      #
      class Dashboard
        include ::Mongoid::Document
        field :configuration, type: String
      end

      # Gets the configuration from Mongoid.
      #
      def get
        Habberdash::Persistence::Mongoid::Dashboard.first.try(:configuration)
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
      def update(configuration)
        begin
          record.update_attributes! configuration: configuration
        rescue Exception => e
          add_error "Couldn't persist via Mongoid: #{e.message}" and return false
        end
      end

      private

      # @api private
      #
      # Gets the first record from the AR store or instantiates a new one.
      #
      def record
        Habberdash::Persistence::Mongoid::Dashboard.first || Habberdash::Persistence::Mongoid::Dashboard.new
      end

    end

  end

end
