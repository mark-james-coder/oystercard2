class Journey

  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @fare = fare
  end

  def fare
    if complete?
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end

  def complete?
    @entry_station != :no_station && @exit_station
  end

end
