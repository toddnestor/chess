require_relative '../piece'

class Pawn < Piece

  def white_symbol
    "\u2659"
  end

  def black_symbol
    "\u265f"
  end

  def pos=(pos)
    super
    make_queen if at_other_side
  end

  def moves
    valid_moves = []

    move_diffs.each do |diff|
      pos = position_from_diff(diff)
      piece = @board[pos]
      valid_moves << pos if piece.nil? && @board.in_bounds?(pos)
    end

    valid_moves + enemy_positions
  end

  def enemy_positions
    valid_moves = []

    diffs = [
      [row_diff, -1],
      [row_diff, 1]
    ]

    diffs.each do |diff|
      pos = position_from_diff(diff)
      piece = @board[pos]
      if @board.in_bounds?(pos) && !piece.nil? && piece_is_opposite(piece)
        valid_moves << pos
      end
    end

    valid_moves
  end

  def position_from_diff(diff)
    pos = []
    pos << row + diff[0]
    pos << col + diff[1]
    pos
  end

  def move_diffs
    diffs = []
    diffs << [row_diff, 0]

    two_blocks = [row_diff*2, 0]

    if @color == :black
      diffs << two_blocks if row == 6
    else
      diffs << two_blocks if row == 1
    end

    diffs
  end

  def row_diff
    if @color == :black
      -1
    else
      1
    end
  end

  private
  def at_other_side
    if @color == :white
      row == 7
    else
      row == 0
    end
  end

  def make_queen
    Queen.new(@board, @pos, @color)
  end
end
