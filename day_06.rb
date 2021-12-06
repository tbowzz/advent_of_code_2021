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
    data = File.open(file).read.strip.split(',').map(&:to_i)
    count = get_counts(data, 80)
    puts "Part 1: #{count}"
    count = get_counts(data, 256)
    puts "Part 2: #{count}"
  end

  def get_counts(data, days)
    school = {}
    data.each do |fish|
      if school[fish].nil?
        school[fish] = 0
      end
      school[fish] += 1
    end

    (1..days).each do |day|
      new_school = {}
      school.each_pair do |fish, count|
        if fish == 0
          if new_school[6].nil?
            new_school[6] = count
          else
            new_school[6] += count
          end
          if new_school[8].nil?
            new_school[8] = count
          else
            new_school[8] += count
          end
        else
          if new_school[fish - 1].nil?
            new_school[fish - 1] = count
          else
            new_school[fish - 1] += count
          end
        end
      end
      school = new_school
    end
    school.values.inject(:+)
  end
end

# Day06.run(test: true)
Day06.run(test: false)
