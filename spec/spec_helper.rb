ENV['COINS_PAID_PUBLIC_KEY'] = 'publickey'
ENV['COINS_PAID_SECRET_KEY'] = 'secretkey'

if ENV['CIRCLE_ARTIFACTS']
  require 'simplecov'
  SimpleCov.start
end

require 'webmock/rspec'
require 'pry'
require 'coins_paid_api'
Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.filter_run focus: true
  config.alias_example_to :fit, focus: true
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = 'spec/examples.txt'
end
