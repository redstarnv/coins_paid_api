# frozen_string_literal: true

module CoinsPaid
  module API
    class TakeAddress
      class Request < Dry::Struct
        attribute :foreign_id, Types::Coercible::String
        attribute :currency, Types::String
        attribute :convert_to, Types::String.optional

        def to_hash
          convert_value = convert_to != currency ? convert_to : nil
          super().merge(convert_to: convert_value).compact
        end
      end

      class Response < Dry::Struct
        attribute :external_id, Types::Integer
        attribute :address, Types::String
        attribute :tag, Types::Coercible::String.optional
      end

      PATH = 'addresses/take'
    end
  end
end
