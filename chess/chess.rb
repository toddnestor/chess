require_relative 'board'
require_relative 'display'
require_relative 'players/human_player'
require_relative 'players/computer_player'

class Chess
  attr_accessor :board, :players, :display

  def initialize(player1,player2)
    @board = Board.new
    @display = Display.new(@board)
    @players = [player1, player2]
  end

  def play
    until game_over?
      @display.render
      take_turn
      switch_turns
      inform_in_check
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

  def white
    @players.find {|player| player.color == :white}
  end

  def black
    @players.find {|player| player.color == :black}
  end

  def inform_in_check
    puts "#{white}: you're in check" if @board.in_check?(:white)
    puts "#{black}: you're in check" if @board.in_check?(:black)
  end

  def inform_turn
    puts "#{current_player}, it's your turn, you are #{current_player.color}"
  end

  private
  def take_turn
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

  game = Chess.new(ComputerPlayer.new(:white), ComputerPlayer.new(:black))
  game.play
end
