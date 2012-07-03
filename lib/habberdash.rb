require 'habberdash/version'

require 'habberdash/persistence/base'
require 'habberdash/persistence/active_record'
require 'habberdash/persistence/redis'
require 'habberdash/persistence/mongoid'

require 'habberdash/data_adapter'

module Habberdash

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
