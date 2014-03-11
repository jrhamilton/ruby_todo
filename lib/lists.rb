#require 'task'

class List
  def initialize(category)
    @category = category
    @tasks = []
  end

  def category
    @category
  end

  def add_task(task)
    @tasks << task
  end

  def tasks
    @tasks
  end

  def sort_tasks_by_priority
    @tasks.sort! { |x,y| x.priority <=> y.priority }
  end

  def sort_tasks_by_description
    @tasks.sort! { |x,y| x.description <=> y.description }
  end

  def sort_tasks_by_due_date
    @tasks.sort! { |x,y| x.due_date <=> y.due_date }
  end

  def delete(task)
    @tasks.delete(task)
  end
end
