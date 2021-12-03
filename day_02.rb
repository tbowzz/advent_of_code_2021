text = File.open('day_02_input.txt').read
data = text.each_line.map { |line| line }

# Part 1
hor_position = 0
depth_position = 0
data.each do |datum|
  directions = datum.split(' ')
  instruction = directions[0].strip
  units = Integer(directions[1].strip)
  if instruction.include?('forward')
    hor_position += units
  elsif instruction.include?('down')
    depth_position += units
  elsif instruction.include?('up')
    depth_position -= units
  end
end

puts "Part 1: #{depth_position * hor_position}"

# Part 2
hor_position = 0
depth_position = 0
aim = 0
data.each do |datum|
  directions = datum.split(' ')
  instruction = directions[0].strip
  units = Integer(directions[1].strip)
  if instruction.include?('forward')
    hor_position += units
    depth_position = depth_position + (aim * units)
  elsif instruction.include?('down')
    # depth_position += units
    aim += units
  elsif instruction.include?('up')
    # depth_position -= units
    aim -= units
  end
end

puts "Part 2: #{depth_position * hor_position}"
