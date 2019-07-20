require_relative 'piece'
require_relative 'slideable'
class Bishop < Piece
    include Slideable
    def initialize(color, board, pos)
        super
        @symbol = "♝" if @color == :white
        @symbol = "♗" if @color == :black
    end
end