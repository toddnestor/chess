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
    if pos == @cursor.cursor_pos
      if piece.nil?
        return " \u2659 ".colorize(:blue).on_blue
      else
        return str.on_blue
      end
    end
    return str.on_light_black if piece.selected

    if @board.selected_piece
      if @board.selected_piece.valid_moves.include? pos
        return str.on_light_green
      end
    end

    if pos.reduce(:+).even?
      piece.nil? ? " \u2659 ".colorize(:green).on_green : piece.to_s.on_green
    else
      piece.nil? ? " \u2659 ".colorize(:yellow).on_yellow : piece.to_s.on_yellow
    end
  end
end
