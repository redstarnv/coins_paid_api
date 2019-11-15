# frozen_string_literal: true

describe CoinsPaid::API::Signature, '#check!' do
  let(:key) { 'publickey' }
  let(:signature) { 'd2b3292793cb1f527dab4c9d8128356a0df7635aa1796a4d45276646ce914dcf29bb9244aed750a3a5b7d26aabb44ba560b05ed1233168107bed4ca684522508' }
  let(:request_body) { { key: :value }.to_json }
  subject(:check) { described_class.check!(key: key, signature: signature, request_body: request_body) }

  context 'when key and signature are valid' do
    it { is_expected.to be_truthy }
  end

  context 'when key is invalid' do
    let(:key) { 'invalidkey' }

    it 'raises invalid signature error' do
      expect { check }.to raise_error(CoinsPaid::API::InvalidSignatureError)
    end
  end

  context 'when signature is invalid' do
    let(:signature) { 'invalidsignature' }

    it 'raises invalid signature error' do
      expect { check }.to raise_error(CoinsPaid::API::InvalidSignatureError)
    end
  end
end
