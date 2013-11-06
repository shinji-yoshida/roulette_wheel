
class RouletteWheel::FixedBuilder
  attr_reader :total_size

  def initialize(rand_generator=Random)
    @rand_generator = rand_generator
  end

  def build(&block)
    @result = RouletteWheel::Fixed.new(@rand_generator)
    self.instance_eval(&block)
    return @result
  end

  def pocket(prize, args)
    @result.add_pocket(args[:size], prize)
  end

  def rest(prize)
    @result.set_rest(prize)
  end
end