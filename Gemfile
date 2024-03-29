source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.7'
gem 'activerecord-postgresql-adapter'
gem 'jquery-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'pry'
end

group :production do
  gem 'newrelic_rpm'
  gem 'thin' # so heroku doesn't use webrick
end

group :test do
  gem 'minitest-rails'
  gem 'minitest-capybara'
  gem 'minitest-metadata'
  gem 'minitest-matchers'
  gem 'miniskirt'
  gem 'selenium-webdriver'
  gem 'turn'
  gem 'sqlite3'
  gem 'vcr'
  gem 'webmock'
  gem 'launchy'
  gem 'database_cleaner'
end

group :development do
  gem 'hpricot'     # dep of html2haml
  gem 'ruby_parser' # dep of html2haml
end

gem 'haml'
gem 'haml-rails'

gem 'font-awesome-rails'
gem 'colorbox-rails'
gem 'bootstrap-sass'

gem 'devise'
gem 'cancan'

gem 'simple_form'

gem 'paperclip'
gem 'jquery-fileupload-rails'
gem 'rubyzip'
gem 'aws-sdk'

gem 'rest-client'

gem 'acts_as_list'

gem 'jquery-datatables-rails'
gem 'will_paginate'

gem 'date_validator'

gem 'ancestry'

gem 'friendly_id'
