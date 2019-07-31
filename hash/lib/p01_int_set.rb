class MaxIntSet
  def initialize(max)
    @store = []
    @max = max
  end

  def insert(num)
    if num <= @max && num >= 0
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    @store[num] = false

  end

  def include?(num)
    @store[num]
  end
  attr_reader :store
  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num%20]<<num if !@store[num%20].nil? && !include?(num)
  end

  def remove(num)
    @store.each do |arr|
      if arr.include?(num)
        arr.delete(num)
      end
    end
  end

  def include?(num)
    @store.any? {|arr| arr.include?(num)}
  end

  attr_reader :store

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end
    if !@store[num%num_buckets].nil? && !include?(num)
      @store[num%num_buckets]<<num 
      @count += 1
    end
  end

  def remove(num)
    @store.each do |arr|
      if arr.include?(num)
        arr.delete(num)
        @count -= 1
      end
    end  
  end

  def include?(num)
    @store.any? {|arr| arr.include?(num)}

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { Array.new }
    @store.each do |arr|
      arr.each do |el|
        new_store[el % (2*num_buckets)]<<el
      end
    end
    @store = new_store
  end
end

