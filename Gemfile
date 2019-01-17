# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'enum_help'
gem 'jbuilder', '~> 2.5'
gem 'kaminari', '~> 1.0'
gem 'turbolinks', '~> 5'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'bcrypt', '3.1.11'

gem 'bullet'
gem 'ransack'

gem 'dotenv'

gem 'simple_calendar'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'rubocop', '~> 0.55.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
end

gem 'squasher'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
