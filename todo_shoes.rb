require 'app_wrapper'
require './lib/task'
require './lib/lists'
require 'date'

class SimpleApp < ShoesAppWrapper

  url '/', :main_menu
  url '/add_list', :add_list
  url '/modify_list', :modify_list
  url '/list_lists', :list_lists
  url '/done_tasks', :done_tasks

  @lists = []
  #@lists << "category"

  def main_menu
    @shoes.button("Add a List") do
      visit('/add_list')
    end
    @shoes.button("Modify a List") do
      visit('/modify_list')
    end
    @shoes.button("List Lists") do
      visit('/list_lists')
    end
    @shoes.button("Done Tasks") do
      visit('/done_tasks')
    end
    # if @lists.length > 0
    #   @lists.each do |list|
    #     @shoes.para("#{list}")
    #   end
    # end
  end

  def add_list
    @shoes.para("Add a list.")
    @e = @shoes.edit_line :width => 300
    @shoes.button("Go back!") do
      @lists << List.new(@e.text)
      visit('/')
    end
  end

  def modify_list
    @shoes.button("Go back!") do
      visit('/')
    end
  end

  def list_lists
    @shoes.button("Go back!") do
      visit('/')
    end
  end

  def done_tasks
    @shoes.button("Go back!") do
      visit('/')
    end
  end

end


Shoes.app(:width => 400, :height => 400){ @app = SimpleApp.new(self) }
