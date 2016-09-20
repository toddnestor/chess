require_relative '../player.rb'

class HumanPlayer < Player
  def initialize(color)
    puts "What's your name?"
    name = gets.chomp
    super(name, color)
  end

  def select_piece(game)
    piece = nil

    until piece
      pos = get_input(game)
      piece = game.board[pos]

      if piece.color == @color
        piece.select
      else
        piece = nil
      end
    end
    piece
  end

  def select_move(piece, game)
    pos = nil

    until pos && piece.moves.include?(pos)
      pos = get_input(game)
      return pos if piece.pos == pos
    end
    pos
  end

  private
  def get_input(game)
    pos = nil
    until pos
      system("clear")
      game.display.render
      pos = game.display.cursor.get_input
    end
    pos
  end
end
