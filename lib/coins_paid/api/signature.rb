# frozen_string_literal: true

module CoinsPaid
  module API
    module Signature
      module_function

      def check!(request_body:, key:, signature:)
        key == API.public_key && signature == generate(request_body) ||
          raise(InvalidSignatureError, 'Invalid signature')
      end

      def generate(request_body)
        OpenSSL::HMAC.hexdigest('SHA512', API.secret_key, request_body)
      end
    end
  end
end
