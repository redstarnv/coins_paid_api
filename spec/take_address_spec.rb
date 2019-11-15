# frozen_string_literal: true

require_relative './request_examples'

describe CoinsPaid::API, '.take_address' do
  endpoint = 'https://app.coinspaid.com/api/v2/addresses/take'
  request_data = {
    foreign_id: 'user-id:2048',
    currency: 'BTC',
    convert_to: 'EUR'
  }
  include_context 'CoinsPaid API request', request_data: request_data

  let(:expected_address_attributes) do
    {
      external_id: 1,
      address: '12983h13ro1hrt24it432t',
      tag: 'tag-123'
    }
  end
  subject(:take_address) { described_class.take_address(request_data) }

  let(:response_data) do
    {
      'data' => {
        'id' => 1,
        'currency' => 'BTC',
        'convert_to' => 'EUR',
        'address' => '12983h13ro1hrt24it432t',
        'tag' => 'tag-123',
        'foreign_id' => 'user-id:2048'
      }
    }
  end

  it 'returns valid response if successful' do
    stub_request(:post, endpoint)
      .with(body: request_data, headers: request_signature_headers)
      .to_return(status: 201, body: response_data.to_json)

    expect(take_address).to be_struct_with_params(CoinsPaid::API::TakeAddress::Response, expected_address_attributes)
  end

  it_behaves_like 'CoinsPaid API error handling', endpoint: endpoint, request_body: request_data
end
