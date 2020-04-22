#!/usr/bin/ruby
module Enumerable
  # Similar to each
  def my_each
    return enum_for unless block_given?
    arr = to_a
    i = 0
    loop do
      arr[i]
      yield(arr[i])
      i += 1
      break if i == length
    end
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
    arr = to_a
    checker = proc { |n| check === n }
    count = 0

    if check
      count += 1 while checker.call(arr[count])
    elsif block_given?
      count += 1 while proc.call(arr[count])
    else
      count += 1 while arr[count]
    end
    count == length
  rescue
    count == length
  end

  # Checked on repl.it. It's working
  def my_any?(check = nil)
    arr = to_a
    i = 0
    checker = proc { |n| check === n }
    if check
      i += 1 until checker.call(arr[i]) or i == length
    elsif block_given?
      i += 1 until yield(arr[i]) or i == length
    else
      i += 1 until arr[i] or i == length
    end
    i < length
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
  def my_inject(start = 0, *operator)
    i = 0
    result = start
    arr = to_a

    if operator
      operation = proc { |prod, element| prod.send(operator, element)}
      until i + 1 == length
        element = arr[i + 1]
        result = operation.call(result, element)
        i += 1
      end
    else
      until i + 1 == length
      element = arr[i + 1]
      result = yield(result, element)
      i += 1
    end
    result
  end
end

def multiply_els(arr)
  multiply = arr.my_inject { |result, element| result * element }
  multiply
end
