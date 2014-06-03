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
    it {expect(subject.pockets).to include({size: 0.13, prize: :foo})}
    it {expect(subject.pockets).to include({size: 0.2, prize: :bar})}
    it {expect(subject.rest).to eq :buzz}
  end
end