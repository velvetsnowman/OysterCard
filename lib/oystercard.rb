require_relative 'station'
class Oystercard
  attr_reader :balance, :entry_station
  MAXBALANCE = 90
  MINBALANCE = 1
  def initialize
    @balance = 0
    @history = []
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

  def touch_out(exit_station)
    deduct(MINBALANCE)
    @exit_station = exit_station
    @history << {:entry => @entry_station, :exit => @exit_station}
    @entry_station = nil
  end

  def history
    @history.each do |hash|
      puts "#{hash[:entry]} - #{hash[:exit]}"
    end
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
