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
    select = []
    self.my_each do |i| select << if yield(i) end
    select
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

# Returns true if none item is true
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

# Returns number of items
  def my_count(arg=nil)
    count = 0
    value = arg
    if value.nil?
      self.my_each do |i| count += 1 end
    elsif !value.nil?
      self.my_select do |i| count += 1 if i == value end
    elsif block_given?
      self.my_each do |i| count += 1 if yield(i) end
    else
        end
    count
  end

end

end
bar = "======================"
# test methods
