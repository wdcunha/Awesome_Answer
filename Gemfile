# note that all the Gems defined here will be automatically required with the
# Rails application so no need to type `require 'x'`

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.4.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'faraday'
gem 'font-awesome-rails'
gem 'delayed_job_active_record'
gem 'delayed_job_web'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'  #increment encryption
gem 'jquery-rails'
gem 'chosen-rails'
gem 'bootstrap'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'carrierwave', '~> 1.0'
gem 'fog'
gem 'mini_magick'
gem 'jwt'
gem 'webpacker', '~> 3.0.0'
gem 'omniauth-github'
gem 'aasm'
gem 'devise'
gem 'activeadmin'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'cancancan'
gem 'cowsay', '~> 0.3.0'
gem 'faker', github: 'stympy/faker'
gem 'simple_form'
gem 'friendly_id', '~> 5.2.3'
gem 'geocoder'
gem 'gmaps4rails'
gem 'underscore-rails'
gem 'cocoon'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'hirb'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener', '~> 1.6.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
