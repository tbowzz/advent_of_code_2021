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
    lines = load_lines(data)
    covered_points = plot_lines(lines, false)
    dangerous_areas = calc_dangerous_areas(covered_points)
    puts "Part 1: #{dangerous_areas}"

    covered_points = plot_lines(lines, true)
    dangerous_areas = calc_dangerous_areas(covered_points)
    puts "Part 2: #{dangerous_areas}"
  end

  def calc_dangerous_areas(covered_points)
    dangerous_areas = 0
    covered_points.each do |point, value|
      if value > 1
        dangerous_areas += 1
      end
    end
    dangerous_areas
  end

  def plot_lines(lines, allow_slope)
    covered_points = {}
    lines.each do |line|
      x1 = line[0][0]
      y1 = line[0][1]
      x2 = line[1][0]
      y2 = line[1][1]
      if y1 == y2 # Horizontal
        xs = [x1, x2].sort
        (xs[0]..xs[1]).each do |x|
          if covered_points[[x, y1]].nil?
            covered_points[[x, y1]] = 1
          else
            covered_points[[x, y1]] += 1
          end
        end
      elsif x1 == x2 # Vertical
        ys = [y1, y2].sort
        (ys[0]..ys[1]).each do |y|
          if covered_points[[x1, y]].nil?
            covered_points[[x1, y]] = 1
          else
            covered_points[[x1, y]] += 1
          end
        end
      elsif allow_slope # Sloped
        slope = (y2 - y1) / (x2 - x1)
        x = x1
        y = y1
        while true
          if covered_points[[x, y]].nil?
            covered_points[[x, y]] = 1
          else
            covered_points[[x, y]] += 1
          end
          break if x == x2
          if slope > 0 && x1 > x2
            x -= 1
            y -= 1
          elsif slope > 0
            x += 1
            y += 1
          elsif slope < 0 && x1 > x2
            x -= 1
            y += 1
          elsif slope < 0
            x += 1
            y -= 1
          end
        end
      end
    end
    covered_points
  end

  def load_lines(data)
    lines = []
    data.each do |datum|
      coords = datum.split(' -> ')
      line = []
      coords.each do |coord|
        line << coord.split(',').map(&:to_i)
      end
      lines << line
    end
    lines
  end
end

# Day05.run(test: true)
Day05.run(test: false)
