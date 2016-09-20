require_relative 'cursor'
require 'colorize'

class Display
  attr_accessor :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system("clear")
    str = ""
    @board.each_row do |row, row_index|
      row.each_with_index do |piece, col_index|
        pos = [row_index, col_index]
        str << square_bg(piece, pos)
      end
      str << "\n"
    end
    puts str
  end

  private
  def square_bg(piece, pos)
    str = piece.to_s
    return str.on_blue if pos == @cursor.cursor_pos
    return str.on_light_black if piece.selected

    if @board.selected_piece
      if @board.selected_piece.valid_moves.include? pos
        return str.on_light_green
      end
    end

    if pos.reduce(:+).even?
      str.on_light_blue
    else
      str.on_light_red
    end
  end
end
