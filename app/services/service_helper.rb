# frozen_string_literal: true

class ServiceHelper
  # find intersection with duplicates
  def self.find_commons(array_1:, array_2:)
    array_c = array_1 & array_2 # find common elements wihtout dup
    final_array = []
    array_c.each do |n|
      common_num = [array_1.count(n), array_2.count(n)].min # how many duplicates
      final_array += Array.new(common_num, n) # add to find array those common duplicates
    end
    final_array.flatten # flatten to plain array
  end

  # substract including duplicates
  def self.substract(array_1:, array_2:)
    array_2.each do |n| # for each number in array2
      if index = array_1.index(n) # if that number is present in array1 find index
        array_1.delete_at(index) # and delete this index
      end
    end
  end
end
