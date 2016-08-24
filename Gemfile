source 'https://rubygems.org'

ruby '2.3.1'

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
gem 'bootstrap-sass'
gem 'ckeditor'
gem 'simple_form'
gem 'bootstrap_form'
# NOTE: https://github.com/bootstrap-ruby/rails-bootstrap-forms#nested-forms
gem 'nested_form'
gem 'bootstrap-switch-rails'
gem 'font-awesome-sass'
gem 'font-awesome-rails'

# json
gem 'jbuilder'

# ical
gem 'icalendar'

# error tracking
gem 'raygun4ruby'

group :development do
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

group :production do
  # heroku
  gem 'rails_12factor'
end
