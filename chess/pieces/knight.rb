require_relative '../piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece

  def white_symbol
    "\u2658"
  end

  def black_symbol
    "\u265e"
  end

  def move_diffs
    [
      [-1,2],
      [-2,1],
      [2,1],
      [1,2],
      [2,-1],
      [1,-2],
      [-1,-2],
      [-2,-1]
    ]
  end
end
