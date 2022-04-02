# frozen_string_literal: true

require_relative './request_examples'

RSpec.shared_examples 'CoinsPaid API withdrawal' do
  let(:endpoint) { 'https://app.coinspaid.com/api/v2/withdrawal/crypto' }

  include_context 'CoinsPaid API request'

  let(:response_data) do
    {
      'data' => {
        'id' => 1,
        'foreign_id' => 'user-id:2048',
        'type' => 'withdrawal',
        'status' => 'processing',
        'amount' => '10.00000000',
        'sender_amount' => '10.00000000',
        'sender_currency' => 'EUR',
        'receiver_amount' => '0.00100000',
        'receiver_currency' => 'BTC'
      }
    }
  end
  let(:expected_withdrawal_attributes) do
    {
      external_id: 1,
      receiver_amount: 0.001
    }
  end
  subject(:withdraw) { described_class.withdraw(request_data) }

  context 'when response is successful' do
    before do
      stub_request(:post, endpoint)
        .with(body: request_data, headers: request_signature_headers)
        .to_return(status: 201, body: response_data.to_json)
    end

    it 'returns valid response' do
      expect(withdraw).to be_struct_with_params(CoinsPaid::API::Withdrawal::Response, expected_withdrawal_attributes)
    end
  end
end

describe CoinsPaid::API, '.withdraw' do
  let(:base_request_data) do
    {
      foreign_id: 'user-id:2048',
      amount: '0.01',
      currency: 'BTC',
      address: 'abc123'
    }
  end
  let(:request_body) { request_data.to_json }

  context 'request does not include tag parameter or convert_to' do
    let(:request_data) { base_request_data }
    it_behaves_like 'CoinsPaid API withdrawal'
  end

  context 'request includes tag parameter' do
    let(:request_data) { base_request_data.merge(tag: 'thetag') }
    it_behaves_like 'CoinsPaid API withdrawal'
  end

  context 'request includes convert_to' do
    let(:request_data) { base_request_data.merge(currency: 'EUR', convert_to: 'BTC') }
    it_behaves_like 'CoinsPaid API withdrawal'
  end
end
