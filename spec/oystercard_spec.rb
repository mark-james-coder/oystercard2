require 'Oystercard'

describe Oystercard do

MINIMUM_FARE = Oystercard::MINIMUM_FARE

let(:entry_station) { double :entry_station }
let(:exit_station) { double :exit_station }

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
      subject.touch_out(:exit_station)
      expect(subject.entry_station).to be nil
    end
    it 'stores exit station' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.exit_station).to eq :exit_station
    end
    it 'decreases the balance by minimum fare amount' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect{ subject.touch_out(:exit_station) }.to change{ subject.balance }.by -1
    end
  end
  it 'shows if card is in journey' do
    subject.top_up(1)
    subject.touch_in(:entry_station)
    expect(subject.in_journey?).to_not be nil
  end
  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end
  it 'stores a journey' do
    subject.top_up(1)
    subject.touch_in(:entry_station)
    subject.touch_out(:exit_station)
    expect(subject.journeys).to include subject.journey
    p subject.journey
  end

end
