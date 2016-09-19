require_relative 'board'
require_relative 'display'

class Chess
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    pos = nil
    until pos
      system("clear")
      @display.render
      pos = @display.cursor.get_input
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end
