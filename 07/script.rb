def part1(input)
  get_dir_sizes(input).sum do |dir_data|
    dir_data[:total_size] < 100000 ? dir_data[:total_size] : 0
  end
end
def part2(input)
  dir_sizes = get_dir_sizes(input)
  available_space = 70000000
  needed_space = 30000000
  total_used_space = dir_sizes.sum { |a| a[:direct_size] }
  excedent_space = total_used_space + needed_space - available_space
  sorted_dir_sizes = dir_sizes.map { |dir| dir[:total_size] }.sort
  puts "exc: #{excedent_space}"
  puts "sorted: #{sorted_dir_sizes}"
  sorted_dir_sizes.find do |dir_total_size|
    puts "tot: #{dir_total_size}"
    dir_total_size >= excedent_space
  end
end
def exercise
  File.read('input.txt').split("\n")
end
def get_dir_sizes(input)
  tree = get_file_tree(input)
  dir_direct_sizes = tree.map { |path, files| {path: path, direct_size: files.sum { |file| file[:size].to_i } } }
  dir_direct_sizes.map do |dir|
    total_size = dir_direct_sizes.sum do |dir_data|
      (dir[:path] == "." || dir_data[:path].start_with?(dir[:path])) ? dir_data[:direct_size] : 0
    end
    dir.merge(total_size: total_size)
  end
end
def get_file_tree(input)
  tree = {}
  current_path = []
  commands(input).each do |command_line|
    if command_line[:command] == "cd"
      if command_line[:argument] == "/"
        current_path = []
      elsif command_line[:argument] == ".."
        current_path.pop
      else
        current_path << command_line[:argument]
      end
    end
    if command_line[:command] == "ls"
      path = current_path.join("/")
      path = "." if path == ""
      tree[path] = tree[path].to_a + files_data_from_list(command_line[:result]).to_a
    end
  end
  tree
end
def commands(input)
  input.join("\n").split("$ ").map do |input_and_output|
    next if input_and_output.empty?
    outputs = input_and_output.split("\n")
    input = outputs.shift
    command, command_arg = input.split(" ")
    {
      command: command,
      argument: command_arg,
      result: outputs
    }
  end.compact
end
def files_data_from_list(result)
  result.map do |file_or_dir|
    next if file_or_dir.start_with?('dir')
    file_info = file_or_dir.split(' ')
    {size: file_info.first, name: file_info.last.to_s}
  end.compact
end
def example
  [
    "$ cd /",
    "$ ls",
    "dir a",
    "14848514 b.txt",
    "8504156 c.dat",
    "dir d",
    "$ cd a",
    "$ ls",
    "dir e",
    "29116 f",
    "2557 g",
    "62596 h.lst",
    "$ cd e",
    "$ ls",
    "584 i",
    "$ cd ..",
    "$ cd ..",
    "$ cd d",
    "$ ls",
    "4060174 j",
    "8033020 d.log",
    "5626152 d.ext",
    "7214296 k",
  ]
end
# puts commands(example)
# puts get_file_tree(example)
puts get_dir_sizes(example)
puts part1(example)
# puts commands(exercise)
# puts get_file_tree(exercise)
# puts get_dir_sizes(exercise)
puts part1(exercise)
puts part2(example)
puts part2(exercise)