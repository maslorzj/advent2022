def solution
  values = File.read('input.txt').to_s.split("\n")
  elf_count = 0
  calorie_list_by_elf = values.group_by { |value| elf_count += 1 if value == ""; elf_count }
  total_calories_by_elf = calorie_list_by_elf.transform_values do |calorie_list|
    calorie_list.sum(&:to_i)
  end
  total_calories_by_elf.values.max
end

puts solution
