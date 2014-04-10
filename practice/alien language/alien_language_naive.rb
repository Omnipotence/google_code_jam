lines = File.readlines('A-large-practice.in')

L, D, N = lines[0].split.map {|x| x.to_i }
words = lines[1..D].map {|x| x.strip }
tests = lines[D+1..D+1+N].map {|x| x.strip }

tests.length.times do |i|
	test = tests[i]
	number_of_matches = 0
	regex = ""
	current_index = 0
	while current_index < test.length do
		if test.chars.to_a[current_index] == "(" then
			next_index = test.index(")", current_index)
			regex += "(#{test[current_index + 1..next_index-1].split("").join("|")})"
			current_index = next_index + 1
		else
			regex += test[current_index,1]
			current_index += 1
		end				
	end
	full_regex = /#{regex}/
	words.each do |word|
		number_of_matches += 1 if !!(word =~ full_regex)
	end

	puts "Case ##{i+1}: #{number_of_matches}"

end