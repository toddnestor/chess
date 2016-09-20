require_relative 'piece'
require_relative 'nullpiece'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

class Board
  attr_accessor :selected_piece, :grid

  def initialize
    setup_board
    @selected_piece = nil
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

  def each_piece(color=nil, &prc)
    each_row do |row|
      row.each do |piece|
        if !piece.nil? && (!color || piece.color == color)
          prc.call(piece)
        end
      end
    end
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    piece.pos = end_pos
  end

  def king(color)
    each_piece(color) do |piece|
      return piece if piece.is_a? King
    end
  end

  def in_check?(color)
    king_pos = king(color).pos

    each_piece(get_opposite_color(color)) do |piece|
      return true if piece.moves.include?(king_pos)
    end
    false
  end

  def checkmate?(color)
    each_piece(color) {|piece| return false unless piece.valid_moves.empty?}
    true
  end

  def get_opposite_color(color)
    color == :black ? :white : :black
  end

  def in_bounds?(pos)
    (0..7).cover?(pos[0]) && (0..7).cover?(pos[1])
  end

  def deep_dup
    duped_board = self.dup
    duped_board.grid = empty_board

    each_piece do |piece|
      duped_piece = piece.dup(duped_board)
    end

    duped_board
  end

  alias_method :rows, :grid

  private
  def empty_board
    Array.new(8) do
      Array.new(8) { NullPiece.instance }
    end
  end

  def setup_board
    @grid = empty_board

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
