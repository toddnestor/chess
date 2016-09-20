module SlidingPiece
  def moves
    valid_moves = []
    move_diffs.each do |diff|
      valid_moves += get_moves(diff)
    end
    valid_moves
  end

  def get_moves(diff)
    new_moves = []

    move = get_next_pos(@pos.dup, diff)
    while can_move_to?(move)
      new_moves << move
      move = get_next_pos(move, diff)
    end

    new_moves
  end

  def get_next_pos(current, diff)
    pos = []
    pos << current[0] + diff[0]
    pos << current[1] + diff[1]
    pos
  end

  def orthogonal_moves
    [
      [0,1],
      [0,-1],
      [1,0],
      [-1,0]
    ]
  end

  def diagonal_moves
    [
      [1,1],
      [-1,-1],
      [1,-1],
      [-1,1]
    ]
  end
end
