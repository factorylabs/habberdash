# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'habberdash/version'

Gem::Specification.new do |s|

  # General Gem Information
  s.name        = 'habberdash'
  s.date        = '2012-06-20'
  s.version     = Habberdash::VERSION
  s.authors     = ['Factory Design Labs']
  s.email       = ['is.team@factorylabs.com']
  s.homepage    = 'http://github.com/factory/habberdash'
  s.summary     = %Q{Habberdash: The Rails Dashboard Engine}
  s.description = %Q{Habberdash: Write dashboard widgets, and embed them within your application.}
  s.licenses    = ['MIT']

  # Runtime Dependencies
  s.add_dependency 'rails', '>= 3.2'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'

  # Development Dependencies
  s.add_development_dependency 'uglifier'

  # Testing dependencies
  s.add_development_dependency 'rspec-core', '>= 2.8.0'
  s.add_development_dependency 'evergreen', '>= 1.0.0'
  s.add_development_dependency 'selenium-webdriver', '>= 2.20.0'
  #s.add_development_dependency 'cucumber-rails', '>= 1.3.0'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-firebug', '>= 1.1.0'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'database_cleaner'

  # Gem Files
  s.extra_rdoc_files  = %w(LICENSE POST_INSTALL)
  # = MANIFEST =
  s.files             = Dir['lib/**/*', 'app/**/*', 'config/routes.rb']
  s.test_files        = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  # = MANIFEST =
  s.require_paths     = %w(lib)

end
