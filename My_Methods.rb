#!/usr/bin/ruby
module Enumerable
# Similar to each
  def my_each
    raise "Enumerator" unless block_given?

    i = 0
    loop do
      self[i]
      yield(self[i])
      i += 1
      break if self[i].nil?
    end
  end

# similar to each_with_index
  def my_each_with_index
    i = 0
    loop do
      value = self[i]
      yield(value, i)
      i += 1
      break if self[i].nil?
    end
  end

  def my_select
    self.my_each do |i|
      yield(i)
    end
  end

# Problems with handling nil classes
  def my_all
    i = 0
    while yield(self[i])
      i += 1
    end
    if yield(self[i]).nil?
      yield
    else
      yield(self[i])
    end

#Checked on repl.it. It's working
    def my_any?
      i = 0
      if self[i].nil?
        return false
      end
      until yield(self[i])
        i += 1
        if self[i].nil?
          return false
        end
      end
      yield(self[i])
    end

    def my_none?
      i = 0
      if self[i].nil?
        return true
      end
      until yield(self[i])
        i += 1
        if self[i].nil?
          return true
        end
      end
      false
      
end

end

end
bar = "======================"
# test methods
puts "Each"
puts bar
puts "My each"
[1,3,4,5,6].my_each do |i| puts i end
puts bar
[1,3,4,5,6].each do |i| puts i end
puts "Each with index"
puts bar
puts "My each with index"
[1,3,4,5,6].my_each_with_index do |i, index| puts i.to_s + " " + index.to_s end
puts bar
[1,3,4,5,6].each_with_index do |i, index| puts i.to_s + " " + index.to_s end
puts "Select"
puts bar
puts "My select"
[1,3,4,5,6].my_select do |i| puts i.to_s + " > " + "even" if i.even? end
puts bar
[1,3,4,5,6].select do |i| puts i.to_s + " > " + "even" if i.even? end
puts bar
[1,3,4,5,6].my_all do |i| i.even? end
