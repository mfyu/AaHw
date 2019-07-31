class MyStack
    def initialize
        @store = []
    end

    def peek
        @store[-1]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def push(value)
        @store<<value
    end

    def pop
        @store.pop
    end