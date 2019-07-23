require_relative "card"
class Hand
    def initialize
        @hand = []
    end

    attr_reader :hand

    def add_card(card)
        @hand<<card
    end
    
    def remove_card(index)
        hand.delete_at(index)
    end

    def sorted
        hand.sort_by{|card| card.num}
    end

    def value_hash
        hash = Hash.new(0)
        hand.each do |card|
            hash[card.value] += 1
        end
        hash
    end

    def suit_hash
        hash = Hash.new(0)
        hand.each do |card|
            hash[card.suit] += 1
        end
        hash
    end

    def pair?
        pairs = []
        value_hash.each do |value, num|
            pairs<<value if num == 2
        end
        pairs
    end

    def three_of_kind?
        
        value_hash.each do |value, num|
            return value if num == 3
        end
        false
    end

    def four_of_kind?
        value_hash.each do |value, num|
            return value if num == 4
        end
        false
    end

    def flush?
        suit_hash.each do |suit, num|
            return suit if num == 5
        end
        false
    end

    def straight?
        return true if sorted[0].value == "2" && sorted[1].value == "3" && sorted[2].value == "4" && sorted[3].value == "5" && sorted[4].value == "A"
        sorted[1].num-sorted[0].num==1 && sorted[2].num-sorted[1].num==1 && sorted[3].num-sorted[2].num==1 && sorted[4].num-sorted[3].num==1
    end

    def full_house?
        full_house = []
        value_hash.each do |value, num|
            full_house<<value if num == 3
        end
        return false if full_house == []
        value_hash.each do |value, num|
            full_house<<value if num == 2
        end
        if full_house.length == 2
            return full_house
        else 
            return false
        end
    end

    def straight_flush?
        flush? && straight?
    end

    def royal_flush?
        straight_flush? && sorted[4].value == "A"
    end

    def evaluate_hand
        case
        when royal_flush?
            puts "Royal Flush of " + hand[0].suit
        when straight_flush?
            puts "Straight Flush of " + hand[0].suit + ", " + sorted[4].value + " high"
        when four_of_kind?
            puts "Four of a kind, " + four_of_kind?
        when full_house?
            puts "Full House " + full_house?[0] + ", " + full_house?[1]
        when flush?
            puts "Flush, " + hand[0].suit
        when straight?
            puts "Straight, " + sorted[4].value + " High"
        when three_of_kind?
            puts "Three of a kind, " + three_of_kind?
        when pair?
            puts "Pair " + pair?[0] if pair?.length == 1
            puts "Pair " + pair?[0] + " & Pair " + pair?[1] if pair?.length == 2
        end
        
    end


end

h = Hand.new
h.add_card(Card.new("J", "DIAMOND"))
h.add_card(Card.new("J", "HEART"))
h.add_card(Card.new("7", "DIAMOND"))
h.add_card(Card.new("8", "DIAMOND"))
h.add_card(Card.new("7", "DIAMOND"))

puts h.hand
puts h.value_hash
puts h.suit_hash
h.evaluate_hand
