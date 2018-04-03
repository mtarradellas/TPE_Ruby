class Task
	attr_reader :due_date, :id, :group_name, :completed, :task_name
	def initialize(task_name, id, due_date, group_name)
		@task_name = task_name
		@due_date = due_date
		@group_name = group_name
		@completed = nil
		@id = id
	end

	def complete
		@completed = 'X'
	end

	def completed?
		@completed == 'X'
	end

	def <=>(other)
		if @due_date.nil?
			return @id <=> other.id if other.due_date.nil?
			return -1
		end 
		return @due_date <=> other.due_date unless other.due_date.nil?
		return 1 
	end

	def format_date
		return " " if @due_date.nil?
		"#{format('%02d',@due_date.day)}/#{format('%02d',@due_date.month)}/#{@due_date.year}"
	end

	def format_all
		"#{format('%-3s',@id)}  [#{@completed}]  #{format('%-10s',format_date)}  #{format('%-10s',@group_name)}  #{@task_name}"
	end

	def format_group
		"#{format('%-3s',@id)}  [#{@completed}]  #{format('%-10s',format_date)}  #{@task_name}\n"		
	end

end
