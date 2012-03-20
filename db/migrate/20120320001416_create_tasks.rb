class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :job_id
      t.datetime :task_date
      t.string :status
      t.string :response

      t.timestamps
    end
  end
end
