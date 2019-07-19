class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new()}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0..5).each {|i|@cups[i]=[:stone,:stone,:stone,:stone]}
    (7..12).each {|i|@cups[i]=[:stone,:stone,:stone,:stone]}

  end

  def valid_move?(start_pos)
    side1 = (0..5).to_a
    side2 = (7..12).to_a
    if !(side1.include?(start_pos) || side2.include?(start_pos))
      raise "Invalid starting cup"
    end
    if @cups[start_pos].length == 0
      raise "Starting cup is empty"
    end
    true
  end

  def make_move(start_pos, current_player_name)
    start_stones = @cups[start_pos].length
    current_pos = start_pos+1
    @cups[start_pos] = []
    while start_stones > 0
      if !((current_player_name == @name1 && current_pos == 13) || (current_player_name == @name2 && current_pos == 6))
        @cups[current_pos]<<:stone
        start_stones -= 1
      end
      if current_pos==13
        current_pos=0 if start_stones != 0
      else 
        current_pos += 1 if start_stones != 0
      end
    end 
    render
    next_turn(current_pos, current_player_name)
  end

  def next_turn(current_pos, current_player_name)
    if (current_player_name == @name1 && current_pos == 6) || (current_player_name == @name2 && current_pos == 13)
      return :prompt
    elsif @cups[current_pos].length > 1
      return current_pos
    end
    return :switch
    # helper method to determi
    ne whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    compare = @cups[6].length <=> @cups[13].length
    return :draw if compare == 0
    return @name2 if compare == -1
    return @name1 if compare == 1
  end
end

b = Board.new('a','as')

b.render
