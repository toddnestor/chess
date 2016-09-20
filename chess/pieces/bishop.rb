require_relative '../piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include SlidingPiece

  def white_symbol
    "\u2657"
  end

  def black_symbol
    "\u265d"
  end

  def move_diffs
    diagonal_moves
  end
end
