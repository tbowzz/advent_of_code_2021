def get_common_bits(input, num_bit_indices=11)
  common_bits = (0..num_bit_indices).map {|i| [] }
  input.each do |datum|
    bits = datum.split('')
    (0..num_bit_indices).each do |index|
      common_bits[index] << bits[index].to_i
    end
  end

  final_gamma = []
  final_eps = []
  common_bits.each do |common|
    sum = 0
    common.each do |value|
      sum += value
    end
    if sum >= (common.count / 2.0)
      answer = 1
    else
      answer = 0
    end
    final_gamma << answer

    if sum >= (common.count / 2.0)
      answer = 0
    else
      answer = 1
    end
    final_eps << answer
  end

  return final_gamma, final_eps
end

text = File.open('day_03_input.txt').read
data = text.each_line.map { |line| line.strip }

num_bit_indices = 11
final_gamma, final_eps = get_common_bits(data, num_bit_indices)

gamma = final_gamma.join('').to_i(2)
epsilon = final_eps.join('').to_i(2)
puts "Part 1: #{gamma * epsilon}"
# 2648450

ox_gen_rating = data.dup
(0..num_bit_indices).each do |i|
  final_gamma, final_eps = get_common_bits(ox_gen_rating, num_bit_indices)
  current_ox = final_gamma[i]
  ox_gen_rating.select! do |d|
    d.split('')[i].to_i == current_ox || ox_gen_rating.count == 1
  end
end

co2_rating = data.dup
(0..num_bit_indices).each do |i|
  final_gamma, final_eps = get_common_bits(co2_rating, num_bit_indices)
  current_eps = final_eps[i]
  co2_rating.select! do |d|
    d.split('')[i].to_i == current_eps || co2_rating.count == 1
  end
end
ox = ox_gen_rating[0].to_i(2)
co2 = co2_rating[0].to_i(2)
puts "Part 2: #{co2 * ox}"
# 2845944
