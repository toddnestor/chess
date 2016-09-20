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
      take_turn
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

  def take_turn
    piece_pos = select_piece
    select_move(piece_pos)
  end

  def select_piece
    pos = get_input
    piece = @board[pos]
    piece.toggle_select
    raise "no piece at start" if piece.nil?
    piece
    rescue
      retry
  end

  def select_move(piece)
    pos = nil

    until pos && piece.moves.include?(pos)
      pos = get_input
      if pos == piece.pos
        piece.toggle_select
        take_turn
      end
    end

    piece.toggle_select
    piece.pos = pos
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end
