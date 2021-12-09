class Day08
  def self.run(test: false)
    if test
      file = 'day_08_test_input.txt'
    else
      file = 'day_08_input.txt'
    end
    self.new.run(file: file)
  end

  def run(file:)
    text = File.open(file).read
    data = text.each_line.map { |line| line.strip }
    notes = parse_input(data)
    known_digits = initialize_digits(notes)
    count = count_known_digits(notes, known_digits)
    puts "Part 1: #{count}"

    sum = deduce_digits(notes)
    puts "Part 2: #{sum}"
  end

  def deduce_digits(notes)
    values_to_sum = []
    notes.each do |note|
      keys = {}
      five_length = []
      six_length = []
      note[:signal_patterns].each do |val|
        val = val.split('').sort.join
        if val.length == 2
          keys['1'] = val
        elsif val.length == 3
          keys['7'] = val
        elsif val.length == 4
          keys['4'] = val
        elsif val.length == 7
          keys['8'] = val
        elsif val.length == 5
          five_length << val
        elsif val.length == 6
          six_length << val
        end
      end

      keys['6'] = six_length.find { |s| !keys['1'].chars.all? { |c| s.include?(c) } }
      six_length.delete(keys['6'])
      keys['9'] = six_length.find { |s| keys['4'].chars.all? { |c| s.include?(c) } }
      six_length.delete(keys['9'])
      keys['0'] = six_length.pop

      keys['5'] = five_length.find { |s| s.chars.all? { |c| keys['6'].chars.include?(c) } }
      five_length.delete(keys['5'])
      keys['3'] = five_length.find { |s| keys['1'].chars.all? { |c| s.include?(c) } }
      five_length.delete(keys['3'])
      keys['2'] = five_length.pop

      keys = keys.sort.to_h
      decoder = keys.invert

      output = ''
      note[:output_value].each do |val|
        prepped = val.split('').sort.join
        digit = decoder[prepped]
        output += digit
      end
      values_to_sum << output.to_i
    end
    values_to_sum.inject(:+)
  end

  def initialize_digits(notes)
    known_digits = (0..9).map {|i| [] }
    notes.each do |note|
      note[:output_value].each do |val|
        index = assign_digit_index(val)
        known_digits[index] << val unless index.nil?
        known_digits[index].uniq! unless index.nil?
      end
    end
    known_digits
  end

  def assign_digit_index(val)
    if val.length == 2
      return 1
    elsif val.length == 4
      return 4
    elsif val.length == 3
      return 7
    elsif val.length == 7
      return 8
    end
    nil
  end

  def count_known_digits(notes, known_digits)
    found_known_count = 0
    notes.each do |note|
      known_digits.each do |known|
        known.each do |k|
          note[:output_value].each do |val|
            if val == k
              found_known_count += 1
            end
          end
        end
      end
    end
    found_known_count
  end

  def parse_input(data)
    notes = []
    data.each do |datum|
      note = datum.split('|').map(&:strip)
      signal_patterns = note[0].split
      output_value = note[1].split
      notes << { signal_patterns: signal_patterns, output_value: output_value }
    end
    notes
  end
end

# Day08.run(test: true)
Day08.run(test: false)
