class Group
	attr_reader :group_name, :tasks, :completed_tasks
	def initialize(group_name)
		@group_name = group_name
		@tasks = SortedSet.new
		@completed_tasks = SortedSet.new
	end

	def add(task)
		@tasks << task
	end

	def add_completed(task)
		@completed_tasks << task
	end

	def archive
		@tasks.each{|task| @tasks.delete(task) if task.completed?}
		@completed_tasks.clear	
	end
end
