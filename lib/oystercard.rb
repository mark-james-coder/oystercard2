class Oystercard

  attr_reader :balance, :in_journey

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Top up failed. Maximum allowed balance is £#{BALANCE_LIMIT}." if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in
    fail "Touch-in failed. Not enough balance to cover the minimum fare of £#{MINIMUM_FARE}." if @balance - MINIMUM_FARE < 0
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
