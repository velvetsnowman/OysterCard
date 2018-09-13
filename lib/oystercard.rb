require_relative 'journey'
class Oystercard

  MAXBALANCE = 90
  MINFARE = 1

  attr_reader :balance

  def initialize
    @journey = Journey.new
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
    if in_journey? == true
      deduct(6)
      touch_out
    end
    fail 'Cannot travel: insufficient funds' if @balance < MINFARE
    @journey.touch_in(entry_station)
  end

  def touch_out(exit_station = "nil")
    if exit_station == "nil"
      @journey.touch_out(exit_station)
    else
      deduct(1)
      @journey.touch_out(exit_station)
    end
  end

  def history
    @journey.history
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
