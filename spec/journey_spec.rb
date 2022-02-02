require 'journey'

describe Journey do
  let(:entry_station) { double :entry_station, zone: 1 }

  it 'knows if a journey is not complete' do
    journey = Journey.new(entry_station)
    expect(journey).not_to be_complete
  end

  it 'has a penalty fare by default' do
    journey = Journey.new(entry_station)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  context 'given an entry station' do
    subject {described_class.new(entry_station)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq entry_station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:exit_station) { double :exit_station }

      before do
        subject.end_journey(exit_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it 'knows if a journey is complete' do
        expect(subject).to be_complete
      end
    end
  end
end
