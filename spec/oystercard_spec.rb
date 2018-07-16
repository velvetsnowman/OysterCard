require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'should return a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

end 
