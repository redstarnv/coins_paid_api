ENV['COINS_PAID_PUBLIC_KEY'] = 'publickey'
ENV['COINS_PAID_SECRET_KEY'] = 'secretkey'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'webmock/rspec'
require 'pry'
require 'coins_paid_api'
Dir['./spec/support/**/*.rb'].each { |f| require f }
