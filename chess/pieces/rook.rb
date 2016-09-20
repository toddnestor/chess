require_relative '../piece'
require_relative 'sliding_piece'

class Rook < Piece
  include SlidingPiece

  def white_symbol
    "\u2656"
  end

  def black_symbol
    "\u265c"
  end

  def move_diffs
    orthogonal_moves
  end
end
