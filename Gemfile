source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'
gem 'rails', '~> 5.1.4'                                                           # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'mysql2', '>= 0.3.18', '< 0.5'                                                # Use mysql as the database for Active Record
gem 'puma', '~> 3.7'                                                              # Use Puma as the app server
# gem 'jbuilder', '~> 2.5'                                                        # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'redis', '~> 3.0'                                                           # Use Redis adapter to run Action Cable in production
# gem 'bcrypt', '~> 3.1.7'                                                        # Use ActiveModel has_secure_password
# gem 'capistrano-rails', group: :development                                     # Use Capistrano for deployment

# gem 'rack-cors'                                                                 # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible

gem 'validates_timeliness', '~> 4.0'                                              # Date and time validation plugin for ActiveModel and Rails. Supports multiple ORMs and allows custom date/time formats. Read more: https://github.com/adzap/validates_timeliness

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]                             # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails', '~> 3.7'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'shoulda-matchers'                                                          # Collection of testing matchers extracted from Shoulda http://matchers.shoulda.io. Read more: https://github.com/thoughtbot/shoulda-matchers
  gem 'rails-controller-testing'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'                                                                    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]                # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
