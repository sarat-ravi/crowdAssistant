class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.datetime :task_date
      t.string :task
      t.string :status
      t.string :response

      t.timestamps
    end
  end
end
