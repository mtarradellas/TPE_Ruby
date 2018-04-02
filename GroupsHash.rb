class GroupsHash
	
	def initialize
		@groups_hash = Hash.new
	end

	def add(task)
		if @groups_hash.key? task.group_name
			@groups_hash[task.group_name] << task 
		else 
			new_group = SortedSet.new
			new_group << task
			@groups_hash[task.group_name] = new_group
		end
	end

	def archive
		@groups_hash.each_value{|group| group.delete_if{|task| task.completed?}}
	end

	def format_group(group_name)
		format_string = group_name[1..-1] + "\n"
		@groups_hash[group_name].each{|task| format_string = format_string + task.format_group unless task.completed?}
		@groups_hash[group_name].each{|task| format_string = format_string + task.format_group if task.completed?}
		format_string
	end

	def obtain_groups_list
		@groups_hash.keys.dup
	end

	def dup
		copy = GroupsHash.new
		copy.groups_hash = @groups_hash
		copy
	end

	protected def groups_hash= (other_groups_hash)
		other_groups_hash.each_pair{|group_name, group_set| @groups_hash[group_name] = group_set.dup}		
	end
end
