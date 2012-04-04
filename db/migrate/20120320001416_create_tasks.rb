class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.datetime :task_date
      t.string :status
      t.string :answer
      t.string :resource
      t.string :resourcetype
      t.integer :priority, :default => 1
      t.string :workflow, :default => "p"
      t.integer :redundancy, :default => 2
      t.string :instructions
      t.string :fields

      t.timestamps
    end
  end
end
