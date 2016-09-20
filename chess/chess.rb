require_relative 'board'
require_relative 'display'

class Chess
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    while true
      select_move(select_piece)
    end
  end

  private
  def get_input
    pos = nil
    until pos
      system("clear")
      @display.render
      pos = @display.cursor.get_input
    end
    pos
  end

  def select_piece
    pos = get_input
    piece = @board[pos]
    raise "no piece at start" if piece.nil?
    piece
  end

  def select_move(piece)
    pos = nil
    until pos && piece.moves.include?(pos)
      pos = get_input
    end
    piece.pos = pos
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end
