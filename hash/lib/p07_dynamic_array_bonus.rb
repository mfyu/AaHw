require "byebug"
class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  attr_accessor :count, :store
  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_index = 0
  end

  def end_index
    @count + @start_index
  end

  def [](i)
    if i > @count
      return nil
    elsif i < 0
      return nil if i < -@count
      return self[@count + i]
    end
    @store[(@start_index + i) % capacity]
  end

  def []=(i, val)
    if i >= @count
      (i - self.count).times { push(nil) }
    elsif i < 0
      return nil if i < -@count
      return self[self.count + i] = val
    end

    if i == self.count
      resize! if self.count == capacity
      self.count += 1
    end

    @store[(@start_index + i) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < capacity
      if @store[i] == val
        return true
      end
      i+=1
    end
    return false
  end

  def push(val)
    if end_index == capacity
      resize!
    end
    @store[end_index] = val
    @count += 1

  end

  def unshift(val)
    resize! if capacity == self.count || capacity+1 == self.count
    new_arr = StaticArray.new(capacity*2)
    each_with_index do |el, i|
      new_arr[i+1] = el
    end
    
    @store = new_arr
    self[0] = val
    @count += 1
    nil
  end

  def pop
    return nil if self.count == 0
    temp = @store[end_index-1]
    @store[end_index-1] = nil
    @count -= 1
    return temp
  end

  def shift
    return nil if self.count == 0
    @count -= 1
    temp = @store[@start_index]
    @start_index += 1
    
    return temp
  end

  def first
    @store[@start_index]
  end

  def last
    @store[end_index-1]
  end

  def each
    @count.times { |i| yield self[i] }
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
    return false unless self.length == other.length
    each_with_index {|el,i| return false unless el == other[i]}
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_arr = StaticArray.new(capacity*2)
    each_with_index {|el, i| new_arr[i] = el}

    @store = new_arr
    @start_index = 0

  end
end


arr = DynamicArray.new(3)

#debugger
arr.push(1)
arr<<2

print arr.store.store
puts arr[3]
arr.unshift(0)
p arr[3]

print arr
arr.shift

print arr.store.store

p arr[3]