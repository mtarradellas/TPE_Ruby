class Group
	attr_reader :group_name, :tasks, :completed_tasks
	def initialize(group_name)
		@group_name = group_name
		@tasks = SortedSet.new
	end

	def add(task)
		@tasks << task
	end

	def archive
		@tasks.each{|task| @tasks.delete(task) if task.completed?}
	end

	def dup
		copy = Group.new
		copy.group_name = @group_name
		copy.tasks = @tasks.dup
		copy
	end

	protected def group_name= (other_group_name)
		@group_name = other_group_name
	end

	protected def tasks= (other_tasks)
		@tasks = other_tasks
	end
	
end
