class Piece
  attr_accessor :pos, :selected
  attr_reader :symbol, :color

  def initialize(board, pos, color=nil)
    @board = board
    self.pos = pos
    set_color unless color
    @color = color if color
    set_symbol
    @selected = false
  end

  def dup(board)
    self.class.new(board, @pos.dup, @color)
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

  def select
    @selected = true
    @board.selected_piece = self
  end

  def unselect
    @selected = false
    @board.selected_piece = nil
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

  def opponent_color
    @color == :white ? :black : :white
  end

  def move_into_check?(pos, color = nil)
    color ||= @color
    duped_board = @board.deep_dup
    duped_board.move(@pos, pos)
    duped_board.in_check?(@color)
  end

  def valid_moves
    moves.reject do |move|
      move_into_check?(move, )
    end
  end

  def has_checking_move?
    valid_moves.each do |move|
      return true if move_into_check?(move, opponent_color)
    end
    false
  end

  def has_killing_move?
    valid_moves.each do |move|
      piece = @board[move]
      return true if !piece.nil? && piece_is_opposite(piece)
    end
    false
  end

  def checking_moves
    valid_moves.select do |move|
      move_into_check?(move, opponent_color)
    end
  end

  def killing_moves
    valid_moves.select do |move|
      piece = @board[move]
      !piece.nil? && piece_is_opposite(piece)
    end
  end

  def moves
  end

  private
  def set_color
    if(row < 2)
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
