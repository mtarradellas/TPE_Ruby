require 'yaml'
require_relative 'TaskManager.rb'
require_relative 'Commands.rb'
task_manager = TaskManager.new
command_manager = Commands.new

def save_file(file_name, task_manager)
	File.open("#{file_name}", "w") { |file| file.write(task_manager.to_yaml)}
end

def open_file(file_name)
	YAML.load(File.read("#{file_name}"))
end

while (command = (command = gets).gsub(/\s+/, " ").strip) != "exit"
	command_manager.analize command
	action = command_manager.obtain_command
	case action
	when Commands::ADD
		date = command_manager.obtain_date
		group = command_manager.obtain_group
		task = command_manager.obtain_string
		id = task_manager.add(task, date, group)
		puts "Todo [#{id}: #{task}] added."
	when Commands::COMPLETE
		id = command_manager.obtain_string.to_i
		task = task_manager.complete id
		puts "Todo [#{id}: #{task}] completed."
	when Commands::LIST_ALL
		all_list = task_manager.obtain_all_list
		puts "All"
		all_list.each{|task| puts task.format_all unless task.completed?}
		all_list.each{|task| puts task.format_all if task.completed?}
	when Commands::LIST_GROUPS
	 	groups_list = task_manager.obtain_groups_list
	 	groups_list.each{|group_name| puts task_manager.format_group group_name }
	when Commands::LIST_A_GROUP
	 	group_name = command_manager.obtain_string
	 	puts task_manager.format_group group_name
	when Commands::LIST_THIS_WEEK
		dates_list = task_manager.obtain_dates_list
		dates_list = dates_list.delete_if{|task| task.due_date < Date.today}
		enum = dates_list.each
		puts "All"		
		until (task = enum.next).due_date.cwday == 7
			puts task.format_all unless task.completed?
		end
		enum = dates_list.each
		until (task = enum.next).due_date.cwday == 7
			puts task.format_all if task.completed?
		end		
	when Commands::LIST_OVERDUE
	 	dates_list = task_manager.obtain_dates_list
		puts "All"	 	
	 	dates_list.each{|task| puts task.format_all if task.due_date < Date.today && !task.completed?}
	 	dates_list.each{|task| puts task.format_all if task.due_date < Date.today && task.completed?}	
	when Commands::LIST_DATE
		date = command_manager.obtain_date
	 	dates_list = task_manager.obtain_dates_list
	 	puts "All"
	 	dates_list.each{|task| puts task.format_all if task.due_date == date && !task.completed?}
	 	dates_list.each{|task| puts task.format_all if task.due_date == date && task.completed?}	
	when Commands::ARCHIVE
		task_manager.archive
		puts "All completed todos have been archived!"
	when Commands::SAVE
		file = command_manager.obtain_string
		save_file(file, task_manager)
		puts "File save successful!"
	when Commands::OPEN
		file = command_manager.obtain_string
		task_manager = open_file file
		puts "#{file} file opened"
	end

end
