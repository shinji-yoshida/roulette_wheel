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
      rand_generator.should_receive(:rand).with(10 + 15 + 30).and_return(0)
      subject.spin()
    end

    it 'draw randomly according to pocket sizes' do
      rand_generator.stub(:rand).and_return(0)
      subject.spin().should eq 'first pockets'

      rand_generator.stub(:rand).and_return(9)
      subject.spin().should eq 'first pockets'

      rand_generator.stub(:rand).and_return(10)
      subject.spin().should eq 'second pockets'

      rand_generator.stub(:rand).and_return(10 + 14)
      subject.spin().should eq 'second pockets'

      rand_generator.stub(:rand).and_return(10 + 15)
      subject.spin().should eq 'third pockets'

      rand_generator.stub(:rand).and_return(10 + 15 + 29)
      subject.spin().should eq 'third pockets'
    end

    it 'should work with only one pocket' do
      RouletteWheel::Relative.new.add_pocket(10, 'solo pocket').spin.should eq 'solo pocket'
    end
  end
end