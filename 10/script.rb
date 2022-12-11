def part1(input)
  signal_strengths = register_values(input).map.with_index { |value, index| value * (index +1) }
  reduce_indexes(signal_strengths, 20, 60, 100, 140, 180, 220)
end

def part2(input)
  register_values = register_values(input)

  grid = Array.new(6, (0..39).to_a)
  ctr_output = grid.map.with_index do |row, x|
    row.map do |y|
      cycle = (x*40) + y
      pixel_distance = y - register_values[cycle]
      (pixel_distance * (pixel_distance <=> 0) < 2) ? '#' : '.'
    end
  end

  ctr_output.each { |line| puts line.join }
end

def register_values(input)
  register_value = 1
  register_diffs = [0] + input.map { |line| signal_line_to_register_diff_at_end_of_cycle(line) }
  
  register_diffs.flatten.map.with_index { |register_diff, index| (register_value += register_diff) }
end

def signal_line_to_register_diff_at_end_of_cycle(signal_line)
  cmd, arg = signal_line.split(' ')

  # 'noop' takes one cycle and does not change register value 
  # 'addx Y' takes two cycles and changes register value by Y after the second cycle
  arg.nil? ? [0] : [0, arg.to_i]
end

def reduce_indexes(signal_strengths, *indexes)
  indexes.sum { |index| signal_strengths[index -1].to_i }
end

def exercise
  File.read('input.txt').split("\n")
end

def my_example
  [
    "addx 3",
    "noop"
  ]
end

def example
  [
    "addx 15",
    "addx -11",
    "addx 6",
    "addx -3",
    "addx 5",
    "addx -1",
    "addx -8",
    "addx 13",
    "addx 4",
    "noop",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx -35",
    "addx 1",
    "addx 24",
    "addx -19",
    "addx 1",
    "addx 16",
    "addx -11",
    "noop",
    "noop",
    "addx 21",
    "addx -15",
    "noop",
    "noop",
    "addx -3",
    "addx 9",
    "addx 1",
    "addx -3",
    "addx 8",
    "addx 1",
    "addx 5",
    "noop",
    "noop",
    "noop",
    "noop",
    "noop",
    "addx -36",
    "noop",
    "addx 1",
    "addx 7",
    "noop",
    "noop",
    "noop",
    "addx 2",
    "addx 6",
    "noop",
    "noop",
    "noop",
    "noop",
    "noop",
    "addx 1",
    "noop",
    "noop",
    "addx 7",
    "addx 1",
    "noop",
    "addx -13",
    "addx 13",
    "addx 7",
    "noop",
    "addx 1",
    "addx -33",
    "noop",
    "noop",
    "noop",
    "addx 2",
    "noop",
    "noop",
    "noop",
    "addx 8",
    "noop",
    "addx -1",
    "addx 2",
    "addx 1",
    "noop",
    "addx 17",
    "addx -9",
    "addx 1",
    "addx 1",
    "addx -3",
    "addx 11",
    "noop",
    "noop",
    "addx 1",
    "noop",
    "addx 1",
    "noop",
    "noop",
    "addx -13",
    "addx -19",
    "addx 1",
    "addx 3",
    "addx 26",
    "addx -30",
    "addx 12",
    "addx -1",
    "addx 3",
    "addx 1",
    "noop",
    "noop",
    "noop",
    "addx -9",
    "addx 18",
    "addx 1",
    "addx 2",
    "noop",
    "noop",
    "addx 9",
    "noop",
    "noop",
    "noop",
    "addx -1",
    "addx 2",
    "addx -37",
    "addx 1",
    "addx 3",
    "noop",
    "addx 15",
    "addx -21",
    "addx 22",
    "addx -6",
    "addx 1",
    "noop",
    "addx 2",
    "addx 1",
    "noop",
    "addx -10",
    "noop",
    "noop",
    "addx 20",
    "addx 1",
    "addx 2",
    "addx 2",
    "addx -6",
    "addx -11",
    "noop",
    "noop",
    "noop",
  ]
end

puts part1(my_example)
puts part1(example)
puts part1(exercise)
part2(example)
puts '-----'
part2(exercise)