class Oystercard
  attr_reader :balance
  MAXBALANCE = 90
  MINBALANCE = 1
  def initialize
    @balance = 0
  end

  def topup(amount)
    fail "The limit of #{MAXBALANCE} has been reached." if @balance + amount > MAXBALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @commuting
  end

  def touch_in
    fail 'Cannot travel: insufficient funds' if @balance < MINBALANCE
    @commuting = true
  end

  def touch_out
    @commuting = false
  end
end
