class DatesIterator
	attr_reader :each
	
	def initialize(dates_list)
		@enum = dates_list.each
		@each = Enumerator.new do |y|
			idx = 0
			loop do
				if dates_list.size == idx
					y << false
				else 
					y << @enum.next
					idx += 1
				end
			end
		end
	end
end