require_relative 'piece'
require_relative 'nullpiece'

class Board
  attr_reader :grid

  def initialize
    setup_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
    @grid[piece.pos[0]][piece.pos[1]] = NullPiece.new if piece.pos
    piece.pos = pos
  end

  def each_with_index(&prc)
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col|
        prc.call piece, [row_index, col]
      end
    end
  end

  def each_row(&prc)
    rows.each_with_index {|row, row_index| prc.call(row, row_index)}
  end

  def move(start, end_pos)
    piece = self[start]
    raise "no piece at start" if piece.is_a?(NullPiece)
    raise "can't move there" unless piece.can_move_to(end_pos)

    piece.pos = end_pos
    self[end_pos] = piece
  end

  def in_bounds?(pos)
    (0..7).cover?(pos[0]) && (0..7).cover?(pos[1])
  end

  alias_method :rows, :grid

  private
  def setup_board
    @grid = Array.new(8) do
      Array.new(8) { NullPiece.new }
     end

     self[[0,0]] = Piece.new("\u2654", :white)
     self[[0,1]] = Piece.new("\u2654", :white)
     self[[1,0]] = Piece.new("\u265a", :black)
     self[[1,1]] = Piece.new("\u265a", :black)
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.render
  board.move([1,1],[3,3])
end
