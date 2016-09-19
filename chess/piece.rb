class Piece
  attr_accessor :pos

  def initialize
  end

  def can_move_to(pos)
    return false if rand(2) == 1
    true
  end
end
