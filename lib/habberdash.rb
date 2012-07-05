module Habberdash
  autoload :VERSION, 'habberdash/version'
  autoload :DataAdapter, 'habberdash/data_adapter'

  module Persistence
    autoload :Base, 'habberdash/persistence/base'
  end

  module Controllers
    autoload :Helper, 'habberdash/controllers/helper'
  end

  # The canonical source for displaying available widget types to the end-user.
  #
  # Examples:
  #
  #     Habberdash.widget_types += [:facebook_stats, :my_custom_foobar]
  #
  class << self
    attr_accessor :widget_types
  end
  @widget_types ||= []

end

require 'habberdash/engine' if defined?(Rails)
require 'haml_coffee_assets'
