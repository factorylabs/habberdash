require 'rails'

module Habberdash
  class Engine < ::Rails::Engine

    # Additional application configuration to include precompiled assets.
    initializer :assets, :group => :all do |app|
      app.config.assets.precompile += %w(habberdash.js habberdash.css)
    end

    # Require so things can be overridden.
    initializer 'habberdash.add_lib' do |app|
      #require 'habberdash/some_lib'
    end

  end
end
