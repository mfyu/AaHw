require_relative "tree"
require "byebug"

class KnightPathFinder
    def initialize(pos)
        @root_node = pos
        @considered_positions = [pos]
        KnightPathFinder.valid_moves(root_node)
    end
    attr_reader :root_node, :considered_positions

    def self.valid_moves(pos)
        arr = []
        row, col = pos
        arr<<[row+2, col+1] if row+2<8 && col+1<8
        arr<<[row+2, col-1] if row+2<8 && col-1>=0
        arr<<[row-2, col-1] if row-2>=0 && col-1>=0
        arr<<[row-2, col+1] if row-2>=0 && col+1<8
        arr<<[row-1, col+2] if row-1>=0 && col+2<8
        arr<<[row-1, col-2] if row-1>=0 && col-2>=0
        arr<<[row+1, col+2] if row+1<8 && col+2<8
        arr<<[row+1, col-2] if row+1<8 && col-2>=0
        return arr
    end

    def new_move_positions(pos)
        arr = []
        moves = KnightPathFinder.valid_moves(pos)
        moves.each do |move|
            if !@considered_positions.include?(move)
                arr<<move 
                @considered_positions<<move
            end
        end
        return arr
    end


end

kpf = KnightPathFinder.new([0,0])



print KnightPathFinder.valid_moves([1,2])

puts
print kpf.considered_positions
puts
print kpf.new_move_positions([1,2])
puts
print kpf.considered_positions