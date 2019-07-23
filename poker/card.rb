require 'colorize'

class Card

    def initialize(value, suit)
        @value = value
        @suit = suit
        case value
        when "J"
            @num = 11
        when "Q"
            @num = 12
        when "K"
            @num = 13
        when "A"
            @num = 14
        else 
            @num = value.to_i
        end
        
    end

    def to_s
        case suit
        when "DIAMOND"
            return value + " " + "♦".colorize(:red)
        when "CLUB"
            return value + " " + "♣".colorize(:blue)
        when "HEART"
            return value + " " + "♥".colorize(:red)
        when "SPADE"
            return value + " " + "♠".colorize(:blue)
        end
    end

    def >(card)
        num > card.num
    end

    def ==(card)
        num == card.num
    end

    attr_reader :value, :suit, :num
end