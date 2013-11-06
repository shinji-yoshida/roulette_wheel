require 'spec_helper'

describe RouletteWheel do
  describe 'with_fixed_prob' do
    subject {
      RouletteWheel.with_fixed_prob {
        pocket :foo, size: 0.1
        rest :bar
      }
    }

    it {should be_kind_of(RouletteWheel::Fixed)}
    it {subject.pockets.should include({size: 0.1, prize: :foo})}
    it {subject.rest.should eq :bar}
  end

  describe 'with_relative_prob' do
    subject {
      RouletteWheel.with_relative_prob {
        pocket :foo, size: 3
        pocket :bar, size: 4
      }
    }

    it {should be_kind_of(RouletteWheel::Relative)}
    it {subject.pockets.should include({size: 3, prize: :foo})}
    it {subject.pockets.should include({size: 4, prize: :bar})}
  end
end