require_relative 'GroupsHash.rb'
require 'set'
class Sets
	def initialize
		@all_set = SortedSet.new
		@completed_set = SortedSet.new
		@groups_hash = GroupsHash.new
	end

	def add(task)
		@all_set << task
		@groups_hash.add(task) unless task.group_name.nil?
	end

	def add_completed(task)
		@completed_set << task
		@groups_hash.add_completed task
	end

	def archive
		@all_set.each{|task| @all_set.delete(task) if task.completed?}
		@completed_set.clear
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

	def obtain_completed_list
		@completed_set.dup
	end
end