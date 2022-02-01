require 'Oystercard'

describe Oystercard do

MINIMUM_FARE = Oystercard::MINIMUM_FARE

let(:entry_station) { double :entry_station }

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
    it 'causes the card to remember the entry station' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect(subject.entry_station).to eq :entry_station
    end
    it "raises an error if oystercard does not have enough balance for the minimum fare" do
      expect { subject.touch_in('entry_station') }.to raise_error "Touch-in failed. Not enough balance to cover the minimum fare of £#{MINIMUM_FARE}."
    end
  end
  describe '#touch_out' do
    it 'causes the card to forget the entry station' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      subject.touch_out
      expect(subject.entry_station).to be nil
    end
    it 'decreases the balance by minimum fare amount' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect{ subject.touch_out }.to change{ subject.balance }.by -1
    end
  end

end
