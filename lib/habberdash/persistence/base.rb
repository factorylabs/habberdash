module Habberdash

  module Persistence

    # The base class for use by persistence adapter classes.
    #
    class Base
      attr_accessor :errors

      # Initializes the @errors collection.
      #
      def initialize
        @errors = []
      end

      # Adds an error to the errors collection.
      #
      # Examples:
      #
      #     adapter.add_error("Some important error message")
      #
      def add_error(message)
        self.errors << message
      end

    end

  end

end
