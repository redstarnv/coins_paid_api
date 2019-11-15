# frozen_string_literal: true

module CoinsPaid
  module API
    module Transport
      extend self

      def post(path, params = {})
        post_request path, params.to_json
      rescue Faraday::ParsingError => e
        raise ConnectionError, e.response.body
      rescue Faraday::Error => e
        raise ConnectionError, e
      end

      private

      def post_request(path, params)
        response = http.post(path, params) do |req|
          req.headers.merge!(
            'X-Processing-Key' => API.public_key,
            'X-Processing-Signature' => Signature.generate(params)
          )
        end

        body = response.body
        response.success? ? body['data'] : raise(ProcessingError, error_message(body))
      end

      def error_message(response_body)
        response_body['error'] || response_body['errors'].values.first
      end

      def http
        Faraday.new(url: URL) do |conn|
          conn.request :json
          conn.response :json
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end
