require 'singleton'

class NullPiece
  include Singleton

  def method_missing(*args)
  end

  def to_s
    "   "
  end

  def nil?
    true
  end
end
