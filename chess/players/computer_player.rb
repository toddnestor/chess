require_relative '../player'

class ComputerPlayer < Player
  def initialize(color)
    name = ['Gizmo','Robo the Robot', 'Jimmy'].sample
    super(name, color)
  end

  def select_piece(game)
    pieces = valid_pieces(game)
    killing_or_checking_move = false
    pieces.sort do |a, b|
      if a.has_checking_move?
        killing_or_checking_move = true
        if b.has_checking_move?
          0
        else
          -1
        end
      elsif b.has_checking_move?
        killing_or_checking_move = true
        1
      else
        if a.has_killing_move?
          killing_or_checking_move = true
          if b.has_killing_move?
            0
          else
            -1
          end
        elsif b.has_killing_move?
          killing_or_checking_move = true
          1
        else
          0
        end
      end
    end

    if killing_or_checking_move
      # non_pawns = pieces.select do |piece|
      #   !piece.is_a?(Pawn) && (piece.has_killing_move? || piece.has_checking_move?)
      # end
      # if non_pawns.length > 0
      #   p non_pawns.map {|piece| piece.pos}
      #   abort
      # end
      pieces.first
    else
      pieces.sample
    end
  end


  def valid_pieces(game)
    pieces = []
    game.board.each_piece(@color) do |piece|
      pieces << piece unless piece.valid_moves.empty?
    end
    pieces
  end

  def select_move(piece, game)
    sleep(1)
    checking_move(piece) || killing_move(piece) || random_move(piece)
  end

  def checking_move(piece)
    piece.checking_moves.first
  end

  def killing_move(piece)
    piece.killing_moves.first
  end

  def random_move(piece)
    piece.valid_moves.sample
  end
end
