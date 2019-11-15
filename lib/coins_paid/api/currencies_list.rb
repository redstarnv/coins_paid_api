# frozen_string_literal: true
require_relative 'currency'

module CoinsPaid
  module API
    module CurrenciesList
      module_function

      class Response < Dry::Struct
        attribute :data, Types::Array.of(Currency)
      end

      PATH = 'currencies/list'

      def call
        Response.new(data: Transport.post(PATH)).data
      end
    end
  end
end
