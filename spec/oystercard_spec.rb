require 'Oystercard'

describe Oystercard do

  it 'has a balance' do
    expect(subject.balance).to eq 0
  end
  describe '#top_up' do
    it 'increases the balance by specified amount' do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end
    it "raises an error if topping up would take balance over balance limit" do
      expect { subject.top_up 95}.to raise_error "Top up failed. Maximum allowed balance is £#{Oystercard::BALANCE_LIMIT}."
    end
  end
  describe '#deduct' do
    it 'decreases the balance by specified amount' do
      subject.top_up(10)
      expect{ subject.deduct 5 }.to change{ subject.balance }.by -5
    end
    it "raises an error if deducting would take balance under zero balance" do
      expect { subject.deduct 5}.to raise_error "Deduct failed. Minimum allowed balance is £0."
    end
  end

end
