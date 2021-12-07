class Day07
  def self.run(test: false)
    if test
      file = 'day_07_test_input.txt'
    else
      file = 'day_07_input.txt'
    end
    self.new.run(file: file)
  end

  def run(file:)
    data = File.open(file).read.strip.split(',').map(&:to_i)

    min_fuel = Float::INFINITY
    (data.min..data.max).each do |position|
      fuel = 0
      data.each do |crab|
        fuel += (position - crab).abs
      end
      min_fuel = fuel if fuel < min_fuel
    end
    puts "Part 1: #{min_fuel}"

    min_fuel = Float::INFINITY
    (data.min..data.max).each do |position|
      fuel = 0
      data.each do |crab|
        diff = (position - crab).abs
        next if diff == 0
        (1..diff).each do |change|
          fuel += change
        end
      end
      min_fuel = fuel if fuel < min_fuel
    end
    puts "Part 2: #{min_fuel}"
  end
end

# Day07.run(test: true)
Day07.run(test: false)
