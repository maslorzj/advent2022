def part1(input)
  monkeys_args = input.split("\n\n").map { |monkey_input| Monkey.parse_input(monkey_input) }
  monkeys = monkeys_args.map { |monkey_args| Monkey.new(*monkey_args, relieved: true) }
  game = MonkeyInTheMiddle.new(monkeys)
  game.play_turns!(20)
  game.monkeys.map(&:inspection_count).max(2).reduce(:*)
end

def part2(input)
  monkeys_args = input.split("\n\n").map { |monkey_input| Monkey.parse_input(monkey_input) }
  monkeys = monkeys_args.map { |monkey_args| Monkey.new(*monkey_args) }
  game = MonkeyInTheMiddle.new(monkeys)
  game.play_turns!(10000)
  game.monkeys.map(&:inspection_count).max(2).reduce(:*)
end

def extract_integer(string)
  string.gsub(/[^0-9]/, '').to_i
end

class Monkey
  attr_accessor :name, :items, :inspection_count, :division_check

  def self.parse_input(input)
    name, items, worry_change, division_check, dividable_target, non_dividable_target = input.split("\n")
    name = extract_integer(name)
    item_worries = items.gsub('Starting items: ', '').split(', ').map { |worry| extract_integer(worry) }
    worry_change_operator, worry_change_by = worry_change.gsub('Operation: new = old ', '').split(' ')
    
    [
      name,
      item_worries,
      {operator: worry_change_operator, by: worry_change_by},
      extract_integer(division_check),
      extract_integer(dividable_target),
      extract_integer(non_dividable_target)
    ]
  end

  def initialize(name, item_worries, worry_change, division_check, dividable_target_name, non_dividable_target_name, relieved: nil)
    @name = name
    @items = item_worries.map { |worry| Item.new(worry) }
    @worry_change = worry_change
    @division_check = division_check
    @dividable_target_name = dividable_target_name
    @non_dividable_target_name = non_dividable_target_name
    @inspection_count = 0
    @relieved = !!relieved
  end

  def inspect!(item, loop_limit: nil)
    @inspection_count += 1
    change_by = worry_change[:by] == 'old' ? item.worry : worry_change[:by].to_i
    new_worry = item.worry.public_send(worry_change[:operator], change_by)
    # puts "monkey ##{name} worry from #{item.worry} to #{new_worry}"
    new_worry = (new_worry.zero? ? 0 : new_worry / 3 ).to_i if @relieved
    new_worry = new_worry % loop_limit if loop_limit
    # puts "relaxing: worry decreases to #{new_worry}"
    item.worry = new_worry
  end

  def catch!(item)
    items << item
  end

  def throw!(item)
    items.shift
  end

  def target_name(item)
    (item.worry % division_check).zero? ? dividable_target_name : non_dividable_target_name
  end

  private

  attr_reader :worry_change, :dividable_target_name, :non_dividable_target_name
end

class MonkeyInTheMiddle
  attr_reader :monkeys, :numbering_loop_limit

  def initialize(monkeys)
    @monkeys = monkeys
    @numbering_loop_limit = monkeys.map(&:division_check).reduce(:*)
  end

  def play_turns!(turns_count)
    turns_count.times do |count|
      puts "round #{count}: #{monkeys.map(&:inspection_count)}" if [1, 2, 20, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000].include?(count)
      play_turn!
    end
  end

  def play_turn!
    monkeys.each do |monkey|
      # puts "Monkey ##{monkey.name}'s turn ------------------------------------------ items #{monkey.items.map(&:worry)}"
      monkey.items.dup.each do |item|
        monkey.inspect!(item, loop_limit: numbering_loop_limit)
        target_name = monkey.target_name(item)
        target = monkeys.find { |monkey| monkey.name == target_name }
        # puts "will throw item to #{target_name}"
        monkey.throw!(item)
        # puts "new monkey items: #{monkey.items.map(&:worry)}"
        target.catch!(item)
        # puts "new target monkey items: #{target.items.map(&:worry)}"
      end
    end
  end
end

class Item
  attr_accessor :worry

  def initialize(worry)
    @worry = worry
  end
end

def exercise
  File.read('input.txt')
end

def example
  File.read('example.txt')
end

puts part1(example)
puts part1(exercise)
puts part2(example)
puts part2(exercise)