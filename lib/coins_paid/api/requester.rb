# frozen_string_literal: true

module CoinsPaid
  module API
    module Requester
      extend self

      def call(api, data)
        request_data = api::Request.new(data)
        Transport.post(api::PATH, request_data.to_hash)
          .yield_self { |response| parse(response) }
          .yield_self { |parsed_response| api::Response.new(parsed_response) }
      end

      private

      def parse(response)
        response.transform_keys { |key| key.to_s == 'id' ? :external_id : key.to_sym }
      end
    end
  end
end
