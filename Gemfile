# frozen_string_literal: true
source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'sqlite3'
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'pry-byebug'
gem 'bcrypt'
gem 'sinatra-flash'
gem 'sinatra-redirect-with-flash'
gem 'nokogiri'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem "tux"
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end
