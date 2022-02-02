require 'station'

describe Station do

  it 'knows its name' do
    station = Station.new("Bank", 1)
    expect(station.name).to eq "Bank"
  end

  it 'knows its zone' do
    station = Station.new("Bank", 1)
    expect(station.zone).to eq 1
  end

end
