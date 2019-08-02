require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"
class LRUCache
  attr_reader :max, :prc

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end
  
  def count
    map.count
  end

  def get(key)
    if map[key]
      node = map[key]
      update_node!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + map.to_s + '\n' + 'Store: ' + store.to_s
  end

  def test
    store.map{|l| l.key}

  end

  private
  attr_reader :store, :map
  

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = self.prc.call(key)
    new_node = store.append(key, val)
    map[key] = new_node
    eject! if count > @max
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    map[node.key] = store.append(node.key, node.val)

  end

  def eject!
    rm_node = store.first
    rm_node.remove
    map.delete(rm_node.key)
    nil
  end
end

# lru = LRUCache.new(3, Proc.new{|n|n*n})

# lru.get(1)
# lru.get(2)
# lru.get(3)

# puts lru

# print lru.test