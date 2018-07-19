require_relative 'journey'
class Oystercard
  MAXBALANCE = 90
  MINFARE = 1
  attr_reader :balance
  def initialize(journey = Journey)
    @journey = journey.new
    @balance = 0
  end

  def top_up(amount)
    fail "The limit of #{MAXBALANCE} has been reached." if @balance + amount > MAXBALANCE
    @balance += amount
  end

  def in_journey?
    @journey.in_journey?
  end

  def touch_in(entry_station)
    fail 'Cannot travel: insufficient funds' if @balance < MINFARE
    @journey.touch_in(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINFARE)
    @journey.touch_out(exit_station)
  end

  def history
    @journey.history
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
