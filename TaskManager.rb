require_relative 'Sets.rb'
require_relative 'Task.rb'
class TaskManager

	def initialize
		@tasks_hash = Hash.new
		@sets = Sets.new
		@id_counter = 0
	end

	def add(task_name, due_date, group_name)
		@id_counter += 1
		@tasks_hash[@id_counter] = Task.new(task_name, @id_counter, due_date, group_name)
		@sets.add(@tasks_hash[@id_counter]) 
	end

	def obtain_all_list
		@sets.obtain_all_list
	end

	def obtain_groups_list
		groups_list = @sets.obtain_groups_list
	end

	def complete(id)
		raise InvalidID unless @tasks_hash.key? id
		@tasks_hash[id].complete
		@sets.add_completed(@tasks_hash[id])
	end

	def archive
		@sets.archive
	end
end