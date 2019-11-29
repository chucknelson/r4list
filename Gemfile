source 'https://rubygems.org'

#use specific version of ruby
ruby '2.3.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Using 4.1.x versions (don't want to automatically update to 4.x)
gem 'rails', '~> 4.2.0'

group :development do
  # cool interactive console that can be used if a page errors out
  gem 'web-console', '3.3.0' # last release with Rails 4.2 support
end

# Use SimpleCov for test coverage
group :test do
  gem 'simplecov', '~> 0.17', :require => false
end

# Use debugger
# gem 'debugger', group: [:development, :test]

group :production do
	gem 'rails_12factor' #required for heroku rails 4 asset pipeline compatability
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.3.0', :group => :test

# Use postgres as the database to minimize compatability issues with Heroku
gem 'pg', '~> 0.21'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 4.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0'
gem 'jquery-ui-rails', '~> 4.0'

#jquery UI touch punch to enable sorting on the iPhone / touch screens
gem 'touchpunch-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# gem to allow jquery binding to work easily with turbolinks
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.0'

# Use puma for app server
gem 'puma'
