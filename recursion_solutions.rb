require 'byebug'
# I do exclude max, so this is like `min...max`.
def range(min, max)
  return [] if max <= min
  range(min, max - 1) << max - 1
end

def sum_iter(nums)
  sum = 0
  nums.each { |num| sum += num }
  sum
end

def sum_rec(nums)
  return 0 if nums.empty?
  nums[0] + sum_rec(nums.drop(1))
end

def exp1(base, power)
  power == 0 ? 1 : base * exp1(base, power - 1)
end

def exp2(base, power)
  return 1 if power == 0

  half = exp2(base, power / 2)

  if power.even?
    half * half
  else
    # note that (power / 2) == ((power - 1) / 2) if power.odd?
    base * half * half
  end
end

class Array
  def deep_dup
    new_array = []
    self.each do |el|
      new_array << (el.is_a?(Array) ? el.deep_dup : el)
    end
    new_array
  end

  # The ultimate one-liner!
  def dd_map
    map { |el| el.is_a?(Array) ? el.dd_map : el }
  end
end

def fibs_iter(n)
  return [] if n == 0
  return [0] if n == 1

  fibs = [0, 1]

  while fibs.count < n
    fibs << fibs[-2] + fibs[-1]
  end

  fibs
end

def fibs_rec(n)
  if n <= 2
    [0, 1].take(n)
  else
    fibs = fibs_rec(n - 1)
    fibs << fibs[-2] + fibs[-1]
  end
end

class Array
  def subsets
    return [[]] if empty?
    subs = take(count - 1).subsets
    subs.concat(subs.map { |sub| sub + [last] })
  end
end

def permutations(array)
  debugger
  return [array] if array.length <= 1

  # Similar to the subsets problem, we observe that to get the permutations
  # of [1, 2, 3] we can look at the permutations of [1, 2] which are
  # [1, 2] and [2, 1] and add the last element to every possible index getting
  # [3, 1, 2], [1, 3, 2], [1, 2, 3], [3, 2, 1], [2, 3, 1], [2, 1, 3]

  # pop off the first element
  first = array.shift
  debugger
  # make the recursive call, memoize the recursive permutations call
  perms = permutations(array)
  debugger
  # we will need an array to store all our different permutations
  total_permutations = []

  perms.each do |perm|
    (0..perm.length).each do |i|
      # make an array and add it to total perms
      total_permutations << perm[0...i] + [first] + perm[i..-1]
      debugger
    end
  end
  total_permutations
end

def bsearch(nums, target)
  # nil if not found; can't find anything in an empty array
  return nil if nums.empty?

  probe_index = nums.length / 2
  case target <=> nums[probe_index]
  when -1
    bsearch(nums.take(probe_index), target)
  when 0
    probe_index # found it!
  when 1
    sub_answer = bsearch(nums.drop(probe_index + 1), target)
    sub_answer.nil? ? nil : (probe_index + 1) + sub_answer
  end

end

class Array
  def merge_sort
    return self if count < 2

    middle = count / 2

    left, right = self.take(middle), self.drop(middle)
    sorted_left, sorted_right = left.merge_sort, right.merge_sort

    merge(sorted_left, sorted_right)
  end

  def merge(left, right)
    merged_array = []
    until left.empty? || right.empty?
      merged_array << ((left.first < right.first) ? left.shift : right.shift)
    end

    merged_array + left + right
  end
end

def make_change(target, coins = [25, 10, 5, 1])
  # Don't need any coins to make 0 cents change
  return [] if target == 0
  
  return nil if coins.none? { |coin| coin <= target }

  # Optimization: make sure coins are always sorted descending in
  # size. We'll see why later.
  coins = coins.sort.reverse

  best_change = nil
  coins.each_with_index do |coin, index|
    # can't use this coin, it's too big
    next if coin > target

    # use this coin
    remainder = target - coin
    best_remainder = make_change(remainder, coins.drop(index))
    
    next if best_remainder.nil?

    this_change = [coin] + best_remainder

    # Is this better than anything we've seen so far?
    if best_change.nil? || (this_change.count < best_change.count)
      best_change = this_change
    end
  end

  best_change
end
