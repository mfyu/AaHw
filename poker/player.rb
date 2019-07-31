require_relative "hand"
class Player
    def initialize
        @hand = Hand.new
    end

    attr_reader :hand

    def prompt
        puts "Discard up to 3 cards. Type indices separated by spaces. Like '1 2 3'."
        input = gets.chomp
    end
end