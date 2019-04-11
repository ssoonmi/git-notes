require 'byebug'

class Array
  def merge_sort(&prc) # Procifies the block
    # prc is nil if no block is given
    # `||=` is lazy initialization, if prc is nil, assign it to the left side
    prc ||= Proc.new { |x, y| x <=> y } # sort in ascending order
    return self if self.count <= 1 # self is the array we are calling merge sort on

    middle = self.length / 2
    left = self[0...middle]
    right = self[middle..-1]

    sorted_left = left.merge_sort(&prc) # merge_sort needs to be called on an Array
    sorted_right = right.merge_sort(&prc) # blockify the proc and pass it into merge_sort
    # merge is a class method, so it needs to be called on the Array class
    # instance methods are implicit in an instance method, but not class methods
    Array.merge(sorted_left, sorted_right, prc) # don't need to blockify this proc
  end

  private # anything under this should only be called in the class itself
  # private class method
  # User outside of the Array class should not be able to use this method alone,
  # only through merge_sort
  def self.merge(left, right, prc)
    result = []
    until left.empty? || right.empty?
      if prc.call(left[0], right[0]) <= 0
        
        result << left.shift
      else
        result << right.shift
      end
    end

    result + left + right
  end
end

arr = [3,6,1,8,2]
p arr.merge_sort { |x, y| y <=> x }