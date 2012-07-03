# This file is simply a helper for setting the persistence strategy in your
# app.
#
# Example:
#
# Inside of config/application.rb, add the following:
#
#     require 'habberdash/mongoid'
#
require 'habberdash'
require 'habberdash/persistence/mongoid'

Habberdash::DataAdapter.persistence_strategy = Habberdash::Persistence::Mongoid
