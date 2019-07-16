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
        arr<<[row+2, col-1] if row+2<8 && col-1>0
        arr<<[row-2, col-1] if row-2>0 && col-1>0
        arr<<[row-2, col+1] if row-2>0 && col+1<8
        arr<<[row-1, col+2] if row-1>0 && col+2<8
        arr<<[row-1, col-2] if row-1>0 && col-2>0
        arr<<[row+1, col+2] if row+1<8 && col+2<8
        arr<<[row+1, col-2] if row+1<8 && col-2>0




        return arr
    end

end

kpf = KnightPathFinder.new([0,0])
print kpf.root_node
puts

print KnightPathFinder.valid_moves(kpf.root_node)