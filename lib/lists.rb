#require 'task'

class Category
  @@all_categories = []

  def Category.all
    @@all_categories
  end

  def Category.clear
    @@all_categories = []
  end

  def Category.create(category)
    new_category = Category.new(category)
    new_category.save
    new_category
  end

  def initialize(category)
    @category = category
    @tasks = []
  end

  def save
    @@all_categories << self
  end

  def get_category(choice)
    @@all_categories[choice - 1]
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
