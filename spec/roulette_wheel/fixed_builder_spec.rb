require 'spec_helper'

describe RouletteWheel::FixedBuilder do
  describe 'build' do
    subject {
      RouletteWheel::FixedBuilder.new.build {
        pocket :foo, size: 0.13
        pocket :bar, size: 0.2
        rest :buzz
      }
    }
    it {subject.pockets.should include({size: 0.13, prize: :foo})}
    it {subject.pockets.should include({size: 0.2, prize: :bar})}
    it {subject.rest.should eq :buzz}
  end
end