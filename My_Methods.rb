#!/usr/bin/ruby
module Enumerable
# Similar to each
  def my_each
    raise "Enumerators needs a block for iterating #{self}" unless block_given?

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
    raise "Enumerators needs a block for iterating #{self}" unless block_given?

    i = 0
    loop do
      value = self[i]
      yield(value, i)
      i += 1
      break if self[i].nil?
    end
  end

# Similar to Select
  def my_select
    raise "Enumerators needs a block for iterating #{self}" unless block_given?

    select = []
    self.my_each do |i| if yield(i) then select << yield(i) end end
    select
  end

# Problems with handling nil classes
  def my_all?
    raise "Enumerators needs a block for iterating #{self}" unless block_given?

    i = 0
    while yield(self[i])
      i += 1
    end
    if yield(self[i]).nil?
      yield
    else
      yield(self[i])
    end
  end

#Checked on repl.it. It's working
    def my_any?
      raise "Enumerators needs a block for iterating #{self}" unless block_given?

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
      raise "Enumerators needs a block for iterating #{self}" unless block_given?

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

# My Map
  def my_map
    raise "Enumerators needs a block for iterating #{self}" unless block_given?

    arr = []
    self.my_each do |i|
      arr << yield(i)
    end
    arr
  end

  def my_map_proc(&proc)
    raise "Enumerators needs a block for iterating #{self}" unless block_given?

    arr = []
    self.my_each do |i|
      arr << proc.call(i)
    end
    arr
  end

  def my_map_proc_yield(&proc)
    raise "Enumerators needs a block for iterating #{self}" unless block_given?

    arr = []
    proc = proc.call(i) || yield(i)
    self.my_each do |i|
      arr << proc
    end
    arr
  end

# My inject
  def my_inject(arg=nil)
    if arg.nil?
      index = 0
    else
      index = arg
    end
    result = self[index]
    until self[index + 1].nil?
      element = self[index + 1]
      result = yield(result, element)
      index += 1
    end
    result
  end
end

def multiply_els(arr)
    multiply = arr.my_inject do |result, element| result * element end
    multiply
end

my_sqr = Proc.new { |arg| arg ** 2}

bar = "======================"
# test methods
