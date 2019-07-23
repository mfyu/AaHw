require_relative "card"
require 'colorize'
class Deck
    SUITS = %w(DIAMOND CLUB HEART SPADE)
    VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

    attr_reader :deck

    def initialize
        @deck = []
        create_deck
        shuffle
    end

    def create_deck
        VALUES.each do |v|
            SUITS.each do |s|
                @deck<<Card.new(v,s)
            end
        end
    end

    def shuffle
        @deck = @deck.shuffle
    end
end

d = Deck.new
puts d.deck

c = Card.new("2", "♦")