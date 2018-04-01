class N
	attr_reader :n
	def initialize(n)
		@n = n		
	end
end

num = N.new(3)
puts "num: #{num.n}"