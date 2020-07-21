source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
# gem 'sqlite3'
gem 'bootstrap-sass'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'faker'
gem 'jquery-rails', '4.3.1'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'will_paginate',           '3.1.7'
gem 'bootstrap-will_paginate', '1.0.0'
# 楽天API取得
gem 'rakuten_web_service'
# 画像
gem 'carrierwave', '1.2.2'
gem "mini_magick", '>= 4.9.4'
# GoogleMap
gem "gmaps4rails"

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0.beta2'
  gem 'rails-controller-testing'
  gem 'rubocop-airbnb'
  gem "factory_bot_rails", "~> 4.10.0"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem "pry"
  gem 'bullet'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'devise'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'ransack'

group :production do # 本番環境
  gem 'pg' # PostgreSQL
  gem 'fog', '1.42'
end
