def part1(input)
end

def part2(input)
end

def exercise
  File.read('input.txt')
end

def get_dir_sizes(input)
  tree = get_file_tree(input)
  tree.map { |path, files| files.map { |name, data| puts("name ", name, "data", data) } }
end

def get_file_tree(input)
  tree = {}
  current_path = []
  commands(input).each do |command_line|
    if command_line[:command] == "cd"
      if command_line[:argument] == "/"
        current_path = []
      elsif command_line[:argument] == ".."
        current_path.shift
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
  input.join("\n").split("$ ").filter_map do |input_and_output|
    next if input_and_output.empty?

    outputs = input_and_output.split("\n")
    input = outputs.shift

    command, command_arg = input.split(" ")

    {
      command: command,
      argument: command_arg,
      result: outputs
    }
  end
end

def files_data_from_list(result)
  result.filter_map do |file_or_dir|
    next if file_or_dir.start_with?('dir')

    file_info = file_or_dir.split(' ')
    {file_info.last.to_s => {size: file_info.first}}
  end
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

puts commands(example)
puts get_file_tree(example)
puts get_dir_sizes(example)
# puts part1(example)
# puts part1(exercise)
# puts part2(example)
# puts part2(exercise)