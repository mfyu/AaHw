class Queue
    def initialize
        @q = []
    end

    def enqueue(el)
        @q<<el
    end

    def dequeue
        @q.shift
    end

    def peek
        @q.first
    end