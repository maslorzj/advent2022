def part1(input)
  tree_grid = tree_grid(input)
  tree_grid.map.with_index do |tree_row, y_position|
    tree_row.map.with_index { |tree, x_position| tree_visible?(tree_grid, x_position, y_position) }
  end.flatten.count(&:itself)
end

def part2(input)
  tree_grid = tree_grid(input)
  tree_grid.map.with_index do |tree_row, y_position|
    tree_row.map.with_index { |tree, x_position| tree_scenic_score(tree_grid, x_position, y_position) }
  end.flatten.max
end

def tree_grid(input)
  input.map { |row| row.chars.map(&:to_i) }
end

def tree_visible?(tree_grid, x_position, y_position)
   # tree in top or left border
  return true if x_position == 0 || y_position == 0
   # tree in bottom or right border
  return true if (y_position + 1 >= tree_grid.length) || (x_position + 1 >= tree_grid[y_position].length)
  trees_to_check = trees_seen_from_tree(tree_grid, x_position, y_position)
  tree_value = tree_grid[y_position][x_position]
  !trees_to_check.all? { |tree_list| tree_list.max >= tree_value }
end

def tree_scenic_score(tree_grid, x_position, y_position)
  tree_value = tree_grid[y_position][x_position]
  trees = trees_seen_from_tree(tree_grid, x_position, y_position)
  trees.map do |tree_line|
    blocking_sight_tree_index = tree_line.index { |tree| tree >= tree_value }
    blocking_sight_tree_index ? blocking_sight_tree_index + 1 : tree_line.length
  end.reduce(:*)
end

def trees_seen_from_tree(tree_grid, x_position, y_position)
  [
    # reversing some to have the closest trees to position in first position of each array
    tree_grid[y_position][0, x_position].reverse,
    tree_grid[y_position][x_position+1..-1],
    tree_grid[0, y_position].map { |tree_row| tree_row[x_position] }.reverse,
    tree_grid[y_position+1..-1].map { |tree_row| tree_row[x_position] }
  ]
end

def exercise
  File.read('input.txt').split("\n")
end

def example
  [
    "30373",
    "25512",
    "65332",
    "33549",
    "35390",
  ]
end

puts part1(example)
puts part1(exercise)
puts part2(example)
puts part2(exercise)