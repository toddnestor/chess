require_relative '../piece'
require_relative 'stepping_piece'
class King < Piece
  include SteppingPiece

  def white_symbol
    "\u2654"
  end

  def black_symbol
    "\u265a"
  end

  def move_diffs
    [
      [-1,1],
      [0,1],
      [1,1],
      [1,0],
      [1,-1],
      [0,-1],
      [-1,-1],
      [-1,0]
    ]
  end
end
