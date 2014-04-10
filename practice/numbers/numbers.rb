lines = File.readlines('C-small-practice.in')

T = lines[0].to_i

test_cases = lines[1..-1].map {|x| x.to_i }

constant = 3 + Math.sqrt(5)


def exp(x, n)
	return 1 if n == 0
	return x if n == 1
	return exp((x ** 2).modulo(1000), n / 2) if n % 2 == 0
	return (x.modulo(1000) * exp((x ** 2).modulo(1000), (n-1)/2))
end

test_cases.length.times do |i|
	result = exp(constant, test_cases[i]).modulo(1000).to_i
	puts "Case ##{i+1}: #{result.to_s.rjust(3, '0')}"
end

