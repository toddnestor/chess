module SteppingPiece
  def moves
    valid_moves = []
    move_diffs.each do |diff|
      pos = []
      pos << @pos[0] + diff[0]
      pos << @pos[1] + diff[1]
      valid_moves << pos if can_move_to(pos)
    end
    valid_moves
  end
end
