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

	def archive
		@groups_hash.each_key{|key| groups_hash[key].archive}
	end
end