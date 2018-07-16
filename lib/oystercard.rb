class Oystercard
  attr_reader :balance
  MAXBALANCE = 90
  def initialize
    @balance = 0
  end
  def topup(amount)
    fail "The limit of" + "#{MAXBALANCE}" + "has been reached." if @balance + amount > MAXBALANCE
    @balance += amount
  end
end
