module Habberdash

  module Persistence

    class Base
      attr_accessor :errors

      def initialize
        @errors = []
      end

      def add_error(message)
        self.errors << message
      end

    end

  end

end
