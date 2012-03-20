class CreateMobworkers < ActiveRecord::Migration
  def change
    create_table :mobworkers do |t|
      t.string :api_id
      t.integer :assistant_id
      t.string :rating
      t.string :skill

      t.timestamps
    end
  end
end
