source 'https://rubygems.org'

gem 'rake', '~> 10.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

### Frontend

# twitter/bootstrap
gem 'bootstrap-sass', '~> 3.3.4'

gem 'haml'
gem 'haml-rails'
gem 'jquery-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

# Pagination
gem 'kaminari'

# Image uploading
gem 'paperclip', '~> 4.2'

# Forms
gem 'simple_form', '~> 3.1.0'
gem 'cocoon', '~> 1.2.0'

### DB

# Add foreign keys in migrations
gem 'foreigner'

# Authorization
gem 'devise', '~> 3.4.0'
gem 'cancan', '~> 1.6'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Guard
group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-ctags-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'rb-fsevent', :require => false
end

# Testing
group :development do
  gem 'web-console'
end

group :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :production do
  gem 'thin'
  gem 'pg'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', '~> 2.15.0', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
