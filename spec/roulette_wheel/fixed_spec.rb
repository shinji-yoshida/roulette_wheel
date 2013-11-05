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
      rand_generator.should_receive(:rand).with(no_args).and_return(0)
      subject.spin()
    end

    it 'draw randomly according to pocket sizes' do
      rand_generator.stub(:rand).and_return(0)
      subject.spin().should eq 'first pocket'

      rand_generator.stub(:rand).and_return(0.1 - 0.0001)
      subject.spin().should eq 'first pocket'

      rand_generator.stub(:rand).and_return(0.1 + 0.0001)
      subject.spin().should eq 'second pocket'

      rand_generator.stub(:rand).and_return(0.1 + 0.25 - 0.0001)
      subject.spin().should eq 'second pocket'

      rand_generator.stub(:rand).and_return(0.1 + 0.25 + 0.0001)
      subject.spin().should eq 'rest pocket'

      rand_generator.stub(:rand).and_return(1)
      subject.spin().should eq 'rest pocket'
    end
  end
end