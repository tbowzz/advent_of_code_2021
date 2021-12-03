text = File.open('day_01_input.txt').read
data = text.each_line.map { |line| Integer(line) }

# Part 1
previous = 5000000
increases = 0
data.each do |datum|
  if datum > previous
    increases += 1
  end
  previous = datum
end
puts "Part 1: #{increases} increases"

# Part 2
previous = 5000000
increases = 0
(0..(data.length - 3)).each do |index|
  sum = data[index] + data[index + 1] + data[index + 2]
  if sum > previous
    increases += 1
  end
  previous = sum
end
puts "Part 2: #{increases} increases"
