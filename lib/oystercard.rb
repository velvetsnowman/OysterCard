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

  def touch_in(entry_station, entry_zone)
    @entry_zone = entry_zone
    if in_journey? == true
      deduct(fare)
      touch_out
    end
    fail 'Cannot travel: insufficient funds' if @balance < MINFARE
    @journey.touch_in(entry_station)
  end

  def touch_out(exit_station = "incomplete", exit_zone = 100)
    @exit_zone = exit_zone
    if exit_station == "incomplete"
      @journey.touch_out(exit_station)
    else
      @journey.touch_out(exit_station)
      deduct(fare)
    end
  end

  def history
    @journey.history
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def fare
    if in_journey? == true
      6
    else
      zone_calculator(@entry_zone - @exit_zone)
    end
  end

  def zone_calculator(zone_difference)
    case zone_difference.abs
    when 1
      2
    when 2
      3
    else
      1
    end
  end

end
