class Knight < Piece
    def initialize(color, board, pos)
        super
        @symbol = "♞" if @color == :white
        @symbol = "♘" if @color == :black
    end
end