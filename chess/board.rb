require_relative 'piece'
require_relative 'nullpiece'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

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
    @grid[piece.pos[0]][piece.pos[1]] = NullPiece.instance if piece.pos
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

  def in_bounds?(pos)
    (0..7).cover?(pos[0]) && (0..7).cover?(pos[1])
  end

  alias_method :rows, :grid

  private
  def setup_board
    @grid = Array.new(8) do
      Array.new(8) { NullPiece.instance }
     end

     set_pieces
  end

  def set_pieces
    [[0,0],[0,7],[7,0],[7,7]].each {|pos| Rook.new(self, pos)}
    [[0,1],[0,6],[7,1],[7,6]].each {|pos| Knight.new(self, pos)}
    [[0,2],[0,5],[7,2],[7,5]].each {|pos| Bishop.new(self, pos)}
    [[0,3],[7,3]].each {|pos| King.new(self, pos)}
    [[0,4],[7,4]].each {|pos| Queen.new(self, pos)}
    (0..7).each do |col|
      Pawn.new(self, [1,col])
      Pawn.new(self, [6,col])
    end
  end
end
