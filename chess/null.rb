class Null < Piece
    #include Singleton
    def initialize(color, board, pos)
        super
        @symbol = " "
    end

end