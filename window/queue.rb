class MyQueue
    def initialize
        @store = []
    end


    def peek
        @store[0]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def enqueue(value)
        @store<<value
    end

    def dequeue
        @store.shift
    end

end