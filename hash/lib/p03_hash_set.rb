class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == num_buckets
      resize!
    end
    if !@store[key.hash%num_buckets].nil? && !include?(key)
      @store[key.hash%num_buckets]<<key 
      @count += 1
    end
  end

  def include?(key)
    @store.any? {|arr| arr.include?(key)}
  end

  def remove(key)
    @store.each do |arr|
      if arr.include?(key)
        arr.delete(key)
        @count -= 1
      end
    end 
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
        new_store[el.hash % (2*num_buckets)]<<el
      end
    end
    @store = new_store
  end
end
