#!/usr/bin/ruby
module Enumerable

  def my_each
    i = 0
    loop do
      self[i]
      yield(self[i])
      i += 1
      break if self[i].nil?
    end
  end
end

[1,3,4,5,6].my_each do |i| puts i end

[1,3,4,5,6].each do |i| puts i end
