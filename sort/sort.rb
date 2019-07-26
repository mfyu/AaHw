list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
require "byebug"
def my_min(list)
    list.each do |n1|
        if list.all? {|n2| n1<=n2}
            return n1
        end
    end
end

def my_min(list)
    min = list[0]
    list.each do |n1|
        min = n1 if min > n1
    end
    min
end

def first_anagram(string)
    string_arr = string.split("")
    string_arr.permutation.to_a.map do |a|
        a.join("")
    end
end


def two_sum?(arr, target_sum)
    arr.each do |n1|
        arr.each do |n2|
            if n1+n2 == target_sum
                return true
            end
        end
    end
    false
end

def two_sum_hash(arr, target_sum)
    complements = {}
    arr.each do |n|
        return true if complements[target_sum-n]
        complements[n] = true
    end
    false
end
#Given an array, and a window size w, find the maximum range (max - min) within a set of w elements.
def windowed_max_range(arr, w)
    range = 0
    i = 0
    until i+w==arr.length+1
        if arr[i...w+i].max-arr[i...w+i].min > range
            range = arr[i...w+i].max-arr[i...w+i].min
        end
        i+=1
    end
    range
end


#debugger


arr = [1,2,3,5]
w = 2
puts windowed_max_range([1, 0, 2, 5, 4, 8,41,4,4,1,4,4,241,1,1341,4554,252,76,86,653,4567,2,234,123,123,456,897,789,678,5786,17,81,5,4656,457,7], 9) # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5)  # 3, 2, 5, 4, 8

