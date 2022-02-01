require 'Oystercard'

describe Oystercard do

MINIMUM_FARE = Oystercard::MINIMUM_FARE

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
  describe '#touch_in' do
    it 'can touch in' do
      subject.top_up(1)
      subject.touch_in
      expect(subject.in_journey).to be true
    end
    it 'decreases the balance by minimum fare amount' do
      subject.top_up(1)
      expect{ subject.touch_in }.to change{ subject.balance }.by -1
    end
    it "raises an error if oystercard does not have enough balance for the minimum fare" do
      expect { subject.touch_in }.to raise_error "Touch-in failed. Not enough balance to cover the minimum fare of £#{MINIMUM_FARE}."
    end
  end
    it 'can touch out' do
      subject.top_up(1)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to be false
    end
end
