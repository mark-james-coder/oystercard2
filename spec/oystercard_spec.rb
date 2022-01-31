require 'Oystercard'

describe Oystercard do

  it 'has a balance' do
    expect(subject.balance).to eq 0
  end
  describe '#top_up' do
    it 'increases the balance by specified amount' do
    expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end
  end

end
