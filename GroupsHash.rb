require_relative 'Group.rb'
class GroupsHash
	
	def initialize
		@groups_hash = Hash.new
	end

	def add(task)
		if @groups_hash.key? task.group_name
			@groups_hash[task.group_name].add(task) 
		else 
			new_group = Group.new(task.group_name)
			new_group.add(task)
			@groups_hash[task.group_name] = new_group
		end
	end

	def add_completed(task)
		@groups_hash[task.group_name].add_completed (task) if @groups_hash.key? task.group_name
	end

	def archive
		@groups_hash.each_key{|group| @groups_hash[group].archive}
	end

	def format_group(group_name)
		format_string = group_name[1..-1] + "\n"
		@groups_hash[group_name].tasks.each{|task| format_string = format_string + task.format_group unless task.completed?}
		@groups_hash[group_name].completed_tasks.each{|task| format_string = format_string + task.format_group}
		format_string
	end

	def obtain_groups_list
		@groups_hash.keys.dup
	end
end