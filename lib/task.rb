class Task
  @@all_tasks = []

  def Task.all
    @@all_tasks
  end

  def Task.clear
    @@all_tasks = []
  end

  def Task.create(description, priority, due_date)
    new_task = Task.new(description, priority, due_date)
    new_task.save
    new_task
  end

  # end cheat

  def save
    @@all_tasks << self
  end

  def mark_task_done(category_choice, task_index)
    category = Category.get_category(category_choice)
    category.tasks[task_index].mark_done
  end

  def initialize(description, priority, due_date)
    @description = description
    @priority = priority
    @due_date = due_date
    @done = false
  end

  def description
    @description
  end

  def priority
    @priority
  end

  def due_date
    @due_date
  end

  def mark_done
    @done = true
  end

  def done
    @done
  end

  def edit_description(new_description)
    @description = new_description
  end

  def edit_priority(new_priority)
    @priority = new_priority
  end

  def edit_due_date(new_due_date)
    @due_date = new_due_date
  end

end
