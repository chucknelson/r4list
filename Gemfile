source 'https://rubygems.org'

#use specific version of ruby
ruby '2.3.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Using 4.1.x versions (don't want to automatically update to 4.x)
gem 'rails', '~> 4.2.0'

group :production do
	gem 'rails_12factor' #required for heroku rails 4 asset pipeline compatability
end

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.3.0', :group => :test

# Use postgres as the database to minimize compatability issues with Heroku
gem 'pg', '~> 0.18.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.0'
gem 'jquery-ui-rails', '~> 4.0'

#jquery UI touch punch to enable sorting on the iPhone / touch screens
gem 'touchpunch-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# gem to allow jquery binding to work easily with turbolinks
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# Stick with 3.x version
gem 'bcrypt-ruby', '~> 3.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use thin as the app server
gem 'thin', '~> 1.6.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Use SimpleCov for test coverage
gem 'simplecov', '~> 0.15.0', :require => false, :group => :test
