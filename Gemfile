source 'https://rubygems.org'

ruby '2.3.0'

# rails 4
gem 'rails'
gem 'responders'

# db
gem 'pg'

# slugs
gem 'friendly_id'

# pagination
gem 'kaminari'

# authorization
gem 'devise'
gem 'devise_invitable', github: 'scambra/devise_invitable'
# NOTE: using devise_invitable master, because of:
# undefined method `attributes_for' for class `Devise::ParameterSanitizer' (NameError)
# Did you mean?  attr_writer
#   from /Users/elgrillo/.rvm/gems/ruby-2.3.0/gems/activesupport-4.2.6/lib/active_support/core_ext/module/aliasing.rb:32:in `alias_method_chain'

# file uploading
gem 'fog-aws'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'

# assets
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'bootstrap-wysihtml5-rails'
gem 'simple_form'
gem 'bootstrap_form'
# NOTE: https://github.com/bootstrap-ruby/rails-bootstrap-forms#nested-forms
gem 'nested_form'
gem 'bootstrap-switch-rails'
gem 'font-awesome-sass'
gem "font-awesome-rails"

# json
gem 'jbuilder'

# ical
gem 'icalendar'

# error tracking
gem 'raygun4ruby'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard-rspec', require: false
  gem 'web-console'
  gem 'rubocop'
  gem 'rails_best_practices'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

group :production do
  # heroku
  gem 'rails_12factor'
end
