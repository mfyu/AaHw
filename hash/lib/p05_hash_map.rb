require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count, :store

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash%num_buckets].include?(key)
  end

  def set(key, val)
    if @count == num_buckets
      resize!
    end
    if include?(key)
      @store[key.hash%num_buckets].update(key, val)
    else 
      @store[key.hash%num_buckets].append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[key.hash%num_buckets].get(key)
  end

  def delete(key)
    @store[key.hash%num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |linkedlist|
      linkedlist.each do |node|
        yield [node.key, node.val]
      end
    end
  end

 

  # def []=(key, val)
  #   if @count == num_buckets
  #     resize!
  #   end
  #   if include?(key)
  #     @store[key.hash%num_buckets].update(key, val)
  #   else 
  #     @store[key.hash%num_buckets].append(key, val)
  #     @count += 1
  #   end
  # end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { LinkedList.new }
    @store.each do |linkedlist|
      linkedlist.each do |node|
        new_store[node.key.hash % (2*num_buckets)].append(node.key, node.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

