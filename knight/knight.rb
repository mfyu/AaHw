require_relative "tree"
require "byebug"

class KnightPathFinder
    def initialize(pos)
        @start_pos = pos
        @considered_positions = [pos]
        build_move_tree
    end
    attr_reader :considered_positions, :start_pos
    attr_accessor :root_node

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
    # def bfs(target)
    #     queue = [self]
    #     until queue.empty?
    #         el = queue.shift
    #         return el if el.value==target
    #         el.children.each {|c| queue<<c}
    #     end
    #     nil
    # end
    def build_move_tree
        self.root_node = PolyTreeNode.new(@start_pos)
        queue = [root_node]
        until queue.empty?
            el = queue.shift
            new_move_positions(el.value).each do |e| 
                child = PolyTreeNode.new(e)
                el.add_child(child)
                queue<<child
            end
        end
        nil
    end

    def print_tree(root)
        print root.value
        puts
        root.children.each do |e|
            print_tree(e)
        end
    end
    
    def find_path(end_pos)
        path = []
        node = root_node.dfs(end_pos)
        # trace_back_path(node).each {|n| path<<n.value}
        # print path.reverse
        print trace_back_path(node).reverse
    
    end

    def trace_back_path(node)
        path = []
        current_node = node
        until current_node.nil?
            path<<current_node
            current_node = current_node.parent
        end
        path
    end


end

kpf = KnightPathFinder.new([0,0])



#print KnightPathFinder.valid_moves([1,2])

# puts
# print kpf.considered_positions
# puts
# print kpf.new_move_positions([0,0])
# puts
# print kpf.considered_positions

kpf.find_path([4,0])

