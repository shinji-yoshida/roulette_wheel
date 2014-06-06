require "roulette_wheel/version"
require "roulette_wheel/relative"
require "roulette_wheel/fixed"
require "roulette_wheel/relative_builder"
require "roulette_wheel/fixed_builder"

module RouletteWheel
  def self.with_fixed_prob(rand_generator=Random, &block)
    RouletteWheel::FixedBuilder.new(rand_generator).build(&block)
  end

  def self.with_relative_prob(rand_generator=Random, &block)
    RouletteWheel::RelativeBuilder.new(rand_generator).build(&block)
  end
end
