require_relative '../player'

class ComputerPlayer < Player
  def initialize(color)
    name = ['Gizmo','Robo the Robot', 'Jimmy'].sample
    super(name, color)
  end

  def select_piece(game)
    pieces = []
    game.board.each_piece(@color) do |piece|
      pieces << piece unless piece.valid_moves.empty?
    end
    pieces.sample
  end

  def select_move(piece, game)
    killing_move(piece, game) || random_move(piece)
  end

  def killing_move(piece, game)

  end

  def random_move(piece)
    piece.valid_moves.sample
  end
end
