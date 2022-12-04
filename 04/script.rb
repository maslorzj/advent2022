def day1(input)
  input.count { |elf_pair| section_inclusion?(*sections(elf_pair)) }
end

def day2(input)
  input.count { |elf_pair| sections_overlap?(*sections(elf_pair)) }
end

def exercise
  File.read('input.txt').split("\n")
end

def sections(elf_pair_input)
  elf_pair_input.split(',').map { |section_input| section_input.split('-').map(&:to_i) }
end

def section_inclusion?(first_section, second_section)
  section_included_in?(first_section, second_section) || section_included_in?(second_section, first_section)
end

def section_included_in?(section, included_section)
  section.first <= included_section.first && section.last >= included_section.last
end

def sections_overlap?(first_section, second_section)
  (first_section.first..first_section.last).cover?(second_section.first) ||
    (second_section.first..second_section.last).cover?(first_section.first)
end

def example
  [
    "2-4,6-8",
    "2-3,4-5",
    "5-7,7-9",
    "2-8,3-7",
    "6-6,4-6",
    "2-6,4-8"
  ]
end

puts day1(example)
puts day1(exercise)
puts day2(example)
puts day2(exercise)