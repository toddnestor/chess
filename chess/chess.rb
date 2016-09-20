require_relative 'board'
require_relative 'display'
require_relative 'players/human_player'

class Chess
  attr_accessor :board, :players, :display

  def initialize(player1,player2)
    @board = Board.new
    @display = Display.new(@board)
    @players = [player1, player2]
  end

  def play
    until game_over?
      take_turn
      switch_turns
    end
    @display.render
    winner_and_loser
  end

  def winner_and_loser
    if @board.checkmate?(:white)
      puts "white lost"
    else
      puts "black lost"
    end
  end

  def current_player
    @players[0]
  end

  private
  def take_turn
    # piece_pos = select_piece
    # select_move(piece_pos)
    move_pos, piece = nil

    until piece
      piece = current_player.select_piece(self)

      move_pos = current_player.select_move(piece, self)
      if move_pos == piece.pos
        piece.unselect
        piece, move_pos = nil
      end
    end
    piece.pos = move_pos unless piece.nil?
    piece.unselect
  end

  def game_over?
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end

  def switch_turns
    @players.rotate!
  end
end

if __FILE__ == $PROGRAM_NAME

  game = Chess.new(HumanPlayer.new(:white), HumanPlayer.new(:black))
  game.play
end
