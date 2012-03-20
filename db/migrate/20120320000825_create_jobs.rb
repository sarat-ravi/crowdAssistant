class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.integer :assistant_id
      t.datetime :job_date

      t.timestamps
    end
  end
end
