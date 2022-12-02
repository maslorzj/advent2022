def solution
  turns = File.read('input.txt').split("\n")
  turns.map! { |turn| turn_score_with_expected_result(turn) }
  puts turns
  puts turns.sum
end

def turn_score_with_expected_choice(turn)
  elf_play, my_play = turn.split(" ")
  elf_play = elf_play.downcase.ord % 3
  my_play = my_play.downcase.ord % 3
  choice_score = my_play + 1
  win_score = ((my_play - 1 - elf_play) % 3) * 3

  choice_score + win_score
end

def turn_score_with_expected_result(turn)
  elf_play, result = turn.split(" ")
  elf_play = (elf_play.downcase.ord - 1) % 3
  result = (result.downcase.ord - 1) % 3
  my_play = (elf_play + result) % 3
  choice_score = my_play + 1
  win_score = (result + 1) % 3 * 3

  puts "elf_play: #{elf_play}"
  puts "my_play: #{my_play}"
  puts "choice_score: #{choice_score}"
  puts "win_score: #{win_score}"

  choice_score + win_score
end

# a play is a module 3, 0 being rock, 1 being paper, 2 being scissors

solution
