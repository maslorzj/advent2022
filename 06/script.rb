def part1(input)
  find_distinct_chars_end_index(input, length: 4)
end

def part2(input)
  find_distinct_chars_end_index(input, length: 14)
end

def exercise
  File.read('input.txt').split("\n").first
end

def find_distinct_chars_end_index(input, length: 4)
  characters = input.chars
  characters.find_index.with_index do |char, index|
    return nil if index > characters.length - length

    characters[index, length].uniq.length == length
  end + length
end

def examples
  [
    "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
    "bvwbjplbgvbhsrlpgdmjqwftvncz",
    "nppdvjthqldpwncqszvftbrmjlhg",
    "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
    "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
  ]
end

examples.each { |example| puts part1(example) }
puts part1(exercise)
examples.each { |example| puts part2(example) }
puts part2(exercise)