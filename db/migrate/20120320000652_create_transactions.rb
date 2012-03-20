class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.datetime :timestamp
      t.integer :amount

      t.timestamps
    end
  end
end
