class Oystercard

  attr_reader :balance

  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Top up failed. Maximum allowed balance is £#{BALANCE_LIMIT}." if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(amount)
    fail "Deduct failed. Minimum allowed balance is £0." if @balance - amount < 0
    @balance -= amount
  end

end
