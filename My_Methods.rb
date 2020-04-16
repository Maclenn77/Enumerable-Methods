#!/usr/bin/ruby
module Enumerable
  # Similar to each
  def my_each
    return enum_for unless block_given?

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
    return enum_for unless block_given?

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
    return enum_for unless block_given?

    select = []
    my_each { |i| select << i if yield(i) }
    select
  end

  # Problems with handling nil classes
  def my_all?
    return enum_for unless block_given?

    count = 0
    count += 1 while yield(self[count])
    count == length
  end

  # Checked on repl.it. It's working
  def my_any?
    return enum_for unless block_given?

    count = 0
    i = 0
    i += 1 unless yield(self[i]) or yield(self[i]).nil?
    count += 1 if yield(self[i])
    count.positive?
  end

  # Returns true if none item is true
  def my_none?
    return enum_for unless block_given?

    result = false
    i = 0
    i += 1 until yield(self[i]) or self[i].nil?
    result = true if self[i].nil?
    result = false if yield(self[i])
    result
  end

  # Returns number of items
  def my_count(arg = nil)
    count = 0
    value = arg

    my_each { count += 1 } unless block_given? or value

    my_select { |i| count += 1 if yield(i) } if block_given?

    my_select { |i| count += 1 if i == value }

    count
  end

  # My Map
  def my_map
    return enum_for unless block_given?

    arr = []
    my_each do |i|
      arr << yield(i)
    end
    arr
  end

  def my_map_proc(&proc)
    return enum_for unless block_given?

    arr = []
    my_each do |i|
      arr << proc.call(i)
    end
    arr
  end

  def my_map_proc_yield(&proc)
    return enum_for unless block_given?

    arr = []
    my_each do |i|
      arr << proc.call(i) || yield(i)
    end
    arr
  end

  # My inject
  def my_inject(arg = nil)
    index = arg
    index = 0 if arg.nil?

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
  multiply = arr.my_inject { |result, element| result * element }
  multiply
end
