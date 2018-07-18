require 'oystercard'
describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'should return a balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'should top up 10£' do
      expect{(oystercard.top_up(10))}.to change{ oystercard.balance }.to(10)
    end
    it 'raises and error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAXBALANCE
      oystercard.top_up(max_balance)
      expect {oystercard.top_up(1)}.to raise_error ("The limit of #{max_balance} has been reached.")
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'should deduct 10£ from the balance' do
      oystercard.top_up(50)
      expect{(oystercard.deduct(10))}.to change{oystercard.balance}.to(40)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}
    it 'should state if the passenger is in a journey or not' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in)}
    it 'should let a passenger touch in' do
      oystercard.top_up(1.5)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
    it 'should raise an error when not enough funds' do
      oystercard.top_up(0.5)
      expect {oystercard.touch_in}.to raise_error('Cannot travel: insufficient funds')
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out)}
    it 'should let a passenger touch out' do
      oystercard.top_up(1.5)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
      expect {oystercard.touch_out}.to change{oystercard.balance}.by(-Oystercard::MINBALANCE)
    end
  end

end
