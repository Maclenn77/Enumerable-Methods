#!/usr/bin/ruby

module Enumerable

def my_Each
  for i in self.my_Each
    i
  end
end
