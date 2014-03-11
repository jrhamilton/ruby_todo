class Task
  def initialize(description, priority, due_date)
    @description = description
    @done = false
    @priority = priority
    @due_date = due_date
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
