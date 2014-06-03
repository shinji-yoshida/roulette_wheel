require 'spec_helper'

describe RouletteWheel::RelativeBuilder do
  describe 'build' do
    subject {
      RouletteWheel::RelativeBuilder.new.build {
        pocket :foo, size: 3
        pocket :bar, size: 5
        pocket :buzz, size: 9
      }
    }
    it {expect(subject.pockets).to include({size: 3, prize: :foo})}
    it {expect(subject.pockets).to include({size: 5, prize: :bar})}
    it {expect(subject.pockets).to include({size: 9, prize: :buzz})}
  end
end