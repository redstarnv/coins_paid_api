# frozen_string_literal: true

require_relative './request_examples'

describe CoinsPaid::API, '.take_address' do
  let(:endpoint) { 'https://app.coinspaid.com/api/v2/addresses/take' }

  let(:foreign_id) { 'user-id:2048' }
  let(:currency) { 'BTC' }

  let(:request_data) do
    { foreign_id: foreign_id, currency: currency, convert_to: api_convert_to }.compact
  end
  let(:request_body) { request_data.to_json }

  include_context 'CoinsPaid API request'

  let(:response_data) do
    {
      'data' => {
        'id' => 1,
        'currency' => 'BTC',
        'convert_to' => api_convert_to,
        'address' => '12983h13ro1hrt24it432t',
        'tag' => 123,
        'foreign_id' => 'user-id:2048'
      }.compact
    }
  end

  let(:args) do
    { foreign_id: 'user-id:2048', currency: 'BTC', convert_to: args_convert_to }.compact
  end
  subject(:take_address) { described_class.take_address(args) }

  shared_examples 'successful request' do
    it 'returns valid response' do
      stub_request(:post, endpoint)
        .with(body: request_body, headers: request_signature_headers)
        .to_return(status: 201, body: response_data.to_json)

      expected_address_attributes = {
        external_id: 1,
        address: '12983h13ro1hrt24it432t',
        tag: '123'
      }
      expect(take_address).to be_struct_with_params(
        CoinsPaid::API::TakeAddress::Response, expected_address_attributes
      )
    end
  end

  context 'with explicit convert_to not matching address currency' do
    let(:args_convert_to) { 'EUR' }
    let(:api_convert_to) { 'EUR' }
    it_behaves_like 'successful request'
    it_behaves_like 'CoinsPaid API error handling'
  end

  context 'with explicit convert_to matching address currency' do
    let(:args_convert_to) { 'BTC' }
    let(:api_convert_to) { nil }
    it_behaves_like 'successful request'
  end

  context 'with nil convert_to' do
    let(:args_convert_to) { nil }
    let(:api_convert_to) { nil }
    it_behaves_like 'successful request'
  end
end
