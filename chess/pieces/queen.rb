require_relative '../piece'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece

  def white_symbol
    "\u2655"
  end

  def black_symbol
    "\u265b"
  end

  def move_diffs
    orthogonal_moves + diagonal_moves
  end
end
