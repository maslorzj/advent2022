def solution
  turns = File.read('input.txt').split("\n")
  turns.map! { |turn| turn_score(turn) }
  puts turns
  puts turns.sum
end

def turn_score(turn)
  elf_play, my_play = turn.split(" ")
  elf_play = elf_play.downcase.ord % 3
  my_play = my_play.downcase.ord % 3
  choice_score = my_play + 1
  win_score = ((my_play - 1 - elf_play) % 3) * 3

  choice_score + win_score
end

solution
