class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :ccn
      t.string :ipaddr

      t.timestamps
    end
  end
end
