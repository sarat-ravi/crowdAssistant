class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :age
      t.string :gender
      t.string :pic_url
      t.string :address
      t.string :phonenum

      t.timestamps
    end
  end
end
