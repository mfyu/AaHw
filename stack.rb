class Stack
    def initialize
        @stack = [1,4,67,8,8,43,6353,94]
    end

    def pop
        @stack.pop
    end

    def push(el)
        @stack<<el
    end

    def peek
        @stack.first
    end
end


s = Stack.new

puts s.pop
s.push(4)
puts s.peek
puts s.pop