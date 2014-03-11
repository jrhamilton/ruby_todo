require 'rspec'
require 'task'
require 'lists'

describe List do
  it 'is initialized with a category' do
    test_list = List.new('zebra tasks')
    test_list.should be_an_instance_of List
  end

  it 'adds tasks to the @tasks array' do
    test_task = Task.new('scrub the zebra', 2, "1/1/2013")
    test_list = List.new('zebra chores')
    test_list.add_task(test_task)
    test_array = []
    test_array << test_task
    test_list.tasks.should eq test_array
  end

  it 'should sort tasks by priority' do
    test_task1 = Task.new('scrub the zebra', 2, "12/12/2013")
    test_task2 = Task.new('dry the zebra', 1, "12/12/2013")
    test_task3 = Task.new('rinse the zebra', 3, "12/12/2013")
    test_list = List.new('zebra chores')
    test_list.add_task(test_task1)
    test_list.add_task(test_task2)
    test_list.add_task(test_task3)
    test_list.sort_tasks_by_priority
    test_list.tasks.should eq([test_task2, test_task1, test_task3])
  end

  it 'should sort tasks by description' do
    test_task1 = Task.new('scrub the zebra', 2, "12/12/2013")
    test_task2 = Task.new('dry the zebra', 1, "12/12/2013")
    test_task3 = Task.new('rinse the zebra', 3, "12/12/2013")
    test_list = List.new('zebra chores')
    test_list.add_task(test_task1)
    test_list.add_task(test_task2)
    test_list.add_task(test_task3)
    test_list.sort_tasks_by_description
    test_list.tasks.should eq([test_task2, test_task3, test_task1])
  end

  it 'should sort tasks by due date' do
    test_task1 = Task.new('scrub the zebra', 2, "12/13/2013")
    test_task2 = Task.new('dry the zebra', 1, "12/12/2013")
    test_task3 = Task.new('rinse the zebra', 3, "12/11/2013")
    test_list = List.new('zebra chores')
    test_list.add_task(test_task1)
    test_list.add_task(test_task2)
    test_list.add_task(test_task3)
    test_list.sort_tasks_by_due_date
    test_list.tasks.should eq([test_task3, test_task2, test_task1])
  end
end
