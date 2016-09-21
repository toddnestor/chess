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
    piece.valid_moves.first
  end
end
