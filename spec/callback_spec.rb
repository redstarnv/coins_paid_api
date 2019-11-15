# frozen_string_literal: true

describe CoinsPaid::API, '.callback' do
  include_context 'coins paid callbacks'
  let(:key) { double 'key' }
  let(:signature) { double 'signature' }
  let(:headers) { { 'X-Processing-Key' => key, 'X-Processing-Signature' => signature } }
  subject(:callback) { described_class.callback(request_body, headers) }

  before do
    allow(CoinsPaid::API::Signature).to receive(:check!).with(request_body: request_body, key: key, signature: signature)
  end

  context 'when signature is invalid' do
    let(:request_body) { { key: :value }.to_json }

    before do
      allow(CoinsPaid::API::CallbackData).to receive(:new)
      allow(CoinsPaid::API::Signature).to receive(:check!).with(request_body: request_body, key: key, signature: signature).and_raise('error')
    end

    it 'raises error' do
      expect { callback }.to raise_error('error')

      expect(CoinsPaid::API::CallbackData).not_to have_received(:new)
    end
  end

  context 'when request_body is deposit callback data' do
    let(:request_body) { deposit_callback_body.to_json }
    let(:expected_params) do
      {
        id: 2686510,
        foreign_id: '1234',
        type: 'deposit_exchange',
        status: 'confirmed',
        error: '',
        crypto_address: {
          currency: 'BTC'
        },
        transactions: [
          { transaction_type: 'blockchain', id: 714576 },
          { transaction_type: 'exchange', id: 714577 },
        ],
        currency_sent: { amount: '0.01000000' },
        currency_received: {
          amount_minus_fee: '90',
          amount: '84.17070222'
        }
      }
    end

    it { is_expected.to be_struct_with_params(CoinsPaid::API::CallbackData, expected_params) }
  end

  context 'when request_body is cancelled deposit callback data' do
    let(:request_body) { cancelled_deposit_callback_body.to_json }
    let(:expected_params) do
      {
        id: 2686510,
        foreign_id: '1234',
        type: 'deposit_exchange',
        status: 'cancelled',
        error: 'Invalid params: expected a hex-encoded hash with 0x prefix.',
        crypto_address: {
          currency: 'BTC'
        },
        transactions: [
          { transaction_type: 'blockchain', id: 714576 },
          { transaction_type: 'exchange', id: 714577 },
        ]
      }
    end

    it { is_expected.to be_struct_with_params(CoinsPaid::API::CallbackData, expected_params) }
  end

  context 'when request_body is withdrawal callback data' do
    let(:request_body) { withdrawal_callback_body.to_json }
    let(:expected_params) do
      {
        id: 1,
        type: 'withdrawal_exchange',
        status: 'confirmed',
        foreign_id: '20',
        error: '',
        crypto_address: {
          currency: 'EUR'
        },
        transactions: [
          { transaction_type: 'exchange', id: 1 },
          { transaction_type: 'blockchain', id: 1 },
        ],
        currency_sent: { amount: '381' },
        currency_received: {
          amount: '0.01000000'
        }
      }
    end

    it { is_expected.to be_struct_with_params(CoinsPaid::API::CallbackData, expected_params) }
  end

  context 'when request_body is cancelled withdrawal callback data' do
    let(:request_body) { cancelled_withdrawal_callback_body.to_json }
    let(:expected_params) do
      {
        id: 2686510,
        type: 'withdrawal_exchange',
        status: 'cancelled',
        foreign_id: '20',
        error: 'Invalid params: expected a hex-encoded hash with 0x prefix.',
        crypto_address: {
          currency: 'EUR'
        },
        transactions: [
          { transaction_type: 'exchange', id: 714576 },
          { transaction_type: 'blockchain', id: 714577 },
        ]
      }
    end

    it { is_expected.to be_struct_with_params(CoinsPaid::API::CallbackData, expected_params) }
  end
end
