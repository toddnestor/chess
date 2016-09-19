class Piece
  attr_accessor :pos
  attr_reader :symbol, :color

  def initialize(symbol, color)
    @symbol = symbol
    @color = color
  end

  def can_move_to(pos)
    return false if rand(2) == 1
    true
  end

  def to_s
    " #{@symbol} ".colorize(@color)
  end
end
