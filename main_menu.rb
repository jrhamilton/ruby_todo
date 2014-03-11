require './lib/task'
require './lib/lists'
require 'date'

#@lists = []

def main_menu
  puts "Press 'add' to add a list, 'mod' to modify a list, 'list' to list all of your lists, or 'done' to view all finished tasks."
  puts "Press 'exit' to exit."
  main_choice = gets.chomp
  case main_choice
    when 'add'
      puts "\n"
      add_list
    when 'mod'
      puts "\n"
      choose_list
    when 'list'
      puts "\n"
      list_lists
    when 'done'
      puts "\n"
      done_tasks
    when 'exit'
      puts "Good-bye!"
  else
    puts "Sorry, that wasn't a valid option."
    puts "\n"
    main_menu
  end
end

def add_list
  puts "\n"
  puts "Enter a category for this list:"
  list_name = gets.chomp
  Category.create(list_name) # not sure about this
  #@@lists << Category.new(list_name)
  puts "\n"
  main_menu
end

def choose_list
  puts "\n"
  puts "Here are your current lists:"
  # @lists is now @@all_categories in class Category
  lists = Category.all
  lists.each.with_index do |list, index|
    puts "#{index+1}: #{list.category}"
  end
  puts "Which list would you like to modify?"
  list_choice = gets.chomp.to_i
  puts "\n"
  modify_list(list_choice - 1)
end

def modify_list(list_choice)
  puts "Enter 'add' to add a task to the list, 'list' to list the tasks, 'sort' for sort your list or 'edit' to edit a task."
  puts "Enter 'mm' for the main menu or 'exit' to Exit"
  task_option = gets.chomp
  case task_option
  when 'add'
    puts "\n"
    add_task(list_choice)
  when 'list'
    puts "\n"
    list_tasks(list_choice)
  when 'sort'
    puts "\n"
    sort_menu(list_choice)
  when 'edit'
    puts "\n"
    edit_task_menu(list_choice)
  when 'mm'
    puts "\n"
    main_menu
  when 'exit'
    puts "Goodbye!"
  else
    puts "Not a valid choice; try again."
    puts "\n"
    modify_list(list_choice)
  end
end

def add_task(list_choice)
  puts "Enter a description of the new task:"
  user_description = gets.chomp
  puts "Enter Priority of this task between 1 and 5"
  priority = gets.chomp.to_i
  while (priority <  1 || priority > 5)
    puts "Invalid priority. Please try another number between 1 and 5."
    priority = gets.chomp.to_i
  end
  puts "Enter the Due Date for this Task in format 'DD/MM/YYYY'."
  due_date_var = gets.chomp
  while !Date.parse(due_date_var)
    puts "Invalid Date format. Please input another Date correctly, fool!"
    due_date_var = gets.chomp
  end
  due_date = Date.parse(due_date_var)
  new_task = Task.create(user_description, priority, due_date)
  lists = Category.all
  lists[list_choice].add_task(new_task)
  puts "Task added.\n\n"
  modify_list(list_choice)
end

def done_menu(list_choice, task_index)
  puts "\n"
  mark_task_done(list_choice, task_index)
  puts "Task marked as done."
  puts "\n"
  modify_list(list_choice)
end

def list_tasks(list_choice)
  puts "Here are all of your open tasks:"
  lists = Category.all
  lists[list_choice].tasks.each do |task|
    if !task.done
      puts "#{task.description}\tPriority: #{task.priority}\tDate: #{task.due_date}"
    end
  end
  puts "\n"
  modify_list(list_choice)
end

def sort_menu(list_choice)
  puts "Sort by: 'desc' for by Description, 'p' for by Priority or 'dd' for Due Date."
  sort_by = gets.chomp
  lists = Category.all
  case sort_by
  when 'desc'
    lists[list_choice].sort_tasks_by_description
    puts "List sorted by Description.  Select 'l' to list sorted list."
    modify_list(list_choice)
  when 'p'
    lists[list_choice].sort_tasks_by_priority
    puts "List sorted by Priority. Select 'l' to list sorted list."
    modify_list(list_choice)
  when 'dd'
    lists[list_choice].sort_tasks_by_due_date
    puts "List sorted by Due Date. Select 'l' to list sorted list."
    modify_list(list_choice)
  else
    puts "Wrong button!"
    sort_menu(list_choice)
  end
end

def edit_task_menu(list_choice)
  puts "\n"
  puts "Here are your tasks:"
  lists = Category.all
  lists[list_choice].tasks.each.with_index do |task, index|
    if !task.done
      puts "#{index+1}: #{task.description}"
    end
  end
  puts "Which task would you like to edit?"
  task_index = gets.chomp.to_i-1
  puts "\n"
  puts "To edit: select 'done' to mark as done,'desc' to give the task a new Description, 'p' to give a new Priority, 'due' to change the Due Date, or 'delete' to delete a task."
  edit_by = gets.chomp
  case edit_by
    when 'done'
      puts "\n"
      done_menu(list_choice, task_index)
    when "desc"
      puts "\n"
      edit_description(list_choice, task_index)
    when "p"
      puts "\n"
      edit_priority(list_choice, task_index)
    when "due"
      puts "\n"
      edit_due_date(list_choice, task_index)
    when 'delete'
      puts "\n"
      delete_task(list_choice, task_index)
    else
      puts "Invalid entry, please select again"
      edit_task_menu(list_choice)
  end
end

def list_lists
  puts "Here are all of your current lists:"
  lists = Category.all
  lists.each do |list|
    puts list.category
  end
  puts "\n\n"
  main_menu
end

def done_tasks
  puts "Here are all of the finished tasks:"
  lists = Category.all
  lists.each do |list|
    list.tasks.each do |task|
      if task.done
        puts "#{task.description}\tPriority: #{task.priority}\tDate: #{task.due_date}"
      end
    end
  end
  puts "\n"
  main_menu
end

def edit_description(list_choice, task_index)
  puts "\n"
  puts "What would you like its new description to be?"
  new_description = gets.chomp
  lists = Category.all
  lists[list_choice].tasks[task_index].edit_description(new_description)
  puts "\n"
  modify_list(list_choice)
end

def edit_priority(list_choice, task_index)
  puts "\n"
  puts "What would you like its new priority to be?"
  new_priority = gets.chomp
  lists = Category.all
  lists[list_choice].tasks[task_index].edit_priority(new_priority)
  puts "\n"
  modify_list(list_choice)
end

def edit_due_date(list_choice, task_index)
  puts "\n"
  puts "What would you like its new due date to be?"
  new_due_date = gets.chomp
  lists = Category.all
  lists[list_choice].tasks[task_index].edit_due_date(new_due_date)
  puts "\n"
  modify_list(list_choice)
end

def delete_task(list_choice, task_index)
  puts "\n"
  lists = Category.all
  lists[list_choice].tasks.delete_at(task_index)
  modify_list(list_choice)
end

main_menu
