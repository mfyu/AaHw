require "byebug"
class PolyTreeNode
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
    
        if node == nil
            @parent=nil
            return nil
        end
        @parent.children.delete(self) if @parent
        @parent = node
        node.children<<self if !node.children.include?(self)
    end

    def inspect
        @value
    end

    def add_child(child)
        child.parent=self
    end

    def remove_child(child)
        raise "not a child" if child.parent==nil
        child.parent=nil
    end

    attr_reader :value, :parent, :children

    def dfs(target)
        return self if @value==target
        self.children.each do |c|
            temp = c.dfs(target)
            return temp unless temp.nil?
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty?
            el = queue.shift
            return el if el.value==target
            el.children.each {|c| queue<<c}
        end
        nil
    end

        
end

