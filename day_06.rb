class Day06
  def self.run(test: false)
    if test
      file = 'day_06_test_input.txt'
    else
      file = 'day_06_input.txt'
    end
    self.new.run(file: file)
  end

  def run(file:)
    text = File.open(file).read
    data = text.each_line.map { |line| line.strip }

    puts "Part 1: #{'empty'}"


    puts "Part 2: #{'empty'}"
  end
end

Day06.run(test: true)
# Day06.run(test: false)
