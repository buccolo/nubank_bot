require 'spec_helper'

describe NubankCreditParser do
  it 'returns all the transactions in the right format' do
    transactions = subject.parse(nubank_credit_html)

    expect(transactions.count).to eq 38
    expect(transactions[3]).to eq({
      :date => "2015-11-10",
      :memo => "Credito Variacao Cambial ",
      :value => 1.36,
    })

    expect(transactions[32]).to eq({
      :date => "2015-02-04",
      :memo => "Amazon Web Services ",
      :value => -3.5
    })

    transactions.each do |transaction|
      expect(transaction[:date]).to be
      expect(transaction[:memo]).to be
      expect(transaction[:value] != 0).to be true
    end
  end
end
