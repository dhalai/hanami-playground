source 'https://rubygems.org'

ruby '2.5.1'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'

gem 'pg'
gem 'bcrypt'

gem 'sass'
gem 'bootstrap', '~> 4.1.3'

group :development do
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
  gem 'rubocop'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
  gem 'puma'
end
