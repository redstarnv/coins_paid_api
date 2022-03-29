# frozen_string_literal: true
require 'dry-struct'
require 'json'
require 'faraday'
require 'faraday_middleware'
require_relative 'api/types'
require_relative 'api/signature'
require_relative 'api/requester'
require_relative 'api/transport'
require_relative 'api/callback_data'
require_relative 'api/currencies_list'
require_relative 'api/take_address'
require_relative 'api/withdrawal'

module CoinsPaid
  module API
    module_function

    Error = Class.new RuntimeError
    ProcessingError = Class.new Error
    ConnectionError = Class.new Error
    InvalidSignatureError = Class.new Error

    URL = 'https://app.coinspaid.com/api/v2/'

    class << self
      attr_accessor :public_key
      attr_accessor :secret_key
    end

    @public_key = ENV['COINS_PAID_PUBLIC_KEY']
    @secret_key = ENV['COINS_PAID_SECRET_KEY']

    def configure
      yield self
    end

    def take_address(foreign_id:, currency:, convert_to: nil)
      Requester.call(
        TakeAddress,
        foreign_id: foreign_id, currency: currency, convert_to: convert_to
      )
    end

    def withdraw(data)
      Requester.call(Withdrawal, data)
    end

    def currencies_list
      CurrenciesList.call
    end

    def callback(request_body, headers)
      Signature.check!(
        request_body: request_body,
        key: headers['X-Processing-Key'],
        signature: headers['X-Processing-Signature']
      )

      CallbackData.from_json(JSON.parse(request_body, symbolize_names: true))
    end
  end
end
