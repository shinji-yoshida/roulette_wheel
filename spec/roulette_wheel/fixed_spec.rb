require 'spec_helper'

describe RouletteWheel::Fixed do
  describe 'spin' do
    let(:rand_generator){double('rand_generator')}
    subject {RouletteWheel::Fixed.new(rand_generator)}

    before do
      subject.add_pocket(0.1, 'first pocket')
      subject.set_rest('rest pocket')
      subject.add_pocket(0.25, 'second pocket')
    end

    it 'should call rand without args' do
      expect(rand_generator).to receive(:rand).and_return(0)
      subject.spin()
    end

    it 'draw randomly according to pocket sizes' do
      allow(rand_generator).to receive(:rand).and_return(0)
      expect(subject.spin()).to eq 'first pocket'

      allow(rand_generator).to receive(:rand).and_return(0.1 - 0.0001)
      expect(subject.spin()).to eq 'first pocket'

      allow(rand_generator).to receive(:rand).and_return(0.1 + 0.0001)
      expect(subject.spin()).to eq 'second pocket'

      allow(rand_generator).to receive(:rand).and_return(0.1 + 0.25 - 0.0001)
      expect(subject.spin()).to eq 'second pocket'

      allow(rand_generator).to receive(:rand).and_return(0.1 + 0.25 + 0.0001)
      expect(subject.spin()).to eq 'rest pocket'

      allow(rand_generator).to receive(:rand).and_return(1)
      expect(subject.spin()).to eq 'rest pocket'
    end
  end
end