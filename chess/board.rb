require_relative "piece"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "null"
require_relative "pawn"
require_relative "queen"
require_relative "rook"
require_relative "cursor"


class Board
    def initialize
        @board = Array.new(8){Array.new(8)}
        populate
        @cursor = Cursor.new([0,0],@board)

    end

    def render
        system("ctl")
        print "  "
        (0...8).each {|i| print "#{i} "}
        puts
        (0...8).each do |i|
            print "#{i} "
            
            
            (0...8).each do |j|
                print "#{@board[i][j]} "
            end
            puts
        end

    end

    def populate
        @board[0][0] = Rook.new(:black, self, [0,0])
        @board[7][0] = Rook.new(:white, self, [7,0])
        @board[0][7] = Rook.new(:black, self, [0,7])
        @board[7][7] = Rook.new(:white, self, [7,7])

        @board[0][1] = Knight.new(:black, self, [0,1])
        @board[7][1] = Knight.new(:white, self, [7,1])
        @board[0][6] = Knight.new(:black, self, [0,6])
        @board[7][6] = Knight.new(:white, self, [7,6])

        @board[0][2] = Bishop.new(:black, self, [0,2])
        @board[7][2] = Bishop.new(:white, self, [7,2])
        @board[0][5] = Bishop.new(:black, self, [0,5])
        @board[7][5] = Bishop.new(:white, self, [7,5])

        @board[0][3] = Queen.new(:black, self, [0,3])
        @board[0][4] = King.new(:black, self, [0,4])
        @board[7][3] = Queen.new(:white, self, [7,3])
        @board[7][4] = King.new(:white, self, [7,4])
        [1].each do |i|
            (0...8).each do |j|
                @board[i][j] = Pawn.new(:black, self, [i,j])
            end
        end
        [6].each do |i|
            (0...8).each do |j|
                @board[i][j] = Pawn.new(:white, self, [i,j])
            end
        end


        (2...6).each do |i|
            (0...8).each do |j|
                @board[i][j] = Null.new(nil, self, [i,j])
            end
        end
        
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @board[row][col] = value
    end

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        raise "no piece at start position" if piece.nil?
        raise "invalid move" if !piece.valid_move?
        self[start_pos] = Null.new(nil, self, start_pos)
        self[end_pos] = piece
    end

    def play
        while true
            render
            @cursor.get_input
        end
    end


end

board = Board.new
board.play