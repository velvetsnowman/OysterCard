class Oystercard
  attr_reader :balance

  def initialize
    @balance = 0
  end
  def topup(amount)
    @balance += amount
  end
end
