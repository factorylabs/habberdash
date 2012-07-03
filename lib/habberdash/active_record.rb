# This file is simply a helper for setting the persistence strategy in your
# app.
#
# Example:
#
# Inside of config/application.rb, add the following:
#
#     require 'habberdash/active_record'
#
require 'habberdash'
require 'habberdash/persistence/active_record'

Habberdash::DataAdapter.persistence_strategy = Habberdash::Persistence::ActiveRecord
