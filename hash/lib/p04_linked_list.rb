class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  attr_reader :head, :tail

  def [](i)
    index = 0
    current_node = @head.next
    while current_node.val
      if index == i
        return current_node
      end
      current_node = current_node.next
      index += 1
    end


  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = @head.next
    while current_node.key != nil
      if current_node.key == key
        return current_node.val
      end
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    current_node = @head.next
    while current_node.val
      if current_node.key == key
        return true
      end
      current_node = current_node.next
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev = new_node
    
  end

  def update(key, val)
    current_node = @head.next
    while current_node.val
      if current_node.key == key
        current_node.val = val
      end
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = @head.next
    while current_node.val
      if current_node.key == key
        current_node.prev.next = current_node.next
        current_node.next.prev = current_node.prev

      end
      current_node = current_node.next
    end
  end

  def each
    out = []
    current_node = @head.next
    while current_node.val
      out<<current_node
      current_node = current_node.next
    end
    out
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end

list = LinkedList.new
p list.head
list.append(:first, 1)
list.append("two", 2)
list.append(:first, 3)

puts list.head.next
puts list.tail.prev.prev

puts list.get(:first)

print list.each