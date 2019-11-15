# frozen_string_literal: true

module CoinsPaid
  module API
    class Currency < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Types::Integer
      attribute :type, Types::String
      attribute :currency, Types::String
      attribute :minimum_amount, Types::JSON::Decimal
      attribute :deposit_fee_percent, Types::JSON::Decimal
      attribute :withdrawal_fee_percent, Types::JSON::Decimal
      attribute :precision, Types::Integer
    end
  end
end
