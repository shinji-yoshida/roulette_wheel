
class RouletteWheel::RelativeBuilder
  attr_reader :total_size

  def initialize(rand_generator=Random)
    @rand_generator = rand_generator
  end

  def build(&block)
    @result = RouletteWheel::Relative.new(@rand_generator)
    self.instance_eval(&block)
    return @result
  end

  def pocket(prize, args)
    @result.add_pocket(args[:size], prize)
  end
end