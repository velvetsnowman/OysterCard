require 'oystercard'
require 'journey'
describe Oystercard do

  let (:oystercard)    { Oystercard.new        }
  let (:journey) {Journey.new}
  let (:entry_station) { double :entry_station }
  let (:exit_station)  { double :exit_station  }
  describe '#balance' do
    it 'should return a balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#entry_station' do
    it 'saves the station you enter in' do
      oystercard.top_up(10)
      journey.touch_in(:entry_station)
      expect(journey.entry_station).to eq :entry_station
    end
  end

  describe '#top_up' do
    it 'should top up £10' do
      expect{(oystercard.top_up(10))}.to change{ oystercard.balance }.to(10)
    end
    it 'raises and error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAXBALANCE
      oystercard.top_up(max_balance)
      expect {oystercard.top_up(1)}.to raise_error ("The limit of #{max_balance} has been reached.")
    end
  end

  describe '#in_journey?' do
    it 'should state if the passenger is in a journey or not' do
      oystercard.top_up(1.5)
      oystercard.touch_in(:entry_station, 1)
      oystercard.touch_out(:exit_station, 1)
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'should let a passenger touch in' do
      oystercard.top_up(1.5)
      oystercard.touch_in(:entry_station, 1)
      expect(oystercard).to be_in_journey
    end
    it 'should raise an error when not enough funds' do
      oystercard.top_up(0.5)
      expect {oystercard.touch_in(:entry_station, 1)}.to raise_error('Cannot travel: insufficient funds')
    end
    it 'should charge a passenger a penalty of £6 if not tapped put from previous trip' do
      oystercard.top_up(10)
      oystercard.touch_in(:entry_station, 1)
      oystercard.touch_in(:entry_station, 1)
      expect(oystercard.balance).to eq 4

    end
  end

  describe '#touch_out' do

    before do
      oystercard.top_up(10)
      oystercard.touch_in(:entry_station, 1)
    end

    context 'when travelling between zones' do
      it 'same zone' do
        expect {oystercard.touch_out(:exit_station, 1)}.to change{oystercard.balance}.by(-1)
      end
      it 'difference of 1 zone' do
        expect {oystercard.touch_out(:exit_station, 2)}.to change{oystercard.balance}.by(-2)
      end
      it 'difference of 2 zones' do
        expect {oystercard.touch_out(:exit_station, 3)}.to change{oystercard.balance}.by(-3)
      end
    end
  end

  describe '#history' do
    it 'has an empty list of journeys by default' do
      expect(oystercard.history).to be_empty
    end
    it 'should return the history' do
      oystercard.top_up(1.5)
      oystercard.touch_in('abc', 1)
      oystercard.touch_out('def', 1)
      expect{oystercard.history}.to output("abc -> def\n").to_stdout
    end
  end
end
