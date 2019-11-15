shared_context 'coins paid callbacks' do
  let(:deposit_callback_body) do
    {
      'id' => 2686510,
      'type' => 'deposit_exchange',
      'crypto_address' => {
        'id' => 382270,
        'currency' => 'BTC',
        'convert_to' => 'EUR',
        'address' => '123abc',
        'tag' => nil,
        'foreign_id' => '1234'
      },
      'currency_sent' => {
        'currency' => 'BTC',
        'amount' => '0.01000000'
      },
      'currency_received' => {
        'currency' => 'EUR',
        'amount' => '84.17070222',
        'amount_minus_fee' => '90'
      },
      'transactions' => [
        {
          'id' => 714576,
          'currency' => 'BTC',
          'transaction_type' => 'blockchain',
          'type' => 'deposit',
          'address' => '31vnLqxVJ1iShJ5Ly586q8XKucECx12bZS',
          'tag' => nil,
          'amount' => '0.01000000',
          'txid' => '3a491da90a1ce5a318d0aeff6867ab98a03219abae29ed68d702291703c3538b',
          'riskscore' => '0.42',
          'confirmations' => '1'
        },
        {
          'id' => 714577,
          'currency' => 'BTC',
          'currency_to' => 'EUR',
          'transaction_type' => 'exchange',
          'type' => 'exchange',
          'amount' => '0.01000000',
          'amount_to' => '84.17070222'
        }
      ],
      'fees' => [
        {
          'type' => 'exchange',
          'currency' => 'EUR',
          'amount' => '4.20853511'
        }
      ],
      'error' => nil,
      'status' => 'confirmed'
    }
  end

  let(:cancelled_deposit_callback_body) do
    {
      'id' => 2686510,
      'type' => 'deposit_exchange',
      'crypto_address' => {
        'id' => 382270,
        'currency' => 'BTC',
        'convert_to' => 'EUR',
        'address' => '123abc',
        'tag' => nil,
        'foreign_id' => '1234'
      },
      'transactions' => [
        {
          'id' => 714576,
          'currency' => 'BTC',
          'transaction_type' => 'blockchain',
          'type' => 'deposit',
          'address' => '31vnLqxVJ1iShJ5Ly586q8XKucECx12bZS',
          'tag' => nil,
          'amount' => '0.01000000',
          'txid' => '3a491da90a1ce5a318d0aeff6867ab98a03219abae29ed68d702291703c3538b',
          'riskscore' => '0.42',
          'confirmations' => '1'
        },
        {
          'id' => 714577,
          'currency' => 'BTC',
          'currency_to' => 'EUR',
          'transaction_type' => 'exchange',
          'type' => 'exchange',
          'amount' => '0.01000000',
          'amount_to' => '84.17070222'
        }
      ],
      'fees' => [
        {
          'type' => 'exchange',
          'currency' => 'EUR',
          'amount' => '4.20853511'
        }
      ],
      'error' => 'Invalid params: expected a hex-encoded hash with 0x prefix.',
      'status' => 'cancelled'
    }
  end

  let(:withdrawal_callback_body) do
    {
      'id' => 1,
      'foreign_id' => '20',
      'type' => 'withdrawal_exchange',
      'crypto_address' => {
        'id' => 1,
        'currency' => 'EUR',
        'convert_to' => 'BTC',
        'address' => '1k2btnz8cqnfbphaq729mdj8w6g3w2nbbl',
        'tag' => nil
      },
      'currency_sent' => {
        'currency' => 'EUR',
        'amount' => '381'
      },
      'currency_received' => {
        'currency' => 'BTC',
        'amount' => '0.01000000'
      },
      'transactions' => [
        {
          'id' => 1,
          'currency' => 'EUR',
          'currency_to' => 'BTC',
          'transaction_type' => 'exchange',
          'type' => 'exchange',
          'amount' => 381,
          'amount_to' => 0.108823
        },
        {
          'id' => 1,
          'currency' => 'BTC',
          'transaction_type' => 'blockchain',
          'type' => 'withdrawal',
          'address' => '1k2btnz8cqnfbphaq729mdj8w6g3w2nbbl',
          'tag' => nil,
          'amount' => 0.108823,
          'txid' => 'aa3345b96389e126f1ce88a670d1b1e38f2c3f73fb3ecfff8d9da1b1ce6964a6',
          'confirmations' => 3
        }
      ],
      'fees' => [
        {
          'type' => 'exchange',
          'currency' => 'EUR',
          'amount' => '3.04800000'
        },
        {
          'type' => 'mining',
          'currency' => 'BTC',
          'amount' => '0.00003990'
        }
      ],
      'error' => '',
      'status' => 'confirmed'
    }
  end

  let(:cancelled_withdrawal_callback_body) do
    {
      'id' => 2686510,
      'type' => 'withdrawal_exchange',
      'foreign_id' => '20',
      'crypto_address' => {
        'id' => 382270,
        'currency' => 'EUR',
        'address' => '1k2btnz8cqnfbphaq729mdj8w6g3w2nbbl',
        'tag' => nil
      },
      'transactions' => [
        {
          'id' => 714576,
          'currency' => 'BTC',
          'currency_to' => 'EUR',
          'transaction_type' => 'exchange',
          'type' => 'exchange',
          'amount' => '0.01000000',
          'amount_to' => '84.17070222'
        },
        {
          'id' => 714577,
          'currency' => 'BTC',
          'transaction_type' => 'blockchain',
          'type' => 'withdrawal',
          'address' => '31vnlqxvj1ishj5ly586q8xkucecx12bzs',
          'tag' => nil,
          'amount' => '0.01000000',
          'txid' => '3a491da90a1ce5a318d0aeff6867ab98a03219abae29ed68d702291703c3538b',
          'confirmations' => '0'
        }
      ],
      'fees' => [],
      'error' => 'Invalid params: expected a hex-encoded hash with 0x prefix.',
      'status' => 'cancelled'
    }
  end
end
