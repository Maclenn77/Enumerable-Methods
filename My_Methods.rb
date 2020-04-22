#!/usr/bin/ruby
module Enumerable
  # Similar to each
  def my_each
    return enum_for unless block_given?

    arr = to_a
    i = 0
    until i == size
      arr[i]
      yield(arr[i])
      i += 1
    end
    self
  end

  # similar to each_with_index
  def my_each_with_index
    return enum_for unless block_given?

    arr = to_a
    i = 0
    loop do
      value = arr[i]
      yield(value, i)
      i += 1
      break if i == length
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
  def my_all?(check = nil)
    count = 0

    if check
      my_each { |n| count += 1 if check === n }
    elsif block_given?
      my_each { |n| count += 1 if proc.call(n) }
    else
      my_each { |n| count += 1 if n }
    end
    count == size
  end

  # Checked on repl.it. It's working
  def my_any?(check = nil)
    i = 0

    if check
      my_each { |n| i += 1 if check === n }
    elsif block_given?
      my_each { |n| i += 1 if yield(n) }
    else
      my_each { |n| i += 1 if n }
    end
    i.positive?
  end

  # Returns true if none item is true
  def my_none?(arg = nil)
    return !my_any?(arg) unless block_given?

    !my_any?(&proc)
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
  def my_inject(*parameter)
    arr = to_a
    result = arr[0]
    result = parameter[0] + arr[0] if parameter[0].is_a? Numeric
    arr = arr[1..-1]

    if parameter[-1].is_a? Symbol
      op = parameter[-1]
      arr.my_each { |n| result = result.send(op, n) }
    else
      arr.my_each { |x| result = proc.call(result, x) }
    end
    result
  end
end

def multiply_els(arr)
  multiply = arr.my_inject { |result, element| result * element }
  multiply
end
