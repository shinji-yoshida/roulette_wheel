require 'spec_helper'

describe RouletteWheel::Relative do
  describe 'spin' do
    context 'multiple pocket case' do
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
    end

    it 'should work with only one pocket' do
      expect(RouletteWheel::Relative.new.add_pocket(10, 'solo pocket').spin).to eq 'solo pocket'
    end

    it{expect{RouletteWheel::Relative.new.spin}.to raise_error}
    it{expect{RouletteWheel::Relative.new.add_pocket(0, :empty).spin}.to raise_error}
  end

  describe 'has_pocket?' do
    subject{
      RouletteWheel::with_relative_prob {
        pocket :apple, size: 2
        pocket :banana, size: 3
        pocket :banana, size: 2
      }
    }

    it{is_expected.to have_pocket(:apple, size: 2)}
    it{is_expected.to have_pocket(:banana, size: 3)}
    it{is_expected.to have_pocket(:banana, size: 2)}
    it{is_expected.not_to have_pocket(:banana, size: 4)}
  end

  describe 'add_pocket' do
    subject{RouletteWheel::Relative.new}

    it{expect{subject.add_pocket(1, :foo)}.not_to raise_error}
    it{expect{subject.add_pocket(0, :foo)}.not_to raise_error}
    it{expect{subject.add_pocket(-1, :foo)}.to raise_error}
    it{expect{subject.add_pocket(1.5, :foo)}.to raise_error}
  end
end