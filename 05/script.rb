def part1(input)
  use_crane_with_instructions(input)
end

def part2(input)
  use_crane_with_instructions(input, multiple_crates_at_once: true)
end

def exercise
  File.read('input.txt').split("\n")
end

def use_crane_with_instructions(input, multiple_crates_at_once: false)
  use_crane(
    crate_columns(input),
    moves(input),
    multiple_crates_at_once: multiple_crates_at_once
  ).map(&:first).join
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
  input[input.index("") + 1, input.length].map do |move_translation|
    moves = move_translation.split(" ").map(&:to_i).select(&:positive?)
    {count: moves.first, from: moves[1] - 1, to: moves.last - 1}
  end
end

def use_crane(crates, moves, multiple_crates_at_once:)
  moves.each do |move_set|
    moved_crates = crates[move_set[:from]].shift(move_set[:count])
    moved_crates = moved_crates.reverse if multiple_crates_at_once
    crates[move_set[:to]].unshift(*moved_crates.reverse)
  end

  crates
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

puts part1(example)
puts part1(exercise)
puts part2(example)
puts part2(exercise)