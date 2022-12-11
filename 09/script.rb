def part1(input)
  initial_position = {x: 0, y: 0}
  head_position = initial_position
  tail_position = initial_position
  head_positions = [head_position]
  tail_positions = [tail_position]
  input.each do |input_line|
    head_movement = position_diff_from_movement(input_line)
    head_movement[:distance].times do
      head_position = move(head_position, head_movement)
      tail_position = move(tail_position, tail_movement(head_position, tail_position))
      head_positions << head_position
      tail_positions << tail_position
    end
  end
  tail_positions.uniq.count
end

def part2(input)
  initial_position = {x: 0, y: 0}
  head_position = initial_position
  tails_count = 9
  head_positions = [head_position]
  tails_positions = tails_count.times.map { |index| [index, [initial_position]] }.to_h
  input.each do |input_line|
    head_movement = position_diff_from_movement(input_line)
    head_movement[:distance].times do
      head_position = head_positions.last
      new_head_position = move(head_position, head_movement)
      head_positions << new_head_position
      tails_positions.each do |tail_index, tail_positions|
        tail_position = tail_positions.last
        following_position = tail_index.zero? ? new_head_position : tails_positions[tail_index - 1].last
        new_tail_position = move(tail_position, tail_movement(following_position, tail_position))
        tail_positions << new_tail_position
      end
    end
  end
  tails_positions[tails_count-1].uniq.count
end

def position_diff_from_movement(input_line)
  direction, distance = input_line.split(" ")
  x = -1 if direction == "L"
  x = 1 if direction == "R"
  y = -1 if direction == "D"
  y = 1 if direction == "U"
  {x: x.to_i, y: y.to_i, distance: distance.to_i}
end

def tail_movement(head_position, tail_position)
  diff = {x: head_position[:x] - tail_position[:x], y: head_position[:y] - tail_position[:y]}
  adjacent = diff.all? { |axis, distance| distance.abs < 2 }
  return {x: 0, y: 0} if adjacent
  diff.transform_values { |distance| 1 * (distance <=> 0) }
end

def move(position, move)
  position.map { |axis, position| [axis, position + move[axis]] }.to_h
end

def exercise
  File.read('input.txt').split("\n")
end

def example
  [
    "R 4",
    "U 4",
    "L 3",
    "D 1",
    "R 4",
    "D 1",
    "L 5",
    "R 2"
  ]
end

def example2
  [
    "R 5",
    "U 8",
    "L 8",
    "D 3",
    "R 17",
    "D 10",
    "L 25",
    "U 20",
  ]
end

puts part1(example)
puts part1(exercise)
puts part2(example2)
puts part2(exercise)