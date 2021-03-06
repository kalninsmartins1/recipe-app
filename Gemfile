source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Get quick ready made templates
gem 'bootstrap', '~> 4.3.1'
# Bootstrap JavaScript depends on jQuery.
gem 'jquery-rails'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Provides secure password authentication
gem 'bcrypt', '~> 3.1.7'
# Provides multiple page selection for object listings
gem 'will_paginate', '>= 3.1.7'
gem 'bootstrap-will_paginate', '>= 1.0.0'
# Provides graphql functionality
gem 'graphql', '1.8.13'
# Provides graphql searching
gem 'search_object', '1.2.0'
gem 'search_object_graphql', '0.1'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', git: 'https://github.com/larskanis/sqlite3-ruby', branch: 'add-gemspec'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'action-cable-testing'

  # For creating test data
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'rubocop', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper', '1.2.0'

  # For testing active record validations
  gem 'shoulda-matchers'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'graphiql-rails', '1.5.0', group: :development
