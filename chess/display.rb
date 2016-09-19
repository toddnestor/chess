require_relative 'cursor'
require 'colorize'

class Display
  attr_accessor :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    @board.each_row do |row, row_index|
      str = ""
      row.each_with_index do |piece, col_index|
        pos = [row_index, col_index]
        str << (pos == @cursor.cursor_pos ? piece.to_s.colorize(:blue) : piece.to_s)
      end
      puts str
    end
  end
end
