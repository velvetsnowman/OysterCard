class Oystercard
  attr_reader :balance, :entry_station
  MAXBALANCE = 90
  MINBALANCE = 1
  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "The limit of #{MAXBALANCE} has been reached." if @balance + amount > MAXBALANCE
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail 'Cannot travel: insufficient funds' if @balance < MINBALANCE
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINBALANCE)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
