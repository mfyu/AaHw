require_relative 'piece'
require_relative 'slideable'
class Queen < Piece
    include Slideable
    def initialize(color, board, pos)
        super
        @symbol = "♛" if @color == :white
        @symbol = "♕" if @color == :black
    end

    protected

    def move_dirs
        diagonal_dirs + horizontal_and_vertical_dirs
    end
end