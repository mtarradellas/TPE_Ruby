require_relative 'TaskManager.rb'
require_relative 'Commands.rb'
task_manager = TaskManager.new
command_manager = Commands.new
while (command = gets.chomp)!= "exit"
	command_manager.analize(command)
	action = command_manager.obtain_command
	case action
	when Commands::ADD
		date = command_manager.obtain_date
		group = command_manager.obtain_group
		task = command_manager.obtain_string
		task_manager.add(task, date, group)
	when Commands::COMPLETE
		id = command_manager.obtain_string.to_i
		task_manager.complete(id)
	when Commands::LIST_ALL
		all_list = task_manager.obtain_all_list
		completed_list = task_manager.obtain_completed_list
		all_list.each{|task| puts task.format_all unless task.completed?}
		completed_list.each{|task| puts task.format_all}
	when Commands::LIST_GROUPS
	 	groups_list = task_manager.obtain_groups_list
	 	groups_list.each{|group_name| puts task_manager.format_group group_name }
	when Commands::LIST_A_GROUP
	 	group_name = command_manager.obtain_string
	 	puts task_manager.format_group group_name
	when Commands::LIST_THIS_WEEK
		dates_list = task_manager.obtain_dates_list
		dates_list.each{|task| puts task.format_all if task.due_date >= Date.today && task.due_date.cwday <= 6}
	when Commands::LIST_OVERDUE
	 	dates_list = task_manager.obtain_dates_list
	 	dates_list.each{|task| puts task.format_all if task.due_date < Date.today && !task.completed?}
	 	dates_list.each{|task| puts task.format_all if task.due_date < Date.today && task.completed?}	
	when Commands::LIST_DATE
		date = command_manager.obtain_date
	 	dates_list = task_manager.obtain_dates_list
	 	dates_list.each{|task| puts task.format_all if task.due_date == date && !task.completed?}
	 	dates_list.each{|task| puts task.format_all if task.due_date == date && task.completed?}	
	when Commands::ARCHIVE
		task_manager.archive
	end
end
