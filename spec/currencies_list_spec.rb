# frozen_string_literal: true

require_relative './request_examples'

describe CoinsPaid::API, '.currencies_list' do
  endpoint = 'https://app.coinspaid.com/api/v2/currencies/list'
  include_context 'CoinsPaid API request'

  let(:expected_currencies) do
    [
      {
        currency: 'BTC',
        deposit_fee_percent: 0.008,
        id: 1,
        minimum_amount: 0.0001,
        precision: 8,
        type: 'crypto',
        withdrawal_fee_percent: 0.0
      },
      {
        currency: 'LTC',
        deposit_fee_percent: 0.008,
        id: 2,
        minimum_amount: 0.01,
        precision: 8,
        type: 'crypto',
        withdrawal_fee_percent: 0.0
      }
    ]
  end

  subject(:response) { described_class.currencies_list }

  let(:response_data) do
    {
      'data' => [
        {
          'currency' => 'BTC',
          'deposit_fee_percent' => '0.008',
          'id' => 1,
          'minimum_amount' => '0.00010000',
          'precision' => 8,
          'type' => 'crypto',
          'withdrawal_fee_percent' => '0'
        },
        {
          'currency' => 'LTC',
          'deposit_fee_percent' => '0.008',
          'id' => 2,
          'minimum_amount' => '0.01000000',
          'precision' => 8,
          'type' => 'crypto',
          'withdrawal_fee_percent' => '0'
        }
      ]
    }
  end

  it 'returns valid response if successful' do
    stub_request(:post, endpoint)
      .with(body: '{}', headers: request_signature_headers)
      .to_return(status: 200, body: response_data.to_json)

    currencies = expected_currencies.map { |data| be_struct_with_params(described_class::Currency, data) }
    expect(response).to match_array currencies
  end

  it_behaves_like 'CoinsPaid API error handling', endpoint: endpoint
end
