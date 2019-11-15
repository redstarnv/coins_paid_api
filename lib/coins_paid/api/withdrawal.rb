# frozen_string_literal: true

module CoinsPaid
  module API
    class Withdrawal
      class Request < Dry::Struct
        attribute :foreign_id, Types::Coercible::String
        attribute :amount, Types::Coercible::String
        attribute :currency, Types::String
        attribute :convert_to, Types::String
        attribute :address, Types::String
      end

      class Response < Dry::Struct
        attribute :external_id, Types::Integer
        attribute :receiver_amount, Types::Coercible::Float
      end

      PATH = 'withdrawal/crypto'
    end
  end
end
