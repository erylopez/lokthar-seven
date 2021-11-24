source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", "~> 7.0.0.alpha2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails", "~> 0.1.0"
gem 'turbo-rails', '~> 0.8.3'
gem "stimulus-rails", ">= 0.4.0"
gem "cssbundling-rails", ">= 0.1.0"
gem "jbuilder", "~> 2.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", ">= 1.4.4", require: false
gem "discordrb", github: "shardlab/discordrb", branch: "main"
gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main'
gem 'omniauth-discord'
gem 'omniauth-rails_csrf_protection'

group :development, :test do
  gem "debug", ">= 1.0.0", platforms: %i[ mri mingw x64_mingw ]
  gem "pry"
end

group :development do
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end
