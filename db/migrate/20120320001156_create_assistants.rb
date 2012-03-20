class CreateAssistants < ActiveRecord::Migration
  def change
    create_table :assistants do |t|
      t.string :type

      t.timestamps
    end
  end
end
