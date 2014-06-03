
class RouletteWheel::Relative
  attr_reader :total_size

  def initialize(rand_generator=Random)
    @rand_generator = rand_generator
    @pockets = []
    @total_size = 0
  end

  def add_pocket(size, prize)
    @pockets.push({size: size, prize: prize})
    @total_size += size

    return self
  end

  def spin
    pocket = @rand_generator.rand(@total_size)
    @pockets.each do |g|
      pocket -= g[:size]
      if(pocket < 0)
        return g[:prize]
      end
    end
    raise "never reach here"
  end

  def pockets
    return @pockets
  end

  def has_pocket?(prize, args)
    size = args[:size]
    pockets.include?({size: size, prize: prize})
  end
end