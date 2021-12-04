class Day05
  def self.run(test: false)
    if test
      file = 'day_05_test_input.txt'
    else
      file = 'day_05_input.txt'
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

Day05.run(test: true)
# Day05.run(test: false)
