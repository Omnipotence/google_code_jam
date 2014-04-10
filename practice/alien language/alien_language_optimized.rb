lines = File.readlines('A-large-practice.in')

L, D, N = lines[0].split.map { |x| x.to_i }
words = lines[1..D].map { |x| x.strip }
tests = lines[D+1..D+1+N].map { |x| x.strip }

unique_characters = []
words.each do |word|
	word.each_char do |char|
		unique_characters.push char if not unique_characters.include? char
	end
end

number_of_unique_charaters = unique_characters.length
mapping = {}

# assign a bitary value to each character, for example:
# a -> 001
# b -> 010
# c -> 100
unique_characters.each do |char|
	bit = 2 ** unique_characters.index(char)
	mapping[char] = bit
end


integer_words = []

# assign a binary value to each word, for example:
# abc -> 001 010 100
words.each do |word|
	temp_int = 0
	word.each_char do |char|
		temp_int <<= number_of_unique_charaters
		temp_int += mapping[char]
	end
	integer_words.push temp_int
end

integer_tests = {}

# assign a binary value to each test, for example:
# abc -> 001 010 100
# (ab)b(bc) -> 011 010 110
tests.each do |test|
	temp_int = 0
	current_index = 0
	while current_index < test.length do
		if test.chars.to_a[current_index] == "(" then
			current_index += 1
			(current_index..test.length).each do |i|

				if test[i,1] == ")" then
					current_index = i + 1
					break
				else
					temp_int += mapping[test[i,1]] if not mapping[test[i,1]].nil?
				end
			end
		else
			temp_int += mapping[test[current_index,1]] if not mapping[test[current_index,1]].nil?
			current_index += 1
		end				
		temp_int <<= number_of_unique_charaters
	end
	temp_int >>= number_of_unique_charaters
	integer_tests[test] = temp_int
end

# xor and and the word and test, for example:
# 1: abc ->       001 010 100
# 2: (ab)b(bc) -> 011 010 110
# 3: xor 1,2 ->   010 000 010
# and 1,3 ->      000 000 000 -> all zero so the word matches the test
results = []
tests.length.times do |i|
	temp_result = 0
	integer_words.each do |word|
		temp_result += 1 if ( ( integer_tests[tests[i]] ^ word ) & word ) == 0
	end

	results.push "Case ##{i + 1}: #{temp_result}"
end

puts results