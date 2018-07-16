require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'should return a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#topup' do
    it { is_expected.to respond_to(:topup).with(1).argument }
    it 'should top up 10£' do
      expect{(subject.topup(10))}.to change{ subject.balance }.to(10)
    end
    it 'raises and error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAXBALANCE
      subject.topup(max_balance)
      expect {subject.topup(1)}.to raise_error ("The limit of" + "#{max_balance}" + "has been reached.")
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'should deduct 10£ from the balance' do
      subject.topup(50)
      expect{(subject.deduct(10))}.to change{subject.balance}.to(40)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}
    it 'should state if the passenger is in a journey or not' do
      expect(subject.in_journey?).to_not be true
    end
  end

  # describe '#touch_in' do
  #   it { is_expected.to respond_to(:touch_in)}
  #   it 'should let a passenger touch in' do
  #     expect(subject.touch_in).to be true
  #   end
  # end
  #
  # describe '#touch_out' do
  #   it { is_expected.to respond_to(:touch_out)}
  #   it 'should let a passenger touch out' do
  #     expect(subject.touch_out).to be false
  #   end
  # end

end
