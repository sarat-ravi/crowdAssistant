class AddPathToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :path, :string
  end
end
