class Day04
  def self.run(test: false)
    if test
      file = 'day_04_test_input.txt'
    else
      file = 'day_04_input.txt'
    end
    self.new.run(file: file)
  end

  def run(file:)
    text = File.open(file).read
    data = text.each_line.map { |line| line.strip }
    all_selections = load_selections(data)
    boards = load_boards(data)

    play_counts = []
    played_numbers_all_games = []
    boards.each do |board|
      single_played_numbers = play_bingo(board, all_selections)
      play_counts << single_played_numbers.count
      played_numbers_all_games << single_played_numbers
    end

    min = play_counts.min
    winner_index = play_counts.index(min)
    winner_sum = calc_unmarked_sum(boards[winner_index], played_numbers_all_games[winner_index])
    winner_score = winner_sum * played_numbers_all_games[winner_index].last
    puts "Part 1: #{winner_score}"

    max = play_counts.max
    loser_index = play_counts.index(max)
    loser_sum = calc_unmarked_sum(boards[loser_index], played_numbers_all_games[loser_index])
    loser_score = loser_sum * played_numbers_all_games[loser_index].last
    puts "Part 2: #{loser_score}"
  end

  def play_bingo(board, all_selections)
    played_numbers = []
    all_selections.each do |selection|
      played_numbers << selection
      next if played_numbers.count < 5
      is_solved = check_if_solved(board, played_numbers)
      break if is_solved
    end
    played_numbers
  end

  def check_if_solved(board, played_numbers)
    board.each do |row|
      if (played_numbers - row).count == played_numbers.count - 5
        return true
      end
    end

    board.transpose.each do |row|
      if (played_numbers - row).count == played_numbers.count - 5
        return true
      end
    end
    false
  end

  def calc_unmarked_sum(board, played_numbers)
    sum = 0
    board.each do |row|
      row.each do |col|
        unless played_numbers.include?(col)
          sum += col
        end
      end
    end
    sum
  end

  def load_selections(file_data)
    raw_selections = file_data.first
    raw_selections.split(',').map(&:to_i)
  end

  def load_boards(file_data)
    boards = []
    board = []
    file_data.each_with_index do |line, index|
      next if index == 0
      if line.empty?
        boards << board unless board.empty?
        board = []
        next
      end
      row = line.split.map(&:to_i)
      board << row
    end
    boards << board unless board.empty?
    boards
  end
end

# Day04.run(test: true)
Day04.run(test: false)
