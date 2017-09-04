source 'https://rubygems.org'

git_source(:github) { |name| "https://github.com/#{name}.git" }

ruby '2.4.1'

# rails
gem 'rails', '~> 5.0'
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
gem 'fog-aws'
gem 'carrierwave'
gem 'mini_magick'

# assets
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap', '~> 4.0.0.beta'
# Bootstrap 4 tooltips and popovers denpent on tether for positioning
source 'https://rails-assets.org' do
    gem 'rails-assets-tether', '>= 1.1.0'
end
gem 'ckeditor'
gem 'simple_form'
gem 'bootstrap_form', github: 'bootstrap-ruby/rails-bootstrap-forms', branch: 'bootstrap-v4'
# NOTE: https://github.com/bootstrap-ruby/rails-bootstrap-forms#nested-forms
gem 'nested_form'
gem 'bootstrap-switch-rails'
gem 'font-awesome-sass'
gem 'font-awesome-rails'
gem 'chartkick'

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
