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
end
