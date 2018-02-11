source 'https://rubygems.org'

ruby '2.3.1'

# rails
gem 'rails', '~> 5.2.beta'
gem 'responders'

# app server
gem 'puma'

# db
gem 'pg'
gem 'redis'

# slugs
gem 'friendly_id'

# pagination
gem 'kaminari'

# authentication
gem 'devise'
gem 'devise_invitable'

# authorization
gem 'access-granted'

# file uploading
gem 'fog-aws', github: 'fog/fog-aws'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'
gem 'aws-sdk-s3', require: false

# assets
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap', '~> 4.0.0'
gem 'ckeditor'
gem 'simple_form'
gem "bootstrap_form",
    git: "https://github.com/bootstrap-ruby/rails-bootstrap-forms.git",
    branch: "master"
gem 'bootstrap-switch-rails'
gem 'font-awesome-sass'
gem 'font-awesome-rails'
gem 'chartkick'

gem 'webpacker', '~> 3.0'

# json
gem 'jbuilder'

# ical
gem 'icalendar'

# error tracking
gem 'raygun4ruby'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-puma', require: false
  # gem 'bullet'
  gem 'guard-rspec', require: false
  gem 'listen'
  gem 'rails_best_practices', require: false
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
end
