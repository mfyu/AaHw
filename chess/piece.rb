class Piece
    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end

    def to_s
        @symbol
    end
    def valid_move?
        true
    end
end