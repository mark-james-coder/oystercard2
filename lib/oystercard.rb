class Oystercard

  attr_reader :balance, :entry_station

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = ''
  end

  def top_up(amount)
    fail "Top up failed. Maximum allowed balance is £#{BALANCE_LIMIT}." if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Touch-in failed. Not enough balance to cover the minimum fare of £#{MINIMUM_FARE}." if @balance - MINIMUM_FARE < 0
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
