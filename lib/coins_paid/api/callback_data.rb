# frozen_string_literal: true

module CoinsPaid
  module API
    class CallbackData < Dry::Struct
      NOT_CONFIRMED = 'not_confirmed'
      CANCELLED = 'cancelled'

      attribute :id, Types::Integer
      attribute? :foreign_id, Types::String
      attribute? :type, Types::String
      attribute? :status, Types::String
      attribute? :error, Types::Coercible::String

      attribute? :crypto_address do
        attribute :currency, Types::String
      end

      attribute? :transactions, Types::Array do
        attribute :transaction_type, Types::String
        attribute :type, Types::String
        attribute :id, Types::Integer
      end

      attribute? :currency_sent do
        attribute :currency, Types::String
        attribute :amount, Types::String
      end

      attribute? :currency_received do
        attribute :currency, Types::String
        attribute :amount, Types::String
        attribute? :amount_minus_fee, Types::String
      end

      def self.from_json(attributes)
        attributes[:foreign_id] ||= attributes.dig(:crypto_address, :foreign_id) || ''
        new(attributes)
      end

      def pending?
        status == NOT_CONFIRMED
      end

      def cancelled?
        status == CANCELLED
      end
    end
  end
end
