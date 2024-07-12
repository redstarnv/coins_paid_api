# frozen_string_literal: true

module CoinsPaid
  module API
    class Withdrawal
      class Request < Dry::Struct
        attribute :foreign_id, Types::Coercible::String
        attribute :amount, Types::Coercible::String
        attribute :currency, Types::String
        attribute :address, Types::String
        attribute? :convert_to, Types::String
        attribute? :tag, Types::String
      end

      class Response < Dry::Struct
        attribute :external_id, Types::Integer
      end

      PATH = 'withdrawal/crypto'
    end
  end
end
