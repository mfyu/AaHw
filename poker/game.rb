require_relative "player"
require_relative "deck"
class Game
    def initialize
        @deck = Deck.new
        @player = Player.new
    end

    attr_reader :player, :deck


    def play
        5.times {|i| player.hand.add_card(deck.deck.pop)}
        puts player.hand.hand
        removed = player.prompt
        player.hand.remove_card(removed[0].to_i) if removed.length >= 1
        player.hand.remove_card(removed[2].to_i) if removed.length >= 3
        player.hand.remove_card(removed[4].to_i) if removed.length == 5

    end
end

g = Game.new
g.play


puts g.player.hand.hand