class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Top up failed. Maximum allowed balance is £#{BALANCE_LIMIT}." if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Touch-in failed. Not enough balance to cover the minimum fare of £#{MINIMUM_FARE}." if @balance - MINIMUM_FARE < 0
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    if @journey == nil
      @journey = Journey.new(:no_station)
    end
    @journey.end_journey(exit_station)
    deduct(@journey.fare)
    puts "Your card has been deducted £#{@journey.fare}"
    puts "Your card's new balance is £#{@balance}"
    store_journey
    clear_journey
  end

  def in_journey?
    @journey != nil
  end

private

  def deduct(amount)
    @balance -= amount
  end

  def store_journey
    @journeys << {@journey.entry_station => @journey.exit_station}
  end

  def clear_journey
    @journey = nil
  end

end
