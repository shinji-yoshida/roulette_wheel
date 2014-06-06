require 'statistics'

module RelativeProbabilitySteps
  step "Spin result is random" do
    sample = Statistics::Sample.new

    roulette = RouletteWheel.with_relative_prob {
      pocket :apple, size: 10
      pocket :banana, size: 20
      pocket :candy, size: 25
    }

    (0...1000).each do |i|
      pocket = roulette.spin
      sample.add(pocket)
    end

    expect(sample).to be_generated_from({
      apple: 10.0 / 55, banana: 20.0 / 55, candy: 25.0 / 55
    })
  end
end

RSpec.configure { |c| c.include RelativeProbabilitySteps}