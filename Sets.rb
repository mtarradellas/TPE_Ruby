require_relative 'GroupsHash.rb'
require 'set'
class Sets

	def initialize
		@all_set = SortedSet.new
		@groups_hash = GroupsHash.new
	end

	def add(task)
		@all_set << task
		@groups_hash.add(task) unless task.group_name.nil?
	end

	def archive
		@all_set.delete_if{|task| task.completed?}
		@groups_hash.archive
	end

	def obtain_all_list
		@all_set.dup
	end

	def obtain_groups_list
		@groups_hash.obtain_groups_list
	end

	def format_group(group_name)
		@groups_hash.format_group group_name
	end

	def dup
		copy = Sets.new
		copy.all_set = @all_set.dup
		copy.groups_hash = @groups_hash.dup
		copy
	end

	protected def all_set= (other_all_set)
		@all_set = other_all_set
	end

	protected def groups_hash= (other_groups_hash)
		@groups_hash = other_groups_hash
	end
end