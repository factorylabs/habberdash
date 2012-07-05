module Habberdash

  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path("../templates", __FILE__)

    def source_paths
      [File.expand_path("../templates", __FILE__), Habberdash::Engine.root]
    end

    def setup
      @post_install = []
    end

    def choose_orm
      orm_question = "Do you want to use ActiveRecord, Mongoid (>= v3.0.0), or Redis? (type 'ar', 'm', or 'r' respectively)"

      orm = ask orm_question, :cyan

      while ! %w(ar m r).include? orm do
        puts ""
        say "Please choose one of 'ar', 'm', or 'r'", :red
        orm = ask orm_question, :yellow
      end

      write_orm(orm)
    end

    def mount_habberdash
      if !(File.read('config/routes.rb') =~ /mount Habberdash::Engine/)
        inject_into_file 'config/routes.rb', "\n\n  mount Habberdash::Engine, at: '/' # This mounts Habberdash at root. Change if necessary.", after: /.*::Application.routes.draw do/i
      end
      @post_install << "see your config/routes.rb file. Habberdash has been mounted at root ('/') by default. Change this if necessary."
    end

    def copy_controller_helper
      copy_file 'lib/habberdash/controllers/helper.rb'
      @post_install << "see lib/habberdash/controllers/helper.rb for how to override the default access control mechanism"
    end

    def post_install
      if @post_install.any?
        say <<-POSTINSTALL, :green

Post-install notes:

#{@post_install.map { |m| "- #{m}" }.join("\n")}
        POSTINSTALL
      end
    end

    ########################################################################
    private
    ########################################################################

    def write_orm(choice)
      requires = {
        "ar" => "habberdash/active_record",
        "m" => "habberdash/mongoid",
        "r" => "habberdash/redis"
      }

      copy_file 'initializer.rb', 'config/initializers/habberdash.rb'
      prepend_to_file "config/initializers/habberdash.rb", <<-ORMREQUIRE
# Require a Habberdash persistence adapter.
# Can be one of: 'habberdash/active_record', 'habberdash/mongoid', 'habberdash/redis'

require '#{requires[choice]}'

      ORMREQUIRE

      if choice == "ar"
        if existing_migration = self.class.migration_exists?('db/migrate', 'create_habberdash_dashboard.habberdash')
          if yes? "Existing migration found. Overwrite? [yn]", :yellow
            remove_file existing_migration
            migration_template "migration.rb", "db/migrate/create_habberdash_dashboard.habberdash.rb", force: true
          end
        else
          migration_template "migration.rb", "db/migrate/create_habberdash_dashboard.habberdash.rb", force: true
        end
        @post_install << "run `rake db:migrate` to create the habberdash db table"
      end
    end

    # Implement the required interface for Rails::Generators::Migration.
    def self.next_migration_number(dirname) #:nodoc:
      require 'rails/generators/active_record'
      ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

  end

end
