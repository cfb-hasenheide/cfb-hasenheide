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
# NOTE: using devise_invitable master, because of:
# undefined method `attributes_for' for class `Devise::ParameterSanitizer' (NameError)
# Did you mean?  attr_writer
#   from /Users/elgrillo/.rvm/gems/ruby-2.3.0/gems/activesupport-4.2.6/lib/active_support/core_ext/module/aliasing.rb:32:in `alias_method_chain'
gem 'devise_invitable', github: 'scambra/devise_invitable'

# authorization
gem 'access-granted'

# file uploading
gem 'fog-aws', github: 'fog/fog-aws'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'

# assets
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap', '~> 4.0.0.alpha6'
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
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
end
