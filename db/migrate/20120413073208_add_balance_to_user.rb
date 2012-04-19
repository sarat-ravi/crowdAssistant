class AddBalanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :balance, :integer, :default => 100
  end
end
