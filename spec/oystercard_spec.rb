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
  end

end
