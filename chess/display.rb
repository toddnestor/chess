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
        str << square_bg(piece, pos)
      end
      puts str
    end

    p @cursor.cursor_pos
  end

  private
  def square_bg(piece, pos)
    return piece.to_s.on_blue if pos == @cursor.cursor_pos

    if pos.reduce(:+).even?
      piece.to_s.on_light_blue
    else
      piece.to_s.on_light_red
    end
  end
end
