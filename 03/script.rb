def perform(rucksacks_items)
  duplicated_rucksacks_items(rucksacks_items).sum { |item| item_priority(item) }
end

def duplicated_rucksacks_items(rucksacks_items)
  rucksacks_items.map { |rucksack_item| find_rucksack_dupped_item(rucksack_item) }
end

def find_rucksack_dupped_item(rucksack_items)
  items_count = rucksack_items.length
  return if items_count < 1

  first_compartment = rucksack_items[0, items_count / 2]
  second_compartment = rucksack_items[items_count / 2, items_count]
  (first_compartment.chars & second_compartment.chars).first
end

def item_priority(item)
  item.ord - (item.upcase == item ? 64 - 26 : 96)
end

def rucksacks_items
  @rucksacks_items ||= File.read('input.txt').split("\n")
end

def example
  [
    'vJrwpWtwJgWrhcsFMMfFFhFp',
    'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
    'PmmdzqPrVvPwwTWBwg',
    'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
    'ttgJtRGJQctTZtZT',
    'CrZsJsPPZsGzwwsLwLmpwMDw'
  ]
end

puts perform(example)
puts perform(rucksacks_items)
