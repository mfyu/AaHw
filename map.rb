require "byebug"
class Map
    def initialize
        @map = [["cats",5]]
    end

    def set(k, v)
        @map<<[k,v] if @map.empty?
        @map.each.with_index do |e,i|
            if @map[i][0] == k
                puts i
                @map[i] = [k,v*2]
                break
            else
                @map<<[k,v]
            end
        end
    end

    def get(k)
        @map.each.with_index do |e,i|
            if @map[i][0] == k
                return @map[i][1]
                break
            else
                raise "No Key Found"
            end
        end
    end

    def delete(k)
        @map.each.with_index do |e,i|
            if @map[i][0] == k
                @map.delete_at(i)
                break
            else
                raise "No Key Found"
            end
        end
    end

    def show
        print @map
        puts
    end
end

m = Map.new
m.show
m.set("dogs",3)
m.show
#debugger
m.set("cats",4)
m.show
puts m.get("cats")
m.delete("cats")
m.show