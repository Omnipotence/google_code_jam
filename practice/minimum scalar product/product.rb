lines = File.readlines('A-large-practice.in')

N = lines[0].to_i

test_cases = []
N.times do |i|
	vector1 = lines[i * 3 + 2].split.map {|x| x.to_i}
	vector2 = lines[i * 3 + 3].split.map {|x| x.to_i}
	vector1.sort!
	vector2.sort!

	product = 0
	vector1.length.times do |j|
		product += vector1[j] * vector2[-1-j]
	end

	puts "Case ##{i+1}: #{product}"
end
