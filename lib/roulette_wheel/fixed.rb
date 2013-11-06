
class RouletteWheel::Fixed
  attr_reader :total_size

  def initialize(rand_generator=Random)
    @rand_generator = rand_generator
    @pockets = []
    @total_size = 0
    @rest_prize = nil
  end

  def add_pocket(size, prize)
    @pockets.push({size: size, prize: prize})
    @total_size += size

    raise "total_size is greater than 1" if @total_size > 1

    return self
  end

  def set_rest(prize)
    @rest_prize = prize
    return self
  end

  def rest
    @rest_prize
  end

  def spin
    pocket = @rand_generator.rand
    @pockets.each do |g|
      pocket -= g[:size]
      if(pocket < 0)
        return g[:prize]
      end
    end
    return @rest_prize
  end

  def pockets
    return @pockets
  end
end