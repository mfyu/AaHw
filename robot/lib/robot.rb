class Robot
    def initialize
        @position = [0,0]
        @items = []
        @items_weight = 0
        @health = 100
    end

    def move_left
        @position = [position[0]-1,position[1]]
    end

    def move_right
        @position = [position[0]+1,position[1]]
    end

    def move_up
        @position = [position[0],position[1]+1]
    end

    def move_down
        @position = [position[0],position[1]-1]
    end

    def pick_up(item)
        raise ArgumentError unless item.weight < 250

        if item.weight < 250
            @items<<item
        else
            raise ArgumentError
        end

        
    end

    def items_weight
        sum = 0
        @items.each do |item|
            sum+=item.weight
        end
        sum
    end

    def wound(amount)
        @health-=amount if (@health-amount) >= 0
        @health = 0 if (@health-amount) <= 0
    end

    def heal(amount)
        @health+=amount if (@health+amount) <= 100
        @health = 100 if (@health+amount) > 100
    end

    def attack(robot)
        robot.wound(5)
    end

    
    attr_reader :position, :items, :health
        
    
end

class Item
    def initialize(name, weight)
        @name, @weight = name, weight
    end

    attr_reader :name, :weight
end

class Weapon
end

class Bolts
end

class Laser
end

class PlasmaCannon
end

