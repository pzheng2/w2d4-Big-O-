require 'benchmark'



def my_min(list)
  smallest_num = nil
  list.each do |num|
    smallest_num = num if smallest_num.nil? || num < smallest_num
  end

  smallest_num
end
# time-complexity = O(N)

def largest_contiguous_subsum(list)
  current_sum = 0
  max_sum = 0

  list.each do |num|
    current_sum += num
    current_sum = 0 if current_sum < 0
    max_sum = current_sum if max_sum < current_sum
  end

  max_sum
end

def first_anagram?(word)
  word1 = word
  anagrams = []
  a = ""
  (0...word1.length).each do |i|
    a += word1[i]
    a += word1[0...i]
    a += word1[i + 1...word1.length]
    anagrams << a
    a = ""
  end

  anagrams
end

def third_anagram?(word1, word2)
  sorted_word1_arr = word1.split('').sort
  sorted_word2_arr = word2.split('').sort
  sorted_word1_arr == sorted_word2_arr
end

def fourth_anagram?(word1, word2)
  word1_hash = Hash.new { |h, k| h[k] = 0 }

  word1.each_char do |ch|
    word1_hash[ch] += 1
  end

  word2.each_char do |ch|
    word1_hash[ch] -= 1
  end

  word1_hash.values.all? { |val| val == 0 }

end

def brute_two_sum?(arr, sum)
  arr.each do |i|
    (i...arr.length).each do |j|
      return true if sum == (i + arr[j])
    end
  end
  false
end

# O(N log(N))
def sorting_two_sum?(arr, sum)
  sorted_arr = arr.sort
  arr.each_with_index do |elem, i|
    diff = sum - elem
    p elem
    p sorted_arr[i..sorted_arr.length - 1]
    return true if bsearch(sorted_arr[i + 1..sorted_arr.length - 1], diff)
  end

  false
end

def bsearch(nums, target)
  return nil if nums.count == 0

  probe_index = nums.length / 2
  case target <=> nums[probe_index]
  when -1
    bsearch(nums.take(probe_index), target)
  when 0
    probe_index
  when 1
    sub_answer = bsearch(nums.drop(probe_index + 1), target)
    (sub_answer.nil?) ? nil : (probe_index + 1) + sub_answer
  end
end

def hash_two_sum?(arr, sum)
  hash = Hash.new { |h, k| h[k] = 0 }

  # populate hash with num and its freq
  arr.each do |num|
    hash[num] += 1
  end

  # search through the hash for the corresponding pair
  arr.each do |num|
    pair_value = sum - num
    hash[num] -= 1
    return true if hash[pair_value] > 0
    hash[num] += 1
  end

  false
end

# TODO
def four_sum?(arr, sum)
  hash = Hash.new { |h, k| h[k] = 0 }

  # populate hash with num and its freq
  arr.each do |num|
    hash[num] += 1
  end



end

# naive solution
def max_windowed_range(arr, w)
  max_window_range = nil
  current_max_range = nil

  (0..arr.length-w).each do |num|
    window = arr[num..(num + w - 1)]
    current_max_range = window.max - window.min
    max_window_range = current_max_range if max_window_range.nil? || current_max_range > max_window_range
  end

  max_window_range
end

# optimized solution
def optimized_max_windowed_range(arr, w)
  max_window_range = nil
  current_max_range = nil
  mmsq = MinMaxStackQueue.new

  w.times do |i|
    mmsq.enqueue(arr[i])
  end

  (0...arr.length - w).each_with_index do |num, index|

    mmsq.dequeue
    mmsq.enqueue(arr[index + w])

    current_max_range = mmsq.max - mmsq.min
    max_window_range = current_max_range if max_window_range.nil? || current_max_range > max_window_range
  end

  max_window_range
end

class MyStack
  def initialize; @store = []; end

  def pop; @store.pop; end

  def push(item)
    @store.push(item)
  end

  def peek; @store[size - 1]; end

  def size; @store.size; end

  def empty?; @store.empty?; end
end

class MinMaxStack
  def initialize
    @store = []
    @max_stack = MyStack.new
    @min_stack = MyStack.new
  end

  def pop
    @max_stack.pop
    @min_stack.pop
    @store.pop
  end

  def push(item)
    @store.push(item)
    # Push item into max stack if empty or if item > last max
    # Otherwise push the previous max into max stack
    if @max_stack.empty? || item > @max_stack.peek
      @max_stack.push(item)
    else
      @max_stack.push(@max_stack.peek)
    end

    # Push item into min stack if empty or if item < last min
    # Otherwise push the previous min into the min stack
    if @min_stack.empty? || item < @min_stack.peek
      @min_stack.push(item)
    else
      @min_stack.push(@min_stack.peek)
    end
  end

  def peek; @store[size - 1]; end

  def size; @store.size; end

  def empty?; @store.empty?; end

  def max
    @max_stack.peek
  end

  def min
    @min_stack.peek
  end
end

class StackQueue
  def initialize
    @in = MyStack.new
    @out = MyStack.new
  end

  def enqueue(item)
    @in.push(item)
  end

  def dequeue
    if @out.empty?
      until @in.empty?
        @out.push(@in.pop)
      end
    end

    @out.pop
  end

  def size
    @in.size + @out.size
  end

  def empty?
    @in.empty? && @out.empty?
  end

end

class MinMaxStackQueue
  def initialize
    @in = MinMaxStack.new
    @out = MinMaxStack.new
  end

  def enqueue(item)
    @in.push(item)
  end

  def dequeue
    if @out.empty?
      until @in.empty?
        @out.push(@in.pop)
      end
    end
    
    @out.pop
  end

  def max
    return @in.max if @out.max.nil?
    return @out.max if @in.max.nil?
    @in.max > @out.max ? @in.max : @out.max
  end

  def min
    return @in.min if @out.min.nil?
    return @out.min if @in.min.nil?
    @in.min < @out.min ? @in.min : @out.min
  end

end







# aklsdfj
