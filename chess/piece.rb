class Piece
  attr_accessor :pos
  attr_reader :symbol, :color

  def initialize(board, pos)
    @board = board
    self.pos = pos
    set_color
    set_symbol
  end

  def pos=(pos)
    @board[pos] = self
    @pos = pos
  end

  def can_move_to(pos)
    @board.in_bounds?(pos) && (@board[pos].nil? || piece_is_opposite(@board[pos]))
  end

  def piece_is_opposite(piece)
    piece.color != @color
  end

  def to_s
    " #{@symbol} ".colorize(@color)
  end

  def nil?
    false
  end

  def moves
  end

  private
  def set_color
    if(pos[0] < 2)
      @color = :white
    else
      @color = :black
    end
  end

  def set_symbol
    if @color == :white
      @symbol = white_symbol
    else
      @symbol = black_symbol
    end
  end
end
