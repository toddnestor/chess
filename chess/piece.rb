class Piece
  attr_accessor :pos, :selected
  attr_reader :symbol, :color

  def initialize(board, pos)
    @board = board
    self.pos = pos
    set_color
    set_symbol
    @selected = false
  end

  def pos=(pos)
    @board[pos] = self
    @pos = pos
  end

  def can_move_to?(pos)
    @board.in_bounds?(pos) && (@board[pos].nil? || piece_is_opposite(@board[pos]))
  end

  def piece_is_opposite(piece)
    piece.color != @color
  end

  def to_s
    str = " #{@symbol} ".colorize(@color)
    str
  end

  def toggle_select
    @selected = !@selected
  end

  def row
    @pos[0]
  end

  def col
    @pos[1]
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
