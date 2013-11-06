require "roulette_wheel/version"
require "roulette_wheel/relative"
require "roulette_wheel/fixed"
require "roulette_wheel/relative_builder"
require "roulette_wheel/fixed_builder"

module RouletteWheel
  def self.with_fixed_prob(&block)
    RouletteWheel::FixedBuilder.new.build(&block)
  end

  def self.with_relative_prob(&block)
    RouletteWheel::RelativeBuilder.new.build(&block)
  end
end
