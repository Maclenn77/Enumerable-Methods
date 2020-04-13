#!/usr/bin/ruby
module Enumerable

  def my_Each
    i = 0
    loop do
      self[i]
      i += 1
      yield(i)
      break if self[i].nil?
    end
  end
end

[1,3,4,5,6].my_Each do |i| puts i end
