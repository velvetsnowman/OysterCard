class Journey
  attr_reader :entry_station,
              :exit_station
  def initialize
    @history = []
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @history << {:entry => @entry_station, :exit => @exit_station}
    @entry_station = nil
    @exit_station = nil
  end

  def history
    @history.each do |journey|
      puts "#{journey[:entry]} -> #{journey[:exit]}"
    end
  end

end
