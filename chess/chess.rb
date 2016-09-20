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
    # piece_pos = select_piece
    # select_move(piece_pos)
    move_pos, piece = nil

    until piece
      piece = select_piece

      move_pos = select_move(piece)
      if move_pos == piece.pos
        piece.unselect
        piece, move_pos = nil
      end
    end
    piece.pos = move_pos unless piece.nil?
    piece.unselect

  end

  def select_piece
    pos = get_input
    piece = @board[pos]
    piece.select
    raise "no piece at start" if piece.nil?
    piece
    rescue
      retry
  end

  def select_move(piece)
    pos = nil

    until pos && piece.moves.include?(pos)
      pos = get_input
      return pos if piece.pos == pos
    end
    pos
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end
