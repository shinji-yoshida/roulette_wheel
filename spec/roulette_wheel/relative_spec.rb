require 'spec_helper'

describe RouletteWheel::Relative do
  describe 'spin' do
    let(:rand_generator){double('rand_generator')}
    subject {RouletteWheel::Relative.new(rand_generator)}

    before do
      subject.add_pocket(10, 'first pockets')
      subject.add_pocket(15, 'second pockets')
      subject.add_pocket(30, 'third pockets')
    end

    it 'should call rand by sum of pocket sizes' do
      expect(rand_generator).to receive(:rand).with(10 + 15 + 30).and_return(0)
      subject.spin()
    end

    it 'draw randomly according to pocket sizes' do
      allow(rand_generator).to receive(:rand).and_return(0)
      expect(subject.spin()).to eq 'first pockets'

      allow(rand_generator).to receive(:rand).and_return(9)
      expect(subject.spin()).to eq 'first pockets'

      allow(rand_generator).to receive(:rand).and_return(10)
      expect(subject.spin()).to eq 'second pockets'

      allow(rand_generator).to receive(:rand).and_return(10 + 14)
      expect(subject.spin()).to eq 'second pockets'

      allow(rand_generator).to receive(:rand).and_return(10 + 15)
      expect(subject.spin()).to eq 'third pockets'

      allow(rand_generator).to receive(:rand).and_return(10 + 15 + 29)
      expect(subject.spin()).to eq 'third pockets'
    end

    it 'should work with only one pocket' do
      expect(RouletteWheel::Relative.new.add_pocket(10, 'solo pocket').spin).to eq 'solo pocket'
    end
  end
end