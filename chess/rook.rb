require_relative 'piece'
require_relative 'slideable'
class Rook < Piece
    include Slideable
    def initialize(color, board, pos)
        super
        @symbol = "♜" if @color == :white
        @symbol = "♖" if @color == :black
    end

    def move_dirs
        horizontal_and_vertical_dirs
    end
end