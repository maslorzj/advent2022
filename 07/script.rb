def part1(input)
  apply_moves(crate_columns(input), moves(input))
end
def part2(input)
end
def exercise
  File.read('input.txt').split("\n")
end
def crate_columns(input)
  crates = []
  input[0, input.index("") - 1].map do |crate_row|
    crates_row = []
    crate_row.chars.each_slice(4) { |crate| crates_row << (crate.grep(/[a-zA-Z]+/) || []) }
    crates << crates_row
  end
  crates.transpose.map { |column| column.reject(&:empty?) }
end
def moves(input)
  input[input.index("") + 1, example.length].map do |move_translation|
    moves = move_translation.split(" ").map(&:to_i).select(&:positive?)
    {count: moves.first, from: moves[1], to: moves.last}
  end
end
def apply_moves(crates, moves)
end
def example
  [
    "    [D]    ",
    "[N] [C]    ",
    "[Z] [M] [P]",
    " 1   2   3 ",
    "",
    "move 1 from 2 to 1",
    "move 3 from 1 to 3",
    "move 2 from 2 to 1",
    "move 1 from 1 to 2",
  ]
end
puts moves(example).to_s
# puts part1(example)
# puts part1(exercise)
puts part2(example)
puts part2(exercise)