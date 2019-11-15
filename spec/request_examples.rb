# frozen_string_literal: true

RSpec.shared_context 'CoinsPaid API request' do |request_data: {}|
  let(:signature) { 'c01dc0ffee' }
  let(:request_signature_headers) do
    {
      'X-Processing-Key' => described_class.public_key,
      'X-Processing-Signature' => signature
    }
  end

  before do
    allow(CoinsPaid::API::Signature).to receive(:generate).with(request_data.to_json).and_return signature
  end
end

RSpec.shared_examples 'CoinsPaid API error handling' do |endpoint:, request_body: '{}'|
  context 'when coins paid responded with validation errors' do
    let(:response_data) do
      {
        'errors' => {
          'field' => 'This field is wrong'
        }
      }
    end

    before do
      stub_request(:post, endpoint)
        .with(body: request_body)
        .to_return(status: 400, body: response_data.to_json)
    end

    it 'raises processing error' do
      expect { subject }.to raise_error(CoinsPaid::API::ProcessingError, 'This field is wrong')
    end
  end

  context 'when coins paid responded with authorization error' do
    let(:response_data) do
      {
        'error' => 'Bad signature header',
        'code' => 'bad_header_signature'
      }
    end

    before do
      stub_request(:post, endpoint)
        .with(body: request_body)
        .to_return(status: 403, body: response_data.to_json)
    end

    it 'raises processing error' do
      expect { subject }.to raise_error(CoinsPaid::API::ProcessingError, 'Bad signature header')
    end
  end

  context 'when coins paid responds with internal server error' do
    let(:response_data) { 'Internal server error' }

    before do
      stub_request(:post, endpoint)
        .to_return(status: 500, body: response_data)
    end

    it 'raises processing error' do
      expect { subject }.to raise_error(CoinsPaid::API::ConnectionError, 'Internal server error')
    end
  end

  context 'when request timeout' do
    before do
      stub_request(:post, endpoint)
        .to_timeout
    end

    it 'raises connection error' do
      expect { subject }.to raise_error(CoinsPaid::API::ConnectionError, 'execution expired')
    end
  end
end
